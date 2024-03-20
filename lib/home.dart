import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Object? incomingScreenData;

class NativeBridge {
  static const MethodChannel _channel = MethodChannel('com.example/native');

  static void sendNativeData({
    required String name,
    required String imagePath,
  }) async {
    await _channel.invokeMethod('sendNativeData', <String, String>{
      "name": name,
      "imagePath": imagePath,
    });
  }

  static void getNativeData(BuildContext context) async {
    await _channel.invokeMethod('getNativeData').then((value) {
      incomingScreenData = value;
      if (incomingScreenData != "") {
        Widget? screenName;
        switch (incomingScreenData) {
          case "Other Screen":
            screenName = const OtherScreen();
          case "Another Screen":
            screenName = const AnotherScreen();
        }
        if (screenName == null) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screenName!,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OtherScreen(),
                  ),
                );
              },
              onLongPress: () => NativeBridge.sendNativeData(
                name: 'Other Screen',
                imagePath: 'android/app/src/main/res/drawable/page.png',
              ),
              child: Container(
                height: 48,
                width: 120,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
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
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnotherScreen(),
                  ),
                );
              },
              onLongPress: () => NativeBridge.sendNativeData(
                name: 'Another Screen',
                imagePath: 'android/app/src/main/res/drawable/page.png',
              ),
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
          ],
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

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Other screen'),
      ),
      body: const Center(
        child: Text('This is other screen'),
      ),
    );
  }
}
