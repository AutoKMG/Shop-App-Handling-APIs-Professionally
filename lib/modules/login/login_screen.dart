import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/shared/logic/login/handler.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginHandler(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: BlocConsumer<LoginHandler, LoginState>(
              listener: (context, state) {
                MainShopHandler mainShopHandler =
                    BlocProvider.of<MainShopHandler>(context);
                if (state is LoginStateSuccessful) {
                  if (state.shopLoginModel.status) {
                    CacheHelper.putData(
                            key: 'token',
                            value: state.shopLoginModel.data.token)
                        .then(
                      (value) {
                        if (value) {
                          mainShopHandler.init();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return ShopLayout();
                            },
                          ), (route) => false);
                        }
                      },
                    );
                    showFlutterToast(state.shopLoginModel.message, Colors.green,
                        Toast.LENGTH_LONG);
                  } else {
                    showFlutterToast(state.shopLoginModel.message, Colors.red,
                        Toast.LENGTH_LONG);
                  }
                }
                if (state is LoginStateError) {
                  showFlutterToast(state.error, Colors.red, Toast.LENGTH_LONG);
                }
              },
              builder: (context, state) {
                LoginHandler loginHandler =
                    BlocProvider.of<LoginHandler>(context);
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: loginHandler.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          "Jump to our exclusive offers!!",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          context: context,
                          controller: loginHandler.emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please provide your email';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          context: context,
                          controller: loginHandler.passwordController,
                          isPassword: loginHandler.isPasswordHidden,
                          suffix: loginHandler.suffixIcon,
                          suffixPressed: () {
                            loginHandler.changePasswordVisibility();
                          },
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                          },
                          label: 'Password',
                          onSubmit: (_) {
                            if (loginHandler.formKey.currentState.validate()) {
                              loginHandler.userLogin();
                            }
                          },
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginStateLoading,
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (loginHandler.formKey.currentState
                                    .validate()) {
                                  loginHandler.userLogin();
                                }
                              },
                              text: "LOGIN",
                            );
                          },
                          fallback: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "REGISTER",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
