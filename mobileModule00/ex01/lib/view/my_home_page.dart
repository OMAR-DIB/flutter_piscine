
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "A   Simple Text";
  void toogleText()
  {
    if(text == "A   Simple Text")
    {
      text = "Hello World";
    }else if(text == "Hello World"){
      text = "A   Simple Text";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Color.fromARGB(255, 130, 136, 41),
              ),
            ),
            SizedBox(height: 8,),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  toogleText();
                });
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
