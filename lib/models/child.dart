//enum Gender { male, female }

import 'package:uuid/uuid.dart';

class Child {
  Child(
      {required this.name,
      required this.gender,
      required this.birthday,
      required this.responsible})
      : id = const Uuid().v4();

  final String id;
  final String name;
  final String gender;
  final String birthday;
  final String responsible;
}
