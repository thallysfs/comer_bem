import 'package:comer_bem/widgets/bar_graph/individual_bar.dart';

class BarData {
  final double janAmount;
  final double fevAmount;
  final double marAmount;
  final double abrAmount;
  final double maiAmount;
  final double junAmount;
  final double julAmount;
  final double agoAmount;
  final double setAmount;
  final double outAmount;
  final double novAmount;
  final double dezAmount;

  BarData({
    required this.janAmount,
    required this.fevAmount,
    required this.marAmount,
    required this.abrAmount,
    required this.maiAmount,
    required this.junAmount,
    required this.julAmount,
    required this.agoAmount,
    required this.setAmount,
    required this.outAmount,
    required this.novAmount,
    required this.dezAmount,
  });

  List<IndividualBar> barData = [];

  //iitial bar data
  void initializeBarData() {
    barData = [
      // jan
      IndividualBar(x: 1, y: janAmount),
      // fev
      IndividualBar(x: 2, y: fevAmount),
      // mar
      IndividualBar(x: 3, y: marAmount),
      // abr
      IndividualBar(x: 4, y: abrAmount),
      // mai
      IndividualBar(x: 5, y: maiAmount),
      // jun
      IndividualBar(x: 6, y: junAmount),
      // jul
      IndividualBar(x: 7, y: julAmount),
      // ago
      IndividualBar(x: 8, y: agoAmount),
      // set
      IndividualBar(x: 9, y: setAmount),
      // out
      IndividualBar(x: 10, y: outAmount),
      // nov
      IndividualBar(x: 11, y: novAmount),
      // dez
      IndividualBar(x: 12, y: dezAmount),
    ];
  }
}
