part of 'handler.dart';

@immutable
abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccessful extends LoginState {
  final ShopLoginModel shopLoginModel;
  LoginStateSuccessful(this.shopLoginModel);
}

class LoginStateError extends LoginState {
  final String error;
  LoginStateError(this.error);
}

class LoginStatePasswordVisibilityChanged extends LoginState {}
