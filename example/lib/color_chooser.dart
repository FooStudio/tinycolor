import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class ColorChooser extends StatefulWidget {
  final Function(Color)? onColorChange;

  const ColorChooser({
    Key? key,
    this.onColorChange,
  }) : super(key: key);

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  final List<String> _selectableColors = [
    "red",
    "green",
    "blue",
    "yellow",
    "orange",
    "black",
    "white",
    "gray",
  ];
  late String _color;

  @override
  void initState() {
    _color = _selectableColors.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text("Choose color:"),
          SizedBox(height: 8),
          CircleAvatar(backgroundColor: Pigment.fromString(_color)),
          DropdownButton<String>(
            value: _color,
            items: _selectableColors
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: (value) {
              setState(() {
                _color = value!;
              });
              widget.onColorChange?.call(Pigment.fromString(_color));
            },
          ),
        ],
      ),
    );
  }
}
