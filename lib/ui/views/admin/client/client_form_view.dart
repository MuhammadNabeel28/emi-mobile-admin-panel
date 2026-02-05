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
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : Container(
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
                        controller: viewModel.accountIdController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Account Id',
                          labelText: 'Account Id',
                          hintStyle: AppFonts.regular(
                            fontSize: 10,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Account ID required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          viewModel.accountIdController.text = value ?? '';
                        },
                      ),
                      TextFormField(
                        controller: viewModel.accountNameController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Account Name',
                          labelText: 'Account Name',
                          hintStyle: AppFonts.regular(
                            fontSize: 10,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Account Name required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          viewModel.accountNameController.text = value ?? '';
                        },
                      ),
                      TextFormField(
                        controller: viewModel.contactInfoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          viewModel.numberformater(),
                        ],
                        decoration: InputDecoration(
                          hintText: '0000-0000000',
                          labelText: 'Contact Info',
                          hintStyle: AppFonts.regular(
                            fontSize: 10,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Contact Info required';
                          }
                          if (!RegExp(r'^\d{4}-\d{7}$').hasMatch(value)) {
                            return 'Enter valid contact number';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          viewModel.contactInfoController.text = value ?? '';
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'User Id',
                          hintStyle: AppFonts.regular(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
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
                                  onChanged: (val) =>
                                      viewModel.toggleIsMaster(true),
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
                                  onChanged: (val) =>
                                      viewModel.toggleIsMaster(false),
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
