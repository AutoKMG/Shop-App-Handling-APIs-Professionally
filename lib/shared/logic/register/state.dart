part of 'handler.dart';

@immutable
abstract class RegisterState {}

class RegisterStateInitial extends RegisterState {}

class RegisterStateLoading extends RegisterState {}

class RegisterStateSuccessful extends RegisterState {
  final ShopLoginModel shopLoginModel;
  RegisterStateSuccessful(this.shopLoginModel);
}

class RegisterStateError extends RegisterState {
  final String error;
  RegisterStateError(this.error);
}

class RegisterStatePasswordVisibilityChanged extends RegisterState {}
