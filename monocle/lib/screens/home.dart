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
        body: const Center(
          child: CardView(
              id: "70901356-3266-4bd9-aacc-f06c27271de5",
              interactive: true,
              foil: true,
              back: false,
              size: ImageVersion.normal),
        ),
      );
}
