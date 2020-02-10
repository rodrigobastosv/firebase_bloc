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
  });
}
