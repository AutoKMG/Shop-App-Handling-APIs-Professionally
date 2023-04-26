import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'state.dart';

class RegisterHandler extends Cubit<RegisterState> {
  RegisterHandler() : super(RegisterStateInitial()) {
    lang = CacheHelper.getData(key: 'lang') ?? 'en';
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ShopLoginModel shopLoginModel;
  String lang;
  var formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  IconData suffixIcon = Icons.visibility;
  void userRegister() {
    emit(RegisterStateLoading());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
      },
      lang: lang,
    ).then((value) {
      emailController.clear();
      passwordController.clear();
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterStateSuccessful(shopLoginModel));
    }).catchError((_) {
      emit(RegisterStateError(shopLoginModel.message));
    });
  }

  void changePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    suffixIcon = Icons.visibility_off;
    emit(RegisterStatePasswordVisibilityChanged());
  }
}
