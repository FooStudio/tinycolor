import 'package:flutter/material.dart';

class ApplyMethodItem extends StatelessWidget {
  final String name;
  final VoidCallback onButtonPressed;
  final Color color;

  const ApplyMethodItem({
    Key? key,
    required this.name,
    required this.onButtonPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
              child: Text("Apply $name"), onPressed: onButtonPressed),
        ),
        CircleAvatar(backgroundColor: color),
      ],
    );
  }
}
