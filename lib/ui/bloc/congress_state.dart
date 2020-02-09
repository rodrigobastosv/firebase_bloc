import 'package:equatable/equatable.dart';
import 'package:firebase_bloc/model/congressman_model.dart';

abstract class CongressState extends Equatable {}

class InitialCongressState extends CongressState {
  @override
  List<Object> get props => [];
}

class CongressLoadingState extends CongressState {
  @override
  List<Object> get props => [];
}

class CongressLoadedState extends CongressState {
  CongressLoadedState(this.congressPeople);

  final List<CongressmanModel> congressPeople;

  @override
  List<Object> get props => [congressPeople];
}

class CongressLoadedFailledState extends CongressState {
  CongressLoadedFailledState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class CongressLikedState extends CongressState {
  CongressLikedState(this.congressman);

  final CongressmanModel congressman;

  @override
  List<Object> get props => [congressman];
}

class CongressUnlikedState extends CongressState {
  CongressUnlikedState(this.congressman);

  final CongressmanModel congressman;

  @override
  List<Object> get props => [congressman];
}

class CongressLikedFailledState extends CongressState {
  CongressLikedFailledState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class CongressUnlikedFailledState extends CongressState {
  CongressUnlikedFailledState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
