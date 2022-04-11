// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart' as fui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginViewModel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) {
        return fui.FluentTheme(
            data: fui.ThemeData(brightness: fui.Brightness.dark),
            child: Scaffold(
                body: fui.Center(
              child: fui.SizedBox(
                width: 300,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    fui.Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      child: fui.Center(
                        child:
                            Center(child: Image.asset('assets/full_logo.png')),
                      ),
                    ),
                    fui.Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      child: fui.Center(
                          child: fui.Text(
                        model.mode == LoginPageMode.login ? 'Login' : 'Sign Up',
                        style: fui.TextStyle(fontSize: 20),
                      )),
                    ),
                    fui.Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: fui.TextFormBox(
                        controller: model.emailController,
                        autovalidateMode:
                            fui.AutovalidateMode.onUserInteraction,
                        validator: model.emailValidators,
                        header: 'Email',
                        keyboardType: fui.TextInputType.emailAddress,
                      ),
                    ),
                    fui.Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: fui.TextFormBox(
                        controller: model.passwordController,
                        autovalidateMode:
                            fui.AutovalidateMode.onUserInteraction,
                        validator: model.passwordValidators,
                        obscureText: !model.showPassword,
                        suffix: fui.IconButton(
                            icon: Icon(model.showPassword
                                ? fui.FluentIcons.red_eye
                                : fui.FluentIcons.visually_impaired),
                            onPressed: () {
                              model.toggleShowPassword();
                            }),
                        header: 'Password',
                        keyboardType: fui.TextInputType.emailAddress,
                      ),
                    ),
                    fui.Button(
                      child: fui.Container(
                        padding: EdgeInsets.all(5),
                        child: fui.Text(
                          model.mode == LoginPageMode.login
                              ? 'Login'
                              : 'Sign Up',
                        ),
                      ),
                      style: fui.ButtonStyle(),
                      onPressed: () async {
                        if (model.mode == LoginPageMode.login) {
                          await model.login();
                        } else {
                          await model.signUp();
                        }
                      },
                    ),
                    fui.Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: TextButton(
                            child: Text(model.mode == LoginPageMode.login
                                ? 'New Clippy? Sign Up'
                                : 'Already a Member? login'),
                            style: TextButton.styleFrom(primary: Colors.white),
                            onPressed: () {
                              model.changeMode();
                            }))
                  ],
                ),
              ),
            )));
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
