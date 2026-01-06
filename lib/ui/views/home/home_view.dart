import 'package:emi_solution/ui/common/app_colors.dart';
import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/admin/client/admin_client_viewmodel.dart';
import 'package:emi_solution/ui/views/admin/client/client_form_view.dart';
import 'package:emi_solution/ui/views/admin/client/create_client_view.dart';
import 'package:emi_solution/ui/views/admin/dashboard/admin_dashboard_view.dart';
import 'package:emi_solution/ui/views/customer/customer_view.dart';
import 'package:emi_solution/ui/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  Future<void> clientForm(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ClientFormView();
      },
    );
  }

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getAppBarTitle(viewModel.currentIndex),
          style: AppFonts.semiBold(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            viewModel.scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: viewModel.currentIndex == 1
            ? [
                IconButton(
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.white),
                  onPressed: () {
                    clientForm(context);
                  },
                ),
              ]
            : [],
        backgroundColor: primaryColor,
        elevation: 2,
      ),
      drawer: const DrawerView(),
      key: viewModel.scaffoldKey,
      body: IndexedStack(index: viewModel.currentIndex, children: [
        _LazyWidget(
          index: 0,
          currentIndex: viewModel.currentIndex,
          child: viewModel.isMaster
              ? const AdminDashboardView()
              : const CustomerView(),
        ),
        _LazyWidget(
          index: 1,
          currentIndex: viewModel.currentIndex,
          child: viewModel.isMaster
              ? const CreateClientView()
              : const CustomerView(),
        ),
      ]),
      bottomNavigationBar: Container(
        color: primaryColor.withOpacity(0.1),
        padding: EdgeInsets.only(
          top: screenHeight * 0.01,
          bottom: bottomPadding > 0 ? bottomPadding : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
              isSelected: viewModel.currentIndex == 0,
              onTap: () => viewModel.setIndex(0),
              isIcon: true,
            ),
            _buildNavItem(
              icon: Icons.manage_accounts,
              label: 'Create Client',
              isSelected: viewModel.currentIndex == 1,
              onTap: () => viewModel.setIndex(1),
              isIcon: true,
            ),
            _buildNavItem(
              icon: Icons.settings,
              label: 'Settings',
              isSelected: viewModel.currentIndex == 2,
              onTap: () => viewModel.setIndex(2),
              isIcon: true,
            ),
          ],
        ),
      ),
    );
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Create Account';
      case 2:
        return 'Settings';

      default:
        return 'App';
    }
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

Widget _buildNavItem({
  required dynamic icon,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
  bool isIcon = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 67,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? primaryColor : Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: isIcon
                    ? (icon is IconData
                        ? Icon(
                            icon,
                            key: ValueKey('icon_$label'),
                            size: 22,
                            color: isSelected ? Colors.white : primaryColor,
                          )
                        : const SizedBox())
                    : ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : primaryColor,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          icon.toString(),
                          key: ValueKey('image_$label'),
                          width: 22,
                          height: 22,
                        ),
                      ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: AppFonts.regular(
                  fontSize: 10,
                  color: isSelected ? Colors.white : primaryColor,
                ),
                child: Text(
                  label,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _LazyWidget extends StatefulWidget {
  final int index;
  final int currentIndex;
  final Widget child;

  const _LazyWidget({
    required this.index,
    required this.currentIndex,
    required this.child,
  });

  @override
  State<_LazyWidget> createState() => _LazyWidgetState();
}

class _LazyWidgetState extends State<_LazyWidget>
    with AutomaticKeepAliveClientMixin {
  bool _initialized = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant _LazyWidget oldWidget) {
    if (widget.currentIndex == widget.index && !_initialized) {
      _initialized = true;
      if (mounted) setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _initialized || widget.currentIndex == widget.index
        ? widget.child
        : Container();
  }
}
