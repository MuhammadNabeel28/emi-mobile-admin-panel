import 'package:emi_solution/ui/views/login/login_viewmodel.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewmodel>{
  const LoginView({super.key});

  @override
  Widget builder(BuildContext context, LoginViewmodel viewModel, Widget? child) {
    throw UnimplementedError();
  }

  @override
  LoginViewmodel viewModelBuilder(BuildContext context) => LoginViewmodel();
  
}