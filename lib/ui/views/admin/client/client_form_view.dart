import 'package:emi_solution/ui/views/admin/client/client_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ClientFormView extends StackedView<ClientFormViewModel> {
  const ClientFormView({super.key});

  @override
  Widget builder(
      BuildContext context, ClientFormViewModel viewModel, Widget? child) {
    return AlertDialog(
      title: const Text('Client Form'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Client Name',
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Client Email',
              ),
            ),
            // Add more fields as necessary
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle form submission
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  ClientFormViewModel viewModelBuilder(BuildContext context) =>
      ClientFormViewModel();
}
