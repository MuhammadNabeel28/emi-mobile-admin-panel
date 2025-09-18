import 'package:emi_solution/ui/common/app_colors.dart';
import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/admin/admin_view.dart';
import 'package:emi_solution/ui/views/customer/customer_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      key: viewModel.scaffoldKey,
      body: IndexedStack(index: viewModel.currentIndex, children: [
        _LazyWidget(
          index: 0,
          currentIndex: viewModel.currentIndex,
          child: viewModel.isMaster ? const AdminView() : const CustomerView(),
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
            ),
            _buildNavItem(
              icon: Icons.manage_accounts,
              label: 'Create Client',
              isSelected: viewModel.currentIndex == 1,
              onTap: () => viewModel.setIndex(1),
            ),
            _buildNavItem(
              icon: Icons.settings,
              label: 'Settings',
              isSelected: viewModel.currentIndex == 2,
              onTap: () => viewModel.setIndex(2),
            ),
          ],
        ),
      ),
    );
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Clock';
      case 1:
        return 'Attendance';
      case 2:
        return 'Leave';
      case 3:
        return 'Task';
      case 4:
        return 'Expense';
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
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 67,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInCubic,
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
