import 'package:emi_solution/main.dart';
import 'package:emi_solution/ui/common/app_images.dart';
import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:emi_solution/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 80, left: 110),
          child: Text(
            "EMI Solution",
            style: AppFonts.semiBold(
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Image.asset(AppImages.man)
      ],
    ));
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
