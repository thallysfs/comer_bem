import 'package:comer_bem/widgets/bar_graph/my_bar_graph.dart';
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
  late DateTimeRange? _range;
  Widget grafico = Container();
  var _isLoading = false;
  // TODO alimentar com os dados dos meses
  List<double> amountMonthFood = [5, 3, 4, 8, 12, 1, 7, 6, 8, 11, 4, 2];

  @override
  void initState() {
    super.initState();
    _range = DateTimeRange(
      start: DateTime.now(),
      end: DateTime(2024, 12, 31),
    );
  }

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDateRangePicker(
            context: context,
            firstDate: firstDate,
            lastDate: now,
            saveText: "SALVAR")
        .then((value) {
      setState(() {
        _range = value;
        print(_range);
      });
    });
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
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const RecordSimpleCard(foodNumber: '6', skillNumber: '9'),
                Row(
                  children: [
                    const Text(
                      'Selecione uma data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // calendar
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Alimentos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(
              height: 35,
            ),
            // Gráfico comida
            Center(
              child: SizedBox(
                height: 200,
                child: MyBarGraph(
                  monthSummary: amountMonthFood,
                  colorBar: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            //Gráfico habilidades
            Divider(),
            const SizedBox(height: 25),
            const Text(
              'Habilidades',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: SizedBox(
                height: 200,
                child: MyBarGraph(
                    monthSummary: amountMonthFood,
                    colorBar: Colors.green.shade100),
              ),
            ),
            //TODO CardRecordWithDetails a partir do calendário
            // TODO botões
          ]),
        ));
  }
}
