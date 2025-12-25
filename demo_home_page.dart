import 'package:flutter/material.dart';

class DemoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your button action here
            print('Button pressed!');
          },
          child: Text('Click Me'),
        ),
      ),
    );
  }
}
