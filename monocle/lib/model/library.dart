import 'package:json_annotation/json_annotation.dart';

part "library.g.dart";

@JsonSerializable()
class Library {
  Map<int, String>? cards;

  Library();

  Map<int, String> getCards() {
    cards ??= {};
    return cards!;
  }

  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
