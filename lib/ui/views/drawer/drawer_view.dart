import 'package:emi_solution/ui/common/app_colors.dart';
import 'package:emi_solution/ui/common/app_images.dart';
import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/drawer/drawer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DrawerView extends StackedView<DrawerViewModel> {
  const DrawerView({super.key});

  @override
  Widget builder(
      BuildContext context, DrawerViewModel viewModel, Widget? child) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.75,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: primaryColor,
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: const AssetImage(AppImages.avatar),
                        backgroundColor: primaryColor,
                      ),
                      SizedBox(width: size.width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: AppFonts.medium(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            viewModel.getUserName() != ""
                                ? viewModel.getUserName() as String
                                : 'User',
                            style: AppFonts.semiBold(
                              fontSize: 20,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    //viewModel.navigateToHome();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    //viewModel.navigateToSettings();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () {
                    //viewModel.navigateToAbout();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    viewModel.logOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  DrawerViewModel viewModelBuilder(BuildContext context) => DrawerViewModel();

  @override
  void onViewModelReady(DrawerViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getUserName();
  }
}
