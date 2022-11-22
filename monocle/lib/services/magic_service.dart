import 'dart:typed_data';

import 'package:monocle/sugar.dart';
import 'package:scryfall_api/scryfall_api.dart';

class MagicService implements MonocleService {
  late ScryfallApiClient _mtg;
  Future<Uint8List> getImage(
          {required String id,
          ImageVersion size = ImageVersion.normal,
          bool back = true}) =>
      _mtg.getCardByIdAsImage(id, imageVersion: size, backFace: back);

  @override
  void onServiceBind() {
    _mtg = ScryfallApiClient();
  }
}
