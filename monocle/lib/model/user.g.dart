// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) => $checkedCreate(
      'User',
      json,
      ($checkedConvert) {
        final val = User();
        $checkedConvert('firstName', (v) => val.firstName = v as String?);
        $checkedConvert('lastName', (v) => val.lastName = v as String?);
        return val;
      },
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
