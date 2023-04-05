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
                return Padding(
                  padding: const EdgeInsets.all(15.0),
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
                        isPassword: true,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                        function: () {},
                        text: "LOGIN",
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
