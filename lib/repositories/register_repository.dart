import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comer_bem/database/db_firestore.dart';
import 'package:comer_bem/models/register.dart';
import 'package:comer_bem/service/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;
  final String _collection = 'registers';

  RegisterRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    db = DbFirestore.get();
  }

  Future<void> save(Register register) async {
    await db.collection(_collection).add({
      'idChild': register.idChild,
      'type': register.type.toString(),
      'idUser': auth.user!.uid,
      'descriptionRegister': register.descriptionRegister,
      'createdAt': register.createdAt
    });

    notifyListeners();
  }
}
