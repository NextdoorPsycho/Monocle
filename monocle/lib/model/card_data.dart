import 'package:json_annotation/json_annotation.dart';
import 'package:monocle/model/collection.dart';
import 'package:monocle/model/deck.dart';
import 'package:monocle/model/library.dart';

part "card_data.g.dart";

@JsonSerializable()
class CardData {
  Library? library;
  Map<int, Collection>? collections;
  Map<int, Deck>? decks;

  CardData();

  Library getLibrary() {
    library ??= Library();
    return library!;
  }

  factory CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}
