import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'state.dart';

class LoginHandler extends Cubit<LoginState> {
  LoginHandler() : super(LoginStateInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ShopLoginModel shopLoginModel;
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
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginStateSuccessful(shopLoginModel));
    }).catchError((_) {
      emit(LoginStateError(shopLoginModel.messgae));
    });
  }

  void changePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    suffixIcon = Icons.visibility_off;
    emit(LoginStatePasswordVisibilityChanged());
  }
}
