import 'package:flutter/material.dart';

class ApplyMethodItem extends StatefulWidget {
  final String name;
  final num defaultValue;
  final Function(num) onButtonPressed;
  final Color color;

  const ApplyMethodItem({
    Key? key,
    required this.name,
    required this.onButtonPressed,
    required this.color,
    this.defaultValue = 10,
  }) : super(key: key);

  @override
  _ApplyMethodItemState createState() => _ApplyMethodItemState();
}

class _ApplyMethodItemState extends State<ApplyMethodItem> {
  late num _value;

  @override
  void initState() {
    _value = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            decoration:
                InputDecoration(hintText: widget.defaultValue.toString()),
            onChanged: (value) =>
                _value = num.tryParse(value) ?? widget.defaultValue,
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
              child: Text("Apply ${widget.name}"),
              onPressed: () => widget.onButtonPressed(_value)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(backgroundColor: widget.color),
        ),
      ],
    );
  }
}
