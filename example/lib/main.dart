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
                setState(() => _color = color);
              },
            ),
            ApplyMethodItem(
              name: "lighten",
              defaultValue: 10,
              onButtonPressed: (value) {
                setState(() =>
                    _color = TinyColor(_color).lighten(value.toInt()).color);
              },
              color: _color,
            )
          ],
        ),
      ),
    );
  }
}
