import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monocle/firebase_options.dart';
import 'package:monocle/screens/home.dart';

void main () => init().then((value) => runApp(const MonocleApp()));
Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}


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
