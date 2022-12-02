import 'dart:typed_data';

import 'package:memcached/memcached.dart';
import 'package:monocle/sugar.dart';
import 'package:scryfall_api/scryfall_api.dart';

class MagicService implements MonocleService {
  late ScryfallApiClient _mtg;
  Future<Uint8List> getImage(
          {required String id,
          ImageVersion size = ImageVersion.normal,
          bool back = true}) =>
      getCached(
          id: "card$id$back${size.index}",
          getter: () =>
              _mtg.getCardByIdAsImage(id, imageVersion: size, backFace: back),
          duration: const Duration(days: 1));

  @override
  void onServiceBind() {
    _mtg = ScryfallApiClient();
  }
}
