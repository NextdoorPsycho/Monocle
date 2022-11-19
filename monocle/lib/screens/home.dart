import 'package:flutter/material.dart';
import 'package:monocle/widgets/card.dart';
import 'package:scryfall_api/scryfall_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Monocle'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: Center(
          child: CardView(
              id: "bf451d4b-0884-4ab5-8d85-312d9db82e76",
              interactive: false,
              flat: true,
              foil: false,
              back: false,
              size: ImageVersion.large),
        ),
      );
}
