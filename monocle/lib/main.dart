import 'package:fast_log/fast_log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/firebase_options.dart';
import 'package:monocle/services/auth_service.dart';
import 'package:monocle/services/user_service.dart';
import 'package:monocle/sugar.dart';
import 'package:monocle/ui/screen/home.dart';
import 'package:monocle/ui/screen/login.dart';
import 'package:monocle/ui/screen/splash.dart';
import 'package:provider/provider.dart';

String? splashRouteTo;

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
  final List<GetMiddleware> middlewares = [MonocleMiddleware()];
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
          ),
          Provider<UserService>(
            create: (_) => UserService()..onServiceBind(),
            lazy: true,
          )
        ],
        child: GetMaterialApp(
            title: 'Monocle',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            initialRoute: "/",
            getPages: [
              GetPage(
                  name: "/",
                  page: () => const HomeScreen(),
                  middlewares: middlewares),
              GetPage(
                  name: "/login",
                  page: () => const LoginScreen(),
                  middlewares: middlewares),
              GetPage(
                  name: "/splash",
                  page: () => const SplashScreen(),
                  middlewares: middlewares),
            ]),
      );
}

class MonocleMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (route == "/splash" || route == "/login") {
      return null;
    }

    if (!authService().isSignedIn() || !userService().bound) {
      warn("Navigating to ${route ?? "?"} before splash!");
      splashRouteTo = route ?? "/";
      return const RouteSettings(name: "/splash");
    }

    return null;
  }
}
