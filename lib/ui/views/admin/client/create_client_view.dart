import 'package:emi_solution/ui/views/admin/client/create_client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateClientView extends StackedView<CreateClientViewmodel> {
  const CreateClientView({super.key});

  @override
  Widget builder(
      BuildContext context, CreateClientViewmodel viewModel, Widget? child) {
    return const Scaffold(
      body: Center(
        child: Text('Create Client View'),
      ),
    );
  }

  @override
  CreateClientViewmodel viewModelBuilder(BuildContext context) =>
      CreateClientViewmodel();

}