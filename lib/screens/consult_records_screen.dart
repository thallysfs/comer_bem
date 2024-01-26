import 'package:comer_bem/widgets/dropdown_children.dart';
import 'package:comer_bem/widgets/record_simple_card.dart';
import 'package:flutter/material.dart';

class ConsultRecordsScreen extends StatefulWidget {
  const ConsultRecordsScreen({super.key});

  @override
  State<ConsultRecordsScreen> createState() => _ConsultRecordsScreenState();
}

class _ConsultRecordsScreenState extends State<ConsultRecordsScreen> {
  String? _selectedChild;
  var _isLoading = false;
  late DateTimeRange _range;

  @override
  void initState() {
    super.initState();
    _range = DateTimeRange(
      start: DateTime.now(),
      end: DateTime(2024, 12, 31),
    );
  }

  void _genereteRecord() {
    setState(() {
      _isLoading = true;
    });

    // Validar idChild
    if (_selectedChild == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecione uma criança."),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consultar evolução alimentar'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 20,
            left: 25,
            right: 25,
          ),
          child: Column(children: [
            // dropdowbnChild
            DropdownChildren(
              onChildSelected: (value) {
                setState(() {
                  _selectedChild = value;
                });
              },
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const RecordSimpleCard(foodNumber: '6', skillNumber: '9'),
                Expanded(
                  child: Row(
                    children: [
                      const Text('Selecione um período'),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    ],
                  ),
                )
              ],
            ),
            //TODO Gráfico que gera dados a partir do calendário
            //TODO CardRecordWithDetails
            // TODO botões
          ]),
        ));
  }
}
