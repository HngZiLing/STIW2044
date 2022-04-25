import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  double numa = 0, numb = 0, result = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(controller: textEditingController),
              TextField(controller: textEditingController2),
              ElevatedButton(
                onPressed: _calculate, child: const Text("Calculate")),
                Text('Result: ' + result.toString())
            ],
          ),
        ),
      ),
    );
  }
  
  void _calculate() {
    setState(() {
      numa = double.parse(textEditingController.text);
      numb = double.parse(textEditingController2.text);
      result = numa + numb;
    });
  }
}