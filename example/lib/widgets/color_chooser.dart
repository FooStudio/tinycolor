import 'package:flutter/material.dart';

class ColorChooser extends StatefulWidget {
  final Color initialColor;
  final Function(Color)? onColorChange;

  const ColorChooser({
    Key? key,
    required this.initialColor,
    this.onColorChange,
  }) : super(key: key);

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  final Map<String, Color> _selectableColors = {
    "red": Colors.red,
    "green": Colors.green,
    "blue": Colors.blue,
    "yellow": Colors.yellow,
    "orange": Colors.orange,
    "black": Colors.black,
    "white": Colors.white,
    "grey": Colors.grey,
  };
  late Color _color;

  @override
  void initState() {
    _color = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text("Choose color:"),
          DropdownButton<Color>(
            value: _color,
            items: _selectableColors.entries
                .map((e) => DropdownMenuItem(
                    child: Row(
                      children: [
                        CircleAvatar(backgroundColor: e.value, radius: 12),
                        SizedBox(width: 8),
                        Text(e.key),
                      ],
                    ),
                    value: e.value))
                .toList(),
            onChanged: (value) {
              setState(() {
                _color = value!;
              });
              widget.onColorChange?.call(_color);
            },
          ),
        ],
      ),
    );
  }
}
