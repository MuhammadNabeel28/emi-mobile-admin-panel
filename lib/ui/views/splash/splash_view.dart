import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StackedView<SplashViewmodel> {
  const SplashView({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: AppFonts.extraBold(
            fontSize: 50,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  @override
  viewModelBuilder(BuildContext context) => SplashViewmodel();
}
