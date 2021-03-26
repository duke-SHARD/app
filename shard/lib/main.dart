import 'package:flutter/material.dart';
import './home_screen.dart';
void main() => runApp(ShardApp()); // entry point for all dart files

class ShardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    ); 
  }
}
