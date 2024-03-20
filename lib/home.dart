import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<Object?> foo = [];

class NativeBridge {
  static const MethodChannel _channel = MethodChannel('com.example/native');

  static void sendNativeData(String name) async {
    await _channel.invokeMethod('sendNativeData', <String, String>{"name": name});
  }

  static void getNativeData(BuildContext context) async {
    await _channel.invokeMethod('getNativeData').then((value) {
      for (int i = 0; i < value.length; i++) {
        foo.add(value[i]);
      }
      if (foo.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AnotherScreen(),
          ),
        );
      }
    });
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NativeBridge.getNativeData(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My App'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnotherScreen(),
              ),
            );
          },
          onLongPress: () => NativeBridge.sendNativeData('Another Screen'),
          child: Container(
            height: 48,
            width: 120,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(5, 5),
                )
              ],
            ),
            child: const Text('Click me'),
          ),
        ),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Another screen'),
      ),
      body: const Center(
        child: Text('This is another screen'),
      ),
    );
  }
}
