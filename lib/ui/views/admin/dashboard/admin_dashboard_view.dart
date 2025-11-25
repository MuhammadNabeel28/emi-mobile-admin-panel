import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/admin/dashboard/admin_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdminDashboardView extends StackedView<AdminDashboardViewModel> {
  const AdminDashboardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    AdminDashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: ListView.builder(
        itemCount: viewModel.acDetailModel?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            height: 200,
            width: double.infinity,
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Name: ${viewModel.acDetailModel?[index].accountName ?? ''}',
                      style: AppFonts.semiBold(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Account Id: ${viewModel.acDetailModel?[index].accountId ?? ''}',
                        style: AppFonts.semiBold(fontSize: 17)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  AdminDashboardViewModel viewModelBuilder(BuildContext context) =>
      AdminDashboardViewModel();

  @override
  void onViewModelReady(AdminDashboardViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadDetail();
  }
}
