import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'state.dart';

class LoginHandler extends Cubit<LoginState> {
  LoginHandler() : super(LoginStateInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  IconData suffixIcon = Icons.visibility;
  void userLogin() {
    emit(LoginStateLoading());
    DioHelper.postData(url: LOGIN, data: {
      'email': emailController.text,
      'password': passwordController.text,
    }).then((value) {
      emailController.clear();
      passwordController.clear();
      if (value.data["status"] == "true") {
        emit(LoginStateSuccessful());
      } else {
        emit(LoginStateError(value.data["message"]));
      }
    }).catchError((error) {
      print(error.toString());
      emit(LoginStateError(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    suffixIcon = Icons.visibility_off;
    emit(LoginStatePasswordVisibilityChanged());
  }
}
