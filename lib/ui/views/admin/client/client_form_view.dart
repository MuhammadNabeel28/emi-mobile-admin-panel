import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/views/admin/client/client_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ClientFormView extends StackedView<ClientFormViewModel> {
  const ClientFormView({super.key});

  @override
  Widget builder(
      BuildContext context, ClientFormViewModel viewModel, Widget? child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      child: AlertDialog(
        title: Text('Create New Account',
            style: AppFonts.semiBold(
              fontSize: 20,
            )),
        content: SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Account Id',
                    labelText: 'Account Id',
                    hintStyle: AppFonts.regular(
                      fontSize: 10,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Account Name',
                    hintStyle: AppFonts.regular(
                      fontSize: 10,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Contact Info',
                    hintStyle: AppFonts.regular(
                      fontSize: 10,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'User Id',
                    hintStyle: AppFonts.regular(
                      fontSize: 10,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Device Limit',
                    hintStyle: AppFonts.regular(
                      fontSize: 10,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'example@domain.com',
                    hintStyle: AppFonts.regular(
                      fontSize: 10,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email required';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintStyle: AppFonts.regular(
                      fontSize: 10,
                    ),
                  ),
                ),
                TextField(
                  controller: viewModel.dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date Of Expiry',
                    hintStyle: AppFonts.regular(fontSize: 10),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      viewModel.pickedDate = pickedDate;
                      final formattedDate =
                          DateFormat('dd-MMM-yyyy').format(pickedDate);
                      viewModel.dateController.text = formattedDate;
                    }
                  },
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
                            visualDensity: VisualDensity.compact,
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
