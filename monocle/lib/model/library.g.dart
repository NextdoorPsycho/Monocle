// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map json) => $checkedCreate(
      'Library',
      json,
      ($checkedConvert) {
        final val = Library();
        $checkedConvert(
            'cards',
            (v) => val.cards = (v as Map?)?.map(
                  (k, e) => MapEntry(int.parse(k as String), e as String),
                ));
        return val;
      },
    );

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'cards': instance.cards?.map((k, e) => MapEntry(k.toString(), e)),
    };
