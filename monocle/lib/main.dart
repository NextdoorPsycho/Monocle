import 'package:flutter/material.dart';
import 'package:monocle/screens/home.dart';

void main () => runApp(MonocleApp());


class MonocleApp extends StatefulWidget {
  const MonocleApp({Key? key}) : super(key: key);

  @override
  State<MonocleApp> createState() => _MonocleAppState();
}

class _MonocleAppState extends State<MonocleApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Monocle',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const HomeScreen(),
  );
}
