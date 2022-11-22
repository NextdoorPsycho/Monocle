import 'dart:typed_data';

import 'package:delayed_progress_indicator/delayed_progress_indicator.dart';
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
  final bool flat;
  final bool interactive;

  const CardView(
      {Key? key,
      required this.id,
      this.interactive = false,
      this.size = ImageVersion.normal,
      this.back = false,
      this.foil = false,
      this.flat = true})
      : assert((interactive && !flat) || !interactive,
            "Interactive cards must be non-flat"),
        super(key: key);

  Widget buildImage(BuildContext context, Uint8List bytes) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              bytes,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                child = ClipRRect(
                    borderRadius: BorderRadius.circular(20), child: child);

                if (wasSynchronouslyLoaded) {
                  return child;
                }

                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeInOutCirc,
                );
              },
            )),
      );

  Widget interactiveWrap(BuildContext context, Widget child) => interactive
      ? InteractiveViewer(
          minScale: 0.1,
          child: child,
        )
      : child;

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
        future: magicService().getImage(id: id, size: size, back: back),
        builder: (context, snapshot) => snapshot.hasData
            ? interactiveWrap(
                context,
                !flat
                    ? wrap(
                        context,
                        Padding(
                          padding: EdgeInsets.zero,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: XL(
                              dragging: const Dragging(resets: true),
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
                                      child:
                                          buildImage(context, snapshot.data!)),
                                )
                              ],
                            ),
                          ),
                        ))
                    : wrap(context, buildImage(context, snapshot.data!)))
            : const DelayedProgressIndicator(),
      );
}
