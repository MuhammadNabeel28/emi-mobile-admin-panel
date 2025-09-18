import 'package:emi_solution/ui/common/app_colors.dart';
import 'package:emi_solution/ui/common/app_images.dart';
import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 70, left: 10),
          child: Text(
            "EMI Solution",
            style: AppFonts.semiBold(
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Image.asset(AppImages.man),
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome!",
                style: AppFonts.semiBold(
                  fontSize: 24,
                  color: kcVeryLightGrey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Track and manage user EMIs with ease.",
                style: AppFonts.regular(
                  fontSize: 16,
                  color: kcVeryLightGrey,
                ),
              ),
              Text(
                "Monitor payment history and due dates.",
                style: AppFonts.regular(
                  fontSize: 16,
                  color: kcVeryLightGrey,
                ),
              ),
              Text(
                "Get real-time updates and location logs.",
                style: AppFonts.regular(
                  fontSize: 16,
                  color: kcVeryLightGrey,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomButton(
                width: double.infinity,
                text: "Get Started",
                onPressed: () {
                  viewModel.isLoading = true;
                  viewModel.rebuildUi();
                  viewModel.runStartupLogic();
                },
                backgroundColor: kcVeryLightGrey,
                foregroundColor: primaryColor,
                isLoading: viewModel.isLoading,
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  bottom: bottomPadding > 0 ? bottomPadding : 0,
                ),
                child: Center(
                  child: Text(
                    "Your control center for EMI tracking.",
                    style: AppFonts.italic(
                        fontSize: 17,
                        color: kcVeryLightGrey,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    ));
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
