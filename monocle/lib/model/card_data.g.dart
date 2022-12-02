// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map json) => $checkedCreate(
      'CardData',
      json,
      ($checkedConvert) {
        final val = CardData();
        $checkedConvert(
            'library',
            (v) => val.library = v == null
                ? null
                : Library.fromJson(Map<String, dynamic>.from(v as Map)));
        $checkedConvert(
            'collections',
            (v) => val.collections = (v as Map?)?.map(
                  (k, e) => MapEntry(int.parse(k as String),
                      Collection.fromJson(Map<String, dynamic>.from(e as Map))),
                ));
        $checkedConvert(
            'decks',
            (v) => val.decks = (v as Map?)?.map(
                  (k, e) => MapEntry(int.parse(k as String),
                      Deck.fromJson(Map<String, dynamic>.from(e as Map))),
                ));
        return val;
      },
    );

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'library': instance.library?.toJson(),
      'collections': instance.collections
          ?.map((k, e) => MapEntry(k.toString(), e.toJson())),
      'decks':
          instance.decks?.map((k, e) => MapEntry(k.toString(), e.toJson())),
    };
