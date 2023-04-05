import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/logic/login/cubit/handler.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginHandler(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: BlocBuilder<LoginHandler, LoginState>(
              builder: (context, state) {
                LoginHandler loginHandler =
                    BlocProvider.of<LoginHandler>(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("LOGIN"),
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
                      validate: () {},
                      label: 'Email',
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      context: context,
                      controller: loginHandler.passwordController,
                      isPassword: true,
                      type: TextInputType.emailAddress,
                      validate: () {},
                      label: 'Password',
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "LOGIN",
                      ),
                    ),
                    Row(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
