import 'package:flutter/material.dart';
import 'package:native_practice/ui/home_page.dart';

void main() {
  runApp(const NativAppFlutter());
}

class NativAppFlutter extends StatefulWidget {
  const NativAppFlutter({super.key});

  @override
  State<NativAppFlutter> createState() => _NativAppFlutterState();
}

class _NativAppFlutterState extends State<NativAppFlutter> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
