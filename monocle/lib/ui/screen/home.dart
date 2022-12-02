import 'package:dialoger/dialoger.dart';
import 'package:flutter/material.dart';
import 'package:mapped_list/mapped_list.dart';
import 'package:monocle/sugar.dart';
import 'package:monocle/ui/widget/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: CardDataStream(
            builder: (data, writer) => Scaffold(
                floatingActionButton: FloatingActionButton(onPressed: () {
                  dialogText(
                      context: context,
                      title: "Card ID",
                      submitButtonText: "Add Card",
                      onSubmit: (context, id) => writer.pushWith((value) {
                            value.getLibrary().getCards().ladd(id);
                          }));
                }),
                body: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  children: [
                    ...data.getLibrary().getCards().values.map((e) => CardView(
                          id: e,
                        )),
                  ],
                )),
          ),
        ),
      );
}
