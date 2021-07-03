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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TinyColor2 Example"),
      ),
      body: SingleChildScrollView(
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
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[0] = _tinyColors[0].lighten(value.toInt()));
              },
              color: _tinyColors[0].color,
            ),
            ApplyMethodItem(
              name: "brighten",
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[1] = _tinyColors[1].brighten(value.toInt()));
              },
              color: _tinyColors[1].color,
            ),
            ApplyMethodItem(
              name: "darken",
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[2] = _tinyColors[2].darken(value.toInt()));
              },
              color: _tinyColors[2].color,
            ),
            ApplyMethodItem(
              name: "tint",
              onButtonPressed: (value) {
                setState(
                    () => _tinyColors[3] = _tinyColors[3].tint(value.toInt()));
              },
              color: _tinyColors[3].color,
            ),
            ApplyMethodItem(
              name: "shade",
              onButtonPressed: (value) {
                setState(
                    () => _tinyColors[4] = _tinyColors[4].shade(value.toInt()));
              },
              color: _tinyColors[4].color,
            ),
            ApplyMethodItem(
              name: "desaturate",
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[5] = _tinyColors[5].desaturate(value.toInt()));
              },
              color: _tinyColors[5].color,
            ),
            ApplyMethodItem(
              name: "saturate",
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[6] = _tinyColors[6].saturate(value.toInt()));
              },
              color: _tinyColors[6].color,
            ),
            ApplyMethodItem(
              name: "spin",
              defaultValue: 10.0,
              onButtonPressed: (value) {
                setState(() =>
                    _tinyColors[7] = _tinyColors[7].spin(value.toDouble()));
              },
              color: _tinyColors[7].color,
            ),
          ],
        ),
      ),
    );
  }

  _initTinyColors() =>
      _tinyColors = List.generate(8, (index) => TinyColor(_color));
}
