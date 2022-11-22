import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monocle/firebase_options.dart';
import 'package:monocle/screens/home.dart';
import 'package:monocle/services/auth_service.dart';
import 'package:monocle/sugar.dart';
import 'package:provider/provider.dart';

void main() => setup().then((_) => runApp(const MonocleApp()));

Future<void> setup() async {
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
  void initState() {
    tempContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService()..onServiceBind(),
            lazy: true,
          )
        ],
        child: MaterialApp(
          title: 'Monocle',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: const HomeScreen(),
        ),
      );
}
