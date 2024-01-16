import 'package:comer_bem/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:comer_bem/widgets/my_footer.dart';
import 'package:provider/provider.dart';

final _firebase = FirebaseAuth.instance;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // Essa chave é passada dentro do formulário e através dela terei acesso a todos
  //os dados do formulário
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUserName = '';
  var _isLoading = false;

  void _submit() async {
    // o método vaidate retorna um booleno
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    // essa função ativa o onSave que interage com todos os textField
    _form.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });

      if (_isLogin) {
        // log user in
        try {
          await context
              .read<AuthService>()
              .login(_enteredEmail, _enteredPassword);
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        try {
          // register user
          final userCredentials = await context
              .read<AuthService>()
              .register(_enteredEmail, _enteredPassword);
          //salvar dados de usuário no firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredentials.user!.uid)
              .set({
            'username': _enteredUserName,
            'email': _enteredEmail,
          });
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
      // o on antes define o tipo da excessão, isso deixa o código do erro igual ao da documentação do Firebase
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Falha na autenticação'),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // imagem
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 90,
                height: 87,
                child: Image.asset('assets/images/logo.png'),
              ),
              // Form text fields and buttons
              const Text(
                'Acessar a conta',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isLogin)
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Nome'),
                          enableSuggestions: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 4) {
                              return 'Por favor use um nome válido (pelo menos 4 caracteres)';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredUserName = newValue!;
                          },
                        ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Endereço de e-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Por favor use um e-mail válido';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Senha precisa ter pelo menos 6 caracteres';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                      ),
                      const SizedBox(height: 25),
                      if (_isLoading) const CircularProgressIndicator(),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          // backgroundColor:
                          //     Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(297, 40),
                        ),
                        child: Text(
                          _isLogin ? 'Login' : 'Cadastrar',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      if (!_isLoading)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Criar uma conta'
                              : 'Já tenho uma conta'),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.bottomCenter,
                child: MyFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
