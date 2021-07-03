import 'package:example/widgets/apply_method_item.dart';
import 'package:example/widgets/color_chooser.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor.dart';

void main() {
  runApp(TinyColorApp());
}

class TinyColorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  ExamplePage({Key? key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  Color _color = Colors.red;
  late List<TinyColor> _tinyColors;

  @override
  void initState() {
    _initTinyColors();
    super.initState();
  }

  _initTinyColors() =>
      _tinyColors = List.generate(4, (index) => TinyColor(_color));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TinyColor2 Example"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ColorChooser(
              initialColor: _color,
              onColorChange: (color) {
                setState(() {
                  _color = color;
                  _initTinyColors();
                });
              },
            ),
            ApplyMethodItem(
              name: "lighten",
              defaultValue: 10,
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[0] = _tinyColors[0].lighten(value.toInt()));
              },
              color: _tinyColors[0].color,
            ),
            ApplyMethodItem(
              name: "brighten",
              defaultValue: 10,
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[1] = _tinyColors[1].brighten(value.toInt()));
              },
              color: _tinyColors[1].color,
            ),
            ApplyMethodItem(
              name: "darken",
              defaultValue: 10,
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[2] = _tinyColors[2].darken(value.toInt()));
              },
              color: _tinyColors[2].color,
            ),
            ApplyMethodItem(
              name: "tint",
              defaultValue: 10,
              onButtonPressed: (value) {
                setState(
                    () => _tinyColors[3] = _tinyColors[3].tint(value.toInt()));
              },
              color: _tinyColors[3].color,
            ),
          ],
        ),
      ),
    );
  }
}
