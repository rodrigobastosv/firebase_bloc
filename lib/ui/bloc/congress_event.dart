import 'package:equatable/equatable.dart';
import 'package:firebase_bloc/model/congressman_model.dart';

abstract class CongressEvent extends Equatable {
  const CongressEvent();
}

class CongressFetch extends CongressEvent {
  @override
  List<Object> get props => [];
}

class CongressLiked extends CongressEvent {
  CongressLiked(this.congressman, this.userId);

  final CongressmanModel congressman;
  final String userId;

  @override
  List<Object> get props => [congressman];
}

class CongressUnliked extends CongressEvent {
  CongressUnliked(this.congressman, this.userId);

  final CongressmanModel congressman;
  final String userId;

  @override
  List<Object> get props => [congressman];
}
