// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IDList _$IDListFromJson(Map json) => $checkedCreate(
      'IDList',
      json,
      ($checkedConvert) {
        final val = IDList();
        $checkedConvert('data', (v) => val.data = v as String?);
        return val;
      },
    );

Map<String, dynamic> _$IDListToJson(IDList instance) => <String, dynamic>{
      'data': instance.data,
    };
