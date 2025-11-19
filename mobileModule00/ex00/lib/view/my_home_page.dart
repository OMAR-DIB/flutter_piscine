
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "A   Simple Text",
              style: TextStyle(
                color: Color.fromARGB(255, 130, 136, 41),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("Button pressed");
              },
              child: Text("click me"),
            ),
          ],
        ),
      ),
    
    );
  }
}
