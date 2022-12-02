import 'package:json_annotation/json_annotation.dart';
import 'package:monocle/model/idlist.dart';

part "collection.g.dart";

@JsonSerializable()
class Collection {
  String? name;
  IDList? cards;

  Collection();

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
