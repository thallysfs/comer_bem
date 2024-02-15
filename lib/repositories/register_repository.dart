import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comer_bem/database/db_firestore.dart';
import 'package:comer_bem/models/register.dart';
import 'package:comer_bem/service/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterRepository extends ChangeNotifier {
  List<Register> _registerList = [];
  late FirebaseFirestore db;
  late AuthService auth;
  final String _collection = 'registers';

  RegisterRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    db = DbFirestore.get();
  }

  Future<List<Register>?> findOneChildrenRegister(
      String idChild, int year) async {
    //final initialDate = DateTime(year, 1, 1);
    //final finalDate = DateTime(year, 2, 28);
    _registerList = [];
    if (auth.user != null) {
      final snapshot = await db
          .collection(_collection)
          .where('idUser', isEqualTo: auth.user!.uid)
          .where('idChild', isEqualTo: idChild)
          //.where('createdAt', isGreaterThanOrEqualTo: initialDate)
          //.where('createdAt', isLessThanOrEqualTo: finalDate)
          .get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Register register = Register(
          descriptionRegister: data['descriptionRegister'],
          type: data['type'],
          idChild: data['idChild'],
          createdAt: data['createdAt'],
        );
        _registerList.add(register);
      }
    }
    notifyListeners();
  }

  List<Register>? get registerValue => _registerList;

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
