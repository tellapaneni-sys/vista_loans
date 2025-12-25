import 'package:agent_application/screens/add_customer_screens/customer_onboarding.dart';
import 'package:agent_application/screens/add_customer_screens/customer_review_screen.dart';
import 'package:agent_application/screens/pending_loan_status.dart/agent_provider.dart';
import 'package:agent_application/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApplicationDetailScreen extends StatefulWidget {
  const ApplicationDetailScreen({super.key});

  @override
  State<ApplicationDetailScreen> createState() =>
      _ApplicationDetailScreenState();
}

class _ApplicationDetailScreenState extends State<ApplicationDetailScreen> {
  final List<String> statuses = [
    "All",
    "Completed",
    "Pending",
    "Approved",
    "Rejected",
  ];
  final Map<String, Color> statusDarkColors = {
    "All": AppColors.primaryBlue,
    "Completed": AppColors.greyText,
    "Pending": AppColors.orangeColor,
    "Approved": AppColors.darkGreenColor,
    "Rejected": AppColors.redTabColor,
  };

  final Map<String, Color> statusLightColors = {
    "All": AppColors.shadowBlue,
    "Completed": AppColors.greyBorder,
    "Pending": AppColors.yellowColor,
    "Approved": AppColors.lightGreenColor,
    "Rejected": AppColors.lightPinkColor,
  };

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<PendingApplicationsProvider>();
      provider.fetchApplicationDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.black),
        title: const Text(
          "Vista Loans",
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<PendingApplicationsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final applications = provider.filteredApplications;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.greyBorder, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Loan Applications",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "View and manage all loan applications",
                  style: TextStyle(fontSize: 14, color: AppColors.greyText),
                ),
                SizedBox(height: 20),
                _statusFilter(provider),
                const SizedBox(height: 20),
                Divider(color: AppColors.greyBorder, thickness: 1, height: 1),
                Expanded(
                  child: applications.isEmpty
                      ? const Center(
                          child: Text("No applications found for this status"),
                        )
                      : ListView.builder(
                          itemCount: applications.length,
                          itemBuilder: (context, index) {
                            final app = applications[index];

                            return GestureDetector(
                              onTap: () {
                                if (app.applicationStatus.toLowerCase() ==
                                    'completed') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CustomerReviewScreen(
                                        applicationId: app.id,
                                        // isEdit: true,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddCustomerScreen(
                                        applicationId: app.id,
                                        isEdit: true,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: _getStatusBackgroundColor(
                                    app.applicationStatus,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: _getStatusBorderColor(
                                      app.applicationStatus,
                                    ),
                                    width: 2,
                                  ),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${app.firstName} ${app.lastName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),

                                    // _infoRow(
                                    //   "Customer Name",
                                    //   "${app.firstName} ${app.lastName}",
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Loan Amount',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              app.loan_amount_requested != null
                                                  ? formatAmount(
                                                      app.loan_amount_requested!,
                                                    )
                                                  : '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Updated At',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              app.updated_at != null
                                                  ? formatDateTime(
                                                      app.updated_at!,
                                                    )
                                                  : 'NA',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statusFilter(PendingApplicationsProvider provider) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: statuses.map((status) {
        final bool isSelected = provider.selectedStatus == status;

        final Color darkColor = statusDarkColors[status] ?? Colors.grey;
        final Color lightColor =
            statusLightColors[status] ?? Colors.grey.shade200;

        final Color bgColor = isSelected ? darkColor : lightColor;
        final Color textColor = isSelected ? Colors.white : darkColor;

        return GestureDetector(
          onTap: () => provider.changeStatus(status),
          child: SizedBox(
            width: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String dateTime) {
    final dt = DateTime.parse(dateTime);

    return DateFormat('dd/MM/yy h:mm a').format(dt);
  }

  String formatAmount(num amount) {
    String format(num value) =>
        value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);

    if (amount >= 10000000) {
      return '${format(amount / 10000000)} Cr';
    } else if (amount >= 100000) {
      return '${format(amount / 100000)} L';
    } else if (amount >= 1000) {
      return '${format(amount / 1000)} K';
    } else {
      return amount.toString();
    }
  }

  Color _getStatusBorderColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.orangeColor;
      case 'completed':
        return AppColors.greyText;
      case 'approved':
        return AppColors.darkGreenColor;
      case 'rejected':
        return AppColors.redTabColor;
      default:
        return AppColors.greyBorder;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.yellowColor.withOpacity(0.2);
      case 'completed':
        return AppColors.greyBorder.withOpacity(0.2);
      case 'approved':
        return AppColors.lightGreenColor.withOpacity(0.25);
      case 'rejected':
        return AppColors.lightPinkColor.withOpacity(0.25);
      default:
        return AppColors.white;
    }
  }
}
