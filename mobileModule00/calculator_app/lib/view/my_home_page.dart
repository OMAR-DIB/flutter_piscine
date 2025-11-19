import 'package:calculator_app/view/widgets/calculator_widget.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String expression = '';
  String result = '0';

  // Handles button press logic
  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        // Clear all
        expression = '';
        result = '0';
      } else if (value == 'C') {
        // Delete last character
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (value == '=') {
        // Evaluate expression
        try {
          String finalExpression = expression.replaceAll('x', '*');
          GrammarParser p = GrammarParser();
          Expression exp = p.parse(finalExpression);
          ContextModel cm = ContextModel();
          var evaluator = RealEvaluator(cm);
num evalResult = evaluator.evaluate(exp);

double eval = evalResult.toDouble();

          result = eval.toString();

          // Remove trailing .0 for integers
          if (result.endsWith('.0')) {
            result = result.substring(0, result.length - 2);
          }
        } catch (e) {
          result = 'Error';
        }
      } else {
        // Append numbers/operators
        expression += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Expression display
          TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            controller: TextEditingController(text: expression),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 24),
            readOnly: true,
            showCursor: false,
          ),

          // Result display
          TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            controller: TextEditingController(text: result),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            readOnly: true,
            showCursor: false,
          ),

          const Spacer(),

          // Calculator rows
          CalculatorWidget(
              onButtonPressed: _onButtonPressed,
              var0: '7',
              var1: '8',
              var2: '9',
              var3: 'C',
              var4: 'AC'),
          CalculatorWidget(
              onButtonPressed: _onButtonPressed,
              var0: '4',
              var1: '5',
              var2: '6',
              var3: '+',
              var4: '-'),
          CalculatorWidget(
              onButtonPressed: _onButtonPressed,
              var0: '1',
              var1: '2',
              var2: '3',
              var3: 'x',
              var4: '/'),
          CalculatorWidget(
              onButtonPressed: _onButtonPressed,
              var0: '0',
              var1: '.',
              var2: '00',
              var3: '=',
              var4: ''),
        ],
      ),
    );
  }
}
