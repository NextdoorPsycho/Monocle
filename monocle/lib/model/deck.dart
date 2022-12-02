import 'package:json_annotation/json_annotation.dart';
import 'package:monocle/model/idlist.dart';

part "deck.g.dart";

@JsonSerializable()
class Deck {
  String? name;
  IDList? cards;

  Deck();

  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);

  Map<String, dynamic> toJson() => _$DeckToJson(this);
}
