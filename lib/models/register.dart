// idUser é pego em tempo de execução pelo Firebase
enum TypeRegister { food, skill }

class Register {
  Register(
      {required this.descriptionRegister,
      required this.type,
      required this.idChild,
      required this.createdAt});

  final String descriptionRegister;
  final TypeRegister type;
  final String idChild;
  final String createdAt;
}
