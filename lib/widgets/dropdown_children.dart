import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comer_bem/repositories/child_repository.dart';
import 'package:flutter/material.dart';

class DropdownChildren extends StatefulWidget {
  final Function(String?)?
      onChildSelected; // Adicionado o parâmetro onChildSelected

  const DropdownChildren({super.key, this.onChildSelected});

  @override
  State<DropdownChildren> createState() => _DropdownChildrenState();
}

class _DropdownChildrenState extends State<DropdownChildren> {
  late ChildRepository childRepository;
  String? selectedChild;

  // começando o widget lendo os dados de child
  @override
  void initState() {
    super.initState();

    selectedChild = "0";
  }

  // widget principal que possui condicional para chamar o buildDropdown
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('children').snapshots(),
            builder: (context, snapshot) {
              // declarando uma variável para usar no dropDown
              List<DropdownMenuItem> childItems = [];
              if (!snapshot.hasData) {
                const CircularProgressIndicator();
              } else {
                final children = snapshot.data?.docs.toList();

                // adicionando a lista de child um item para servir de label
                childItems.add(const DropdownMenuItem(
                  value: "0",
                  child: Text("Selecione o paciente"),
                ));

                for (var child in children!) {
                  childItems.add(
                    DropdownMenuItem(
                      value: child.id,
                      child: Text(child['name']),
                    ),
                  );
                }
              }
              // o dropdown de fato, o que será clicado
              return DropdownButton(
                items: childItems,
                value: selectedChild,
                onChanged: (value) {
                  setState(() {
                    if (value != "0") {
                      selectedChild = value;
                      widget.onChildSelected?.call(value);
                    }
                  });
                },
                isExpanded: false,
              );
            }),
      ],
    );
  }
}
