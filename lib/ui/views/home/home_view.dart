import 'package:emi_solution/ui/views/admin/admin_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:emi_solution/ui/common/app_colors.dart';
import 'package:emi_solution/ui/common/ui_helpers.dart';

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
          child: const AdminView(),
        ),
      ]),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
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
