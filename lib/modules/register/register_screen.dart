import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/shared/logic/register/handler.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterHandler(),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: BlocConsumer<RegisterHandler, RegisterState>(
              listener: (context, state) {
                MainShopHandler mainShopHandler =
                    BlocProvider.of<MainShopHandler>(context);
                if (state is RegisterStateSuccessful) {
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
                if (state is RegisterStateError) {
                  showFlutterToast(state.error, Colors.red, Toast.LENGTH_LONG);
                }
              },
              builder: (context, state) {
                RegisterHandler registerHandler =
                    BlocProvider.of<RegisterHandler>(context);
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: registerHandler.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          "Time to exclusive offers!!",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          context: context,
                          controller: registerHandler.nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please provide your name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          context: context,
                          controller: registerHandler.emailController,
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
                          controller: registerHandler.passwordController,
                          isPassword: registerHandler.isPasswordHidden,
                          suffix: registerHandler.suffixIcon,
                          suffixPressed: () {
                            registerHandler.changePasswordVisibility();
                          },
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                          },
                          label: 'Password',
                          onSubmit: (_) {},
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          context: context,
                          controller: registerHandler.phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please provide your phone';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterStateLoading,
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (registerHandler.formKey.currentState
                                    .validate()) {
                                  registerHandler.userRegister();
                                }
                              },
                              text: "REGISTER",
                            );
                          },
                          fallback: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
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
