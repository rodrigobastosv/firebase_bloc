import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  @override
  SigninState get initialState => InitialSigninState();

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
