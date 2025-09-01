//Live Test 3
import 'package:flutter/material.dart';

void main() {
  runApp(const LiveApp());
}
class LiveApp extends StatelessWidget {
  const LiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Live Test',
      debugShowCheckedModeBanner: false,
      //home: HomeScreen(),
    );
  }
}