import 'package:flutter/material.dart';

class RecordSimpleCard extends StatelessWidget {
  final String foodNumber;
  final String skillNumber;

  const RecordSimpleCard(
      {super.key, required this.foodNumber, required this.skillNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.restaurant,
                  size: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  foodNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(
                  Icons.emoji_objects_outlined,
                  size: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  skillNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
