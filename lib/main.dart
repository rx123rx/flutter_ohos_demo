import 'package:flutter/material.dart';
import 'package:flutter_ohos_demo/web_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Ohos Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebPage(
        url:
            'https://static.hnltcw.com/game-box/zml-web-mobile/web-mobile/index.html',
      ),
    );
  }
}
