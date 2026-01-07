import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/admin/client/client_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ClientFormView extends StackedView<ClientFormViewModel> {
  const ClientFormView({super.key});

  @override
  Widget builder(
      BuildContext context, ClientFormViewModel viewModel, Widget? child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      child: AlertDialog(
        title: const Text('Create New Account'),
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
              SizedBox(height: 24),
              const Text('Account Type:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Master
                  GestureDetector(
                    onTap: () => viewModel.toggleIsMaster(true),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: viewModel.ismaster,
                          onChanged: (val) => viewModel.toggleIsMaster(true),
                          visualDensity:
                              VisualDensity.compact, // space kam karega
                        ),
                        const Text('Master'),
                      ],
                    ),
                  ),

                  const SizedBox(width: 32),

                  // Client
                  GestureDetector(
                    onTap: () => viewModel.toggleIsMaster(false),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<bool>(
                          value: false,
                          groupValue: viewModel.ismaster,
                          onChanged: (val) => viewModel.toggleIsMaster(false),
                          visualDensity: VisualDensity.compact,
                        ),
                        const Text('Client'),
                      ],
                    ),
                  ),
                ],
              )
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
      ),
    );
  }

  @override
  ClientFormViewModel viewModelBuilder(BuildContext context) =>
      ClientFormViewModel();
}
