import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:foil/foil.dart';
import 'package:monocle/sugar.dart';
import 'package:scryfall_api/scryfall_api.dart';
import 'package:xl/xl.dart';

class CardView extends StatelessWidget {
  final String id;
  final ImageVersion size;
  final bool back;
  final bool foil;
  final bool interactive;

  const CardView(
      {Key? key,
      required this.id,
      this.size = ImageVersion.normal,
      this.back = false,
      this.foil = false,
      this.interactive = false})
      : super(key: key);

  Widget buildImage(BuildContext context, Uint8List bytes) => ClipRRect(
      child: Image.memory(bytes), borderRadius: BorderRadius.circular(20));

  Widget wrap(BuildContext context, Widget child) => Foil(
      isUnwrapped: !foil,
      opacity: 0.4,
      scalar: Scalar(horizontal: 0.2, vertical: 0.2),
      child: Foil(
          isUnwrapped: !foil,
          opacity: 0.2,
          scalar: Scalar(horizontal: 0.55, vertical: 0.55),
          gradient: Foils.linearLoopingReversed,
          child: child));

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List>(
        future: mtg.getCardByIdAsImage(id, imageVersion: size, backFace: back),
        builder: (context, snapshot) => snapshot.hasData
            ? interactive
                ? wrap(
                    context,
                    Padding(
                      padding: EdgeInsets.zero,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: XL(
                          dragging: Dragging(resets: true),
                          sharesPointer: true,
                          duration: const Duration(milliseconds: 150),
                          layers: [
                            XLayer(
                              dimensionalOffset: 0.002,
                              xOffset: 1,
                              yOffset: 1,
                              xRotation: 0.2,
                              yRotation: 0.2,
                              zRotationByX: 0.2,
                              zRotationByGyro: 0.08,
                              child: Center(
                                  child: buildImage(context, snapshot.data!)),
                            )
                          ],
                        ),
                      ),
                    ))
                : wrap(context, buildImage(context, snapshot.data!))
            : const CircularProgressIndicator(),
      );
}