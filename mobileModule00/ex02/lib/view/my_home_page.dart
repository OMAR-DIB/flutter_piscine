import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    String var0 = '7';
    String var1 = '8';
    String var2 = '9';
    String var3 = 'C';
    String var4 = 'AC';

    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "0", // or leave blank if you prefer
              border: InputBorder.none, // removes underline
            ),
            textAlign: TextAlign.right, // aligns text to the right
            style: const TextStyle(fontSize: 24), // optional styling
            readOnly: true, // user can't type directly
            showCursor: false,
          ),

          // Result display
          TextField(
            decoration: InputDecoration(
              hintText: "0",
              border: InputBorder.none,
            ),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            readOnly: true,
            showCursor: false,
          ),
          Spacer(),
          CalculatorRow(var0: '7', var1: '8', var2: '9', var3: 'C', var4: 'AC'),
          CalculatorRow(var0: '4', var1: '5', var2: '6', var3: '+', var4: '-'),
          CalculatorRow(var0: '1', var1: '2', var2: '3', var3: 'x', var4: '/'),
          CalculatorRow(var0: '0', var1: '.', var2: '00', var3: '=', var4: ''),
        ],
      ),
    );
  }
}

class CalculatorRow extends StatelessWidget {
  const CalculatorRow({
    super.key,
    required this.var0,
    required this.var1,
    required this.var2,
    required this.var3,
    required this.var4,
  });

  final String var0;
  final String var1;
  final String var2;
  final String var3;
  final String var4;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            print('button pressed :$var0');
          },
          child: Text(var0),
        ),
        TextButton(
          onPressed: () {
            print('button pressed :$var1');
          },
          child: Text(var1),
        ),
        TextButton(
          onPressed: () {
            print('button pressed :$var2');
          },
          child: Text(var2),
        ),
        TextButton(
          onPressed: () {
            print('button pressed :$var3');
          },
          child: Text(var3),
        ),
        TextButton(
          onPressed: () {
            print('button pressed :$var4');
          },
          child: Text(var4),
        ),
      ],
    );
  }
}
