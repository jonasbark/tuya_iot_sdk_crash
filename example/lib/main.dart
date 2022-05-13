import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuya_sdk/tuya_sdk.dart';

final sdk = TuyaSdk();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    sdk.init("...", "...", "1486965680170455040@accounts.fieldbots.io", "...");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final result = await sdk.getPairingToken("1486965680170455040");

    print(result.toString());
    setState(() {
      _platformVersion = result.token!;
    });
    await sdk.connectToWifi(result, "Turmbraeu", "...");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              const CircularProgressIndicator(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await initPlatformState();
          },
        ),
      ),
    );
  }
}
