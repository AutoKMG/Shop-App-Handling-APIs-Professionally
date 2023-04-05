import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'state.dart';

class LoginHandler extends Cubit<LoginState> {
  LoginHandler() : super(LoginStateInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginStateLoading());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value);
      emit(LoginStateSuccessful());
    }).catchError((error) {
      emit(LoginStateError(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginStatePasswordVisibilityChanged());
  }
}
