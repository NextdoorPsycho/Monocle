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
              id: "57877b1c-e91d-4941-81bd-008dff1272ed",
              interactive: true,
              flat: false,
              foil: true,
              back: false,
              size: ImageVersion.large),
        ),
      );
}
