import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Radix {
  decimal,
  hexadecimal,
  binary,
}

class _MyHomePageState extends State<MyHomePage> {
  void _updateFields(int value, Radix radix) {
    setState(() {
      if (radix != Radix.decimal) {
        _decimalController.text = value.toRadixString(10);
      }
      if (radix != Radix.hexadecimal) {
        _hexadecimalController.text = value.toRadixString(16);
      }
      if (radix != Radix.binary) {
        _binaryController.text = value.toRadixString(2);
      }
    });
  }

  // TODO defer initialization until .initState()?
  final TextEditingController _decimalController = TextEditingController();
  final TextEditingController _hexadecimalController = TextEditingController();
  final TextEditingController _binaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Table(
        border: TableBorder.all(), // TODO lift this so it's not repeatedly instantiated
        children: <TableRow>[
          const TableRow(children: <Widget>[
            Text('Decimal'),
            Text('Hexadecimal'),
            Text('Binary'),
          ]), // content
          TableRow(children: <Widget>[
            TextField(
              autofocus: true, // default to decimal
              controller: _decimalController,
              onChanged: (String stringValue) {
                if (stringValue == '') {
                  stringValue = '0';
                }
                int? value = int.tryParse(stringValue, radix: 10);
                if (value != null) {
                  _updateFields(value, Radix.decimal);
                }
              },
            ),
            TextField(
              controller: _hexadecimalController,
              onChanged: (String stringValue) {
                if (stringValue == '') {
                  stringValue = '0';
                }
                int? value = int.tryParse(stringValue, radix: 16);
                if (value != null) {
                  _updateFields(value, Radix.hexadecimal);
                }
              },
            ),
            TextField(
              controller: _binaryController,
              onChanged: (String stringValue) {
                if (stringValue == '') {
                  stringValue = '0';
                }
                int? value = int.tryParse(stringValue, radix: 2);
                if (value != null) {
                  _updateFields(value, Radix.binary);
                }
              },
            ),
          ]),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _decimalController.dispose();
    _hexadecimalController.dispose();
    _binaryController.dispose();
    super.dispose();
  }
}
