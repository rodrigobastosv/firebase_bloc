import 'package:equatable/equatable.dart';

abstract class SigninState extends Equatable {
  const SigninState();
}

class InitialSigninState extends SigninState {
  @override
  List<Object> get props => [];
}
