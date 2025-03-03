import 'package:flutter/material.dart';
import 'package:projectsistem/pages/homePage.dart';

void main() {
  runApp(MyApp());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Home Page')),
        body: Center(child: Text('Welcome to Home Page!')),
      ),
    );
  }
}
