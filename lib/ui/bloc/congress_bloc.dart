import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_bloc/model/congressman_model.dart';
import 'package:firebase_bloc/repository/congress_repository.dart';

import './bloc.dart';

class CongressBloc extends Bloc<CongressEvent, CongressState> {
  CongressBloc(this.repository);

  CongressRepository repository;

  List<CongressmanModel> congressPeople;

  List<CongressmanModel> get congressPeopleInRanking =>
      [...congressPeople]..sort((d1, d2) =>
          (d2.likers ?? []).length.compareTo((d1.likers ?? []).length));

  @override
  CongressState get initialState => InitialCongressState();

  @override
  Stream<CongressState> mapEventToState(CongressEvent event) async* {
    if (event is CongressFetch) {
      yield* _mapCongressFetch(event);
    }
    if (event is CongressLiked) {
      yield* _mapCongressLiked(event);
    }
    if (event is CongressUnliked) {
      yield* _mapCongressUnliked(event);
    }
  }

  Stream<CongressState> _mapCongressFetch(CongressEvent event) async* {
    yield CongressLoadingState();

    try {
      congressPeople = await repository.getCongressPeople();
      yield CongressLoadedState(congressPeople);
    } catch (e) {
      yield CongressLoadedFailledState(e.toString());
    }
  }

  Stream<CongressState> _mapCongressLiked(CongressLiked event) async* {
    try {
      final userId = event.userId;
      await repository.likeCongressmanForUser(event.congressman.id, userId);
      final updatedList = [...(congressPeople ?? [])];
      final index = updatedList.indexOf(event.congressman);
      if (index != -1) {
        updatedList[index].likers.add(userId);
      }
      yield CongressLikedState(event.congressman);
    } catch (e) {
      print(e);
      yield CongressLikedFailledState(e.toString());
    }
  }

  Stream<CongressState> _mapCongressUnliked(CongressUnliked event) async* {
    try {
      final userId = event.userId;
      await repository.unlikeCongressmanForUser(event.congressman.id, userId);
      final updatedList = [...(congressPeople ?? [])];
      final index = updatedList.indexOf(event.congressman);
      if (index != -1) {
        updatedList[index].likers.remove(userId);
      }
      yield CongressUnlikedState(event.congressman);
    } catch (e) {
      yield CongressUnlikedFailledState(e.toString());
    }
  }
}
