import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'congressman_model.g.dart';

@JsonSerializable(nullable: false)
class CongressmanModel extends Equatable {
  final int id;
  final String nome;
  final String partido;

  @JsonKey(nullable: true, defaultValue: [])
  final List<String> likers;

  CongressmanModel({this.id, this.nome, this.partido, this.likers});

  factory CongressmanModel.fromJson(Map<String, dynamic> json) =>
      _$CongressmanModelFromJson(json);

  Map<String, dynamic> toJson() => _$CongressmanModelToJson(this);

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return 'CongressmanModel{id: $id, nome: $nome, partido: $partido, likers: $likers}';
  }
}
