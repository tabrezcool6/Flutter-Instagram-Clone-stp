import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('This is a Web Screen'),
        ),
      ),
    );
  }
}
