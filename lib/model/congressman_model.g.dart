// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'congressman_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CongressmanModel _$CongressmanModelFromJson(Map<String, dynamic> json) {
  return CongressmanModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    partido: json['partido'] as String,
    likers: (json['likers'] as List)?.map((e) => e as String)?.toList() ?? [],
  );
}

Map<String, dynamic> _$CongressmanModelToJson(CongressmanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'partido': instance.partido,
      'likers': instance.likers,
    };
