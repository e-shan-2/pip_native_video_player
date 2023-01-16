import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel("samples.flutter.dev/battery");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Nativ Communication"),
          onPressed: () {
            printSomething();
          },
        ),
      ),
    );
  }

  Future<void> printSomething() async {
    try {
      final String result = await platform.invokeMethod("get_print");
    } on PlatformException {
      rethrow;
    }
  }
}
