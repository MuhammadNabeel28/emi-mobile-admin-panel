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
        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        itemCount: viewModel.acDetailModel?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: viewModel.acDetailModel?[index].accountId == 1 ? 295 : 345,
            width: double.infinity,
            child: Card(
              elevation: 10,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account Name:',
                          style: AppFonts.semiBold(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          viewModel.acDetailModel?[index].accountName ?? '',
                          style: AppFonts.semiBold(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Account Id:',
                              style: AppFonts.semiBold(fontSize: 17)),
                          Text(
                              '${viewModel.acDetailModel?[index].accountId ?? ''}',
                              style: AppFonts.semiBold(fontSize: 17)),
                        ]),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email:',
                          style: AppFonts.semiBold(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                            viewModel.acDetailModel?[index].email ??
                                'Not Available',
                            style: AppFonts.semiBold(fontSize: 17)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Contact Info:',
                            style: AppFonts.semiBold(fontSize: 17)),
                        Text(
                            viewModel.acDetailModel?[index].contactInfo ??
                                'Not Available',
                            style: AppFonts.semiBold(fontSize: 17)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('licenseKey:',
                            style: AppFonts.semiBold(fontSize: 17)),
                        Text(
                          '${viewModel.acDetailModel?[index].licenseKey ?? 'Not Available'}',
                          style: AppFonts.semiBold(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Device Limit:',
                            style: AppFonts.semiBold(fontSize: 17)),
                        Text(
                            '${viewModel.acDetailModel?[index].deviceLimit ?? 'Not Available'}',
                            style: AppFonts.semiBold(fontSize: 17)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expiry Date:',
                          style: AppFonts.semiBold(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          viewModel.acDetailModel?[index].expiryDate ??
                              'Not Available',
                          style: AppFonts.semiBold(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Is Master:',
                            style: AppFonts.semiBold(fontSize: 17)),
                        Text(
                            '${viewModel.acDetailModel?[index].isMaster ?? 'Not Available'}',
                            style: AppFonts.semiBold(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Active Status:',
                            style: AppFonts.semiBold(fontSize: 17)),
                        viewModel.acDetailModel?[index].accountId == 1
                            ? Text('N/A',
                                style: AppFonts.semiBold(fontSize: 17))
                            : Switch(
                                value: viewModel
                                        .acDetailModel?[index].activeStatus ??
                                    false,
                                onChanged: (bool value) {
                                  viewModel.acDetailModel?[index].activeStatus =
                                      value;
                                  viewModel.isSwitchedActive = value;
                                  viewModel.toggleActive(index, value);
                                  viewModel.notifyListeners();
                                },
                                activeTrackColor: Colors.blueGrey,
                                activeThumbColor: Colors.green,
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Account Expire:',
                            style: AppFonts.semiBold(fontSize: 17)),
                        viewModel.acDetailModel?[index].accountId == 1
                            ? Text('N/A',
                                style: AppFonts.semiBold(fontSize: 17))
                            : Switch(
                                value:
                                    viewModel.acDetailModel?[index].isExpired ??
                                        false,
                                onChanged: (bool value) {
                                  viewModel.acDetailModel?[index].isExpired =
                                      value;
                                  viewModel.isSwitchedExpire = value;
                                  viewModel.toggleExpired(index, value);
                                  viewModel.notifyListeners();
                                },
                                activeTrackColor: Colors.green,
                                activeThumbColor: Colors.yellowAccent,
                              ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Created On:',
                            style: AppFonts.semiBold(fontSize: 17)),
                        Text(
                            viewModel.acDetailModel?[index].createdOn ??
                                'Not Available',
                            style: AppFonts.semiBold(fontSize: 17)),
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
  AdminDashboardViewModel viewModelBuilder(BuildContext context) =>
      AdminDashboardViewModel();

  @override
  void onViewModelReady(AdminDashboardViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadDetail();
  }
}
