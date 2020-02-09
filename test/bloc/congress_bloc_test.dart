import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_bloc/model/congressman_model.dart';
import 'package:firebase_bloc/ui/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('CongressBloc tests', () {
    MockCongressRepository mockCongressRepository;

    setUp(() {
      mockCongressRepository = MockCongressRepository();
    });

    blocTest(
      'Initial state should be InitialCongressState',
      build: () => CongressBloc((mockCongressRepository)),
      expect: [InitialCongressState()],
    );

    blocTest(
      'CongressFetch event results in [InitialCongressState, CongressLoadingState, CongressLoadedState]',
      build: () {
        when(mockCongressRepository.getCongressPeople()).thenAnswer((_) =>
            Future.value(
                [CongressmanModel(id: 1, nome: 'teste', partido: 'teste')]));
        return CongressBloc((mockCongressRepository));
      },
      act: (bloc) {
        bloc.add(CongressFetch());
        return;
      },
      expect: [
        InitialCongressState(),
        CongressLoadingState(),
        CongressLoadedState(
            [CongressmanModel(id: 1, nome: 'teste', partido: 'teste')])
      ],
    );

    blocTest(
      'CongressFetch event results in [InitialCongressState, CongressLoadingState, CongressLoadedFailledState] when error happens',
      build: () {
        when(mockCongressRepository.getCongressPeople())
            .thenThrow(Exception('Opsie Dasie'));
        return CongressBloc((mockCongressRepository));
      },
      act: (bloc) {
        bloc.add(CongressFetch());
        return;
      },
      expect: [
        InitialCongressState(),
        CongressLoadingState(),
        isA<CongressLoadedFailledState>(),
      ],
    );

    blocTest(
      'CongressLiked event results in [InitialCongressState, CongressLikedState]',
      build: () {
        when(mockCongressRepository.likeCongressmanForUser(any, any))
            .thenAnswer((_) => Future.value());
        return CongressBloc((mockCongressRepository))
          ..congressPeople = [
            CongressmanModel(id: 1, nome: 'teste', partido: 'teste', likers: [])
          ];
      },
      act: (bloc) {
        bloc.add(CongressLiked(CongressmanModel(id: 1)));
        return;
      },
      expect: [
        InitialCongressState(),
        CongressLikedState(CongressmanModel(id: 1))
      ],
    );

    blocTest(
      'CongressLiked event results in [InitialCongressState, CongressLikedFailledState] when error happens',
      build: () {
        when(mockCongressRepository.likeCongressmanForUser(any, any))
            .thenThrow(Exception('Ruim'));
        return CongressBloc((mockCongressRepository));
      },
      act: (bloc) {
        bloc.add(CongressLiked(CongressmanModel(id: 1)));
        return;
      },
      expect: [
        InitialCongressState(),
        isA<CongressLikedFailledState>(),
      ],
    );

    blocTest(
      'CongressUnliked event results in [InitialCongressState, CongressUnlikedState]',
      build: () {
        when(mockCongressRepository.unlikeCongressmanForUser(any, any))
            .thenAnswer((_) => Future.value());
        return CongressBloc((mockCongressRepository))
          ..congressPeople = [
            CongressmanModel(id: 1, nome: 'teste', partido: 'teste', likers: [])
          ];
      },
      act: (bloc) {
        bloc.add(CongressUnliked(CongressmanModel(id: 1)));
        return;
      },
      expect: [
        InitialCongressState(),
        CongressUnlikedState(CongressmanModel(id: 1))
      ],
    );

    blocTest(
      'CongressUnliked event results in [InitialCongressState, CongressUnlikedFailledState] when error happens',
      build: () {
        when(mockCongressRepository.unlikeCongressmanForUser(any, any))
            .thenThrow(Exception('Ruim'));
        return CongressBloc((mockCongressRepository));
      },
      act: (bloc) {
        bloc.add(CongressUnliked(CongressmanModel(id: 1)));
        return;
      },
      expect: [
        InitialCongressState(),
        isA<CongressUnlikedFailledState>(),
      ],
    );

    test('congressPeopleInRanking should order the ranking correctly', () {
      CongressBloc congressBloc = CongressBloc(mockCongressRepository);
      congressBloc.congressPeople = [
        CongressmanModel(id: 1, likers: ['1']),
        CongressmanModel(id: 2, likers: ['1', '2']),
      ];
      final ranking = [
        CongressmanModel(id: 2, likers: ['1', '2']),
        CongressmanModel(id: 1, likers: ['1']),
      ];

      expect(ranking[0] == congressBloc.congressPeopleInRanking[0], true);
      expect(ranking[1] == congressBloc.congressPeopleInRanking[1], true);
      congressBloc.close();
    });
  });
}
