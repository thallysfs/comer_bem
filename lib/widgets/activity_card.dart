import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onPressed;

  const ActivityCard(
      {super.key,
      required this.name,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
