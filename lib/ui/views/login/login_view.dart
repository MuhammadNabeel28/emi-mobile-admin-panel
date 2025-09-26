import 'package:emi_solution/ui/common/app_images.dart';
import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/login/login_viewmodel.dart';
import 'package:emi_solution/ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewmodel> {
  const LoginView({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewmodel viewModel, Widget? child) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final bool isTablet = screenWidth > 600;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: isTablet
                        ? const EdgeInsets.only(
                            right: 300,
                          )
                        : const EdgeInsets.only(
                            right: 180,
                          ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1000),
                      ),
                      color: Color(0xffF2994A),
                    ),
                    height: isTablet ? screenHeight * 0.6 : screenHeight * 0.4,
                  ),
                  Container(
                    margin: isTablet
                        ? const EdgeInsets.only(
                            left: 150,
                          )
                        : const EdgeInsets.only(
                            left: 80,
                          ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(500),
                      ),
                      color: Color(0xff272341),
                    ),
                    height: isTablet ? screenHeight * 0.5 : screenHeight * 0.4,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: isTablet ? 90 : 70,
                      left: isTablet ? 350 : 100,
                    ),
                    child: Text(
                      'EMI Solution',
                      style: AppFonts.extraBold(
                        color: Colors.white,
                        fontSize: isTablet ? 40 : 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: screenHeight * (isTablet ? 0.35 : 0.3),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.svgPeopal,
                        width: isTablet ? 200 : 100,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: const ValueKey('email'),
                        controller: viewModel.emailcontrol,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: AppFonts.medium(
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: viewModel.validationEmail,
                        onSaved: (value) => viewModel.setemail(value),
                      ),
                      const SizedBox(height: 18.0),
                      TextFormField(
                        key: const ValueKey('password'),
                        controller: viewModel.passwordcontrol,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: AppFonts.medium(
                            fontSize: 15,
                          ),
                          hintText: '********',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffix: GestureDetector(
                            onTap: () {
                              viewModel.setObscurePassword();
                            },
                            child: viewModel.obscurePassword
                                ? Image.asset(
                                    AppImages.eyeClose,
                                    color: Colors.black,
                                  )
                                : Image.asset(AppImages.eyeOpen,
                                    color: Colors.black),
                          ),
                        ),
                        obscureText: viewModel.obscurePassword,
                        validator: viewModel.validationPassword,
                        onSaved: (value) => viewModel.setPassword(value),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Checkbox(
                      value: viewModel.isChecked,
                      onChanged: (bool? value) {
                        viewModel.toggleCheckbox(value ?? false);
                      },
                      activeColor: const Color(0xff4FC7B1),
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Remember Me',
                    style: AppFonts.medium(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                width: screenWidth,
                margin: const EdgeInsets.all(15),
                child: CustomButton(
                  isLoading: viewModel.isBusy,
                  onPressed: () async {
                    if (viewModel.formKey.currentState?.validate() ?? false) {
                      viewModel.formKey.currentState!.save();

                      bool result = await viewModel.loginUser(
                        username: viewModel.emailcontrol.text,
                        password: viewModel.passwordcontrol.text,
                      );

                      if (result) {
                        viewModel.emailcontrol.clear();
                        viewModel.passwordcontrol.clear();
                        viewModel.runHomeView();
                      } else {
                        viewModel.showRegularDailog(
                          'Login Failed',
                          viewModel.loginModel?.message ??
                              'Something went wrong. Please try again.',
                        );
                      }
                    }
                  },
                  text: 'Login',
                  backgroundColor: const Color(0xff4FC7B1),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(
                  right: 225,
                ),
                child: Text(
                  'Forgot Password',
                  style: AppFonts.extraBold(
                    color: Colors.blue,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewmodel viewModelBuilder(BuildContext context) => LoginViewmodel();

  @override
  void onViewModelReady(LoginViewmodel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadDetails();
  }

  @override
  void onDispose(LoginViewmodel viewModel) {
    viewModel.emailcontrol.dispose();
    viewModel.passwordcontrol.dispose();
    super.onDispose(viewModel);
  }
}
