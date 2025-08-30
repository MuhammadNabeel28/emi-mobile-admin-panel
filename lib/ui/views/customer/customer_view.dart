import 'package:emi_solution/ui/views/customer/customer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomerView extends StackedView<CustomerViewModel> {
  const CustomerView({super.key});

  @override
  Widget builder(
      BuildContext context, CustomerViewModel viewModel, Widget? child) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Customer View',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  CustomerViewModel viewModelBuilder(BuildContext context) =>
      CustomerViewModel();
}
