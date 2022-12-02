// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map json) => $checkedCreate(
      'Deck',
      json,
      ($checkedConvert) {
        final val = Deck();
        $checkedConvert('name', (v) => val.name = v as String?);
        $checkedConvert(
            'cards',
            (v) => val.cards = v == null
                ? null
                : IDList.fromJson(Map<String, dynamic>.from(v as Map)));
        return val;
      },
    );

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'name': instance.name,
      'cards': instance.cards?.toJson(),
    };
