import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comer_bem/database/db_firestore.dart';
import 'package:comer_bem/models/child.dart';
import 'package:comer_bem/service/auth_service.dart';
import 'package:flutter/material.dart';

class ChildRepository extends ChangeNotifier {
  final List<Child> _childrenList = [];
  late FirebaseFirestore db;
  // pegar usuário logado
  late AuthService auth;
  final String _collection = 'children';
  // * String _chilSelectedId = '';

  // * get chilSelectedId => _chilSelectedId;

  // construtor
  ChildRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    db = DbFirestore.get();
    _readChild;
  }

  // * void saveSelectedChild(String idChild) {
  //   _chilSelectedId = idChild;
  // }

  Future<List<Child>> get childrenList async {
    return _childrenList;
  }

  Future<void> _readChild() async {
    if (auth.user != null && _childrenList.isEmpty) {
      final snapshot = await db
          .collection(_collection)
          .where('idUser', isEqualTo: auth.user!.uid)
          .get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();

        // Criando uma instância de Child com os dados obtidos
        Child child = Child(
            name: data['name'],
            birthday: data['birthday'],
            responsible: data['responsible'],
            gender: data['gender']);

        // adicionando a lista
        _childrenList.add(child);
        notifyListeners();
      }
    }
  }

  Future<void> save(Child child) async {
    await db.collection(_collection).add({
      'name': child.name,
      'birthday': child.birthday,
      'responsible': child.responsible,
      'gender': child.gender,
      'idUser': auth.user!.uid
    });
    notifyListeners();
  }

  Future<void> remove(Child child) async {
    // TODO remover do firebase
    await db
        .collection(_collection)
        .where('idUser', isEqualTo: auth.user!.uid)
        .where('id', isEqualTo: child.id)
        .get();

    // remover da lista
    _childrenList.remove(child);
    notifyListeners();
  }
}
