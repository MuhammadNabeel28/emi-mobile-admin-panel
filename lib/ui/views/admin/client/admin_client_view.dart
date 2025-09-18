import 'package:emi_solution/ui/views/admin/client/admin_client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdminClientView extends StackedView<AdminClientViewModel> {
  const AdminClientView({super.key});

  @override
  Widget builder(
      BuildContext context, AdminClientViewModel viewModel, Widget? child) {
    return const Scaffold(
      body: Center(
        child: Text('Admin Client View'),
      ),
    );
  }

  @override
  AdminClientViewModel viewModelBuilder(BuildContext context) =>
      AdminClientViewModel();
}
