import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/admin/admin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdminView extends StackedView<AdminViewModel> {
  const AdminView({super.key});

  @override
  Widget builder(
    BuildContext context,
    AdminViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            height: 200,
            width: double.infinity,
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Mobile Tech',
                          style: AppFonts.semiBold(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
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
  AdminViewModel viewModelBuilder(BuildContext context) => AdminViewModel();
}
