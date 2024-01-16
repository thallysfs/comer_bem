import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// criando classe de exceção do tipo específico
class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  // checar login
  _authCheck() {
    _auth.authStateChanges().listen((User? userParam) {
      user = userParam;
      isLoading = false;
      // aqui notifico a alteração para quem estiver escutando
      notifyListeners();
    });
  }

  // pegar usuário logado
  _getUser() {
    _auth.currentUser;
    notifyListeners();
  }

  // Registrar no firebase
  register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('E-mail já cadastrado');
      } else {
        throw AuthException(
            'Não foi possível registrar usuário, erro: ${e.code}');
      }
    }
  }

  // Login no firebase
  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('E-mail não foi encontrado');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta');
      } else if (e.code == 'invalid-credential') {
        throw AuthException('E-mail ou senha inválidos');
      } else {
        throw AuthException('Não foi possível realizar login, erro: ${e.code}');
      }
    }
  }

  // realizar log off
  signOut() async {
    await _auth.signOut();
    _getUser();
  }
}
