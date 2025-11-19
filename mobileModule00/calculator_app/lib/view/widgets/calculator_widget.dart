import 'package:flutter/material.dart';

class CalculatorWidget extends StatelessWidget {
  const CalculatorWidget({
    super.key,
    required this.var0,
    required this.var1,
    required this.var2,
    required this.var3,
    required this.var4,
    required this.onButtonPressed,
  });

  final String var0;
  final String var1;
  final String var2;
  final String var3;
  final String var4;
  final Function(String) onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final buttons = [var0, var1, var2, var3, var4];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((label) {
        if (label.isEmpty) return const SizedBox(width: 60); // empty space
        return TextButton(
          onPressed: () => onButtonPressed(label),
          child: Text(
            label,
            style: const TextStyle(fontSize: 22),
          ),
        );
      }).toList(),
    );
  }
}