// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map json) => $checkedCreate(
      'Collection',
      json,
      ($checkedConvert) {
        final val = Collection();
        $checkedConvert('name', (v) => val.name = v as String?);
        $checkedConvert(
            'cards',
            (v) => val.cards = v == null
                ? null
                : IDList.fromJson(Map<String, dynamic>.from(v as Map)));
        return val;
      },
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cards': instance.cards?.toJson(),
    };
