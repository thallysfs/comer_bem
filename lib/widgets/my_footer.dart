import 'package:flutter/material.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Feito por Thallys',
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
          Text(
            'thallys@hotmail.com',
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
