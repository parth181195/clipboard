// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'SplashViewModel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onModelReady: (model) => model.checkLogin(),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(child: Image.asset('assets/full_logo.png')),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
