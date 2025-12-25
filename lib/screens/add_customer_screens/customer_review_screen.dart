import 'package:agent_application/constant/app_colors.dart';
import 'package:agent_application/constant/top_snackbar.dart';
import 'package:agent_application/screens/add_customer_screens/customer_provider.dart';
import 'package:agent_application/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerReviewScreen extends StatefulWidget {
  final int applicationId;

  const CustomerReviewScreen({super.key, required this.applicationId});

  @override
  State<CustomerReviewScreen> createState() => _CustomerReviewScreenState();
}

class _CustomerReviewScreenState extends State<CustomerReviewScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomerProvider>(
        context,
        listen: false,
      ).fetchReviewData(widget.applicationId);
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
          "Review Submitted Details",
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isReviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.reviewErrorMessage != null) {
            return Center(
              child: Text(
                provider.reviewErrorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = provider.reviewData;
          if (data == null) {
            return const Center(child: Text("No review data found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.greyBorder, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Application Details"),
                      _infoTile(
                        "First Name",
                        data.application.customerFirstName ?? "-",
                      ),
                      _infoTile(
                        "Last Name",
                        data.application.customerLastName ?? "-",
                      ),
                      _infoTile("Phone", data.application.phoneNumber ?? "-"),
                      _infoTile("DOB", data.application.dob ?? "-"),
                      _infoTile(
                        "Loan Purpose",
                        data.application.loanPurpose ?? "-",
                      ),
                      _infoTile(
                        "Loan Security",
                        data.application.loanSecurityType ?? "-",
                      ),
                      _infoTile(
                        "Employment Type",
                        data.application.employmentType ?? "-",
                      ),
                      _infoTile(
                        "Loan Amount",
                        data.application.loanAmountRequested?.toString() ?? "-",
                      ),
                      _infoTile(
                        "Existing Loans",
                        data.application.noExistingLoans?.toString() ?? "-",
                      ),
                      _infoTile(
                        "Existing EMIs",
                        data.application.existingEmis?.toString() ?? "-",
                      ),
                      SizedBox(height: 10),
                      _sectionTitle("KYC Details"),
                      _infoTile("Document Type", data.kyc?.documentType ?? "-"),
                      _infoTile(
                        "Document Number",
                        data.kyc?.documentNumber ?? "-",
                      ),
                      _infoTile(
                        "Aadhaar Number",
                        data.kyc?.aadhaarNumber ?? "-",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final provider = Provider.of<CustomerProvider>(
                          context,
                          listen: false,
                        );
                        final applicationId =
                            provider.reviewData?.application.id;

                        if (applicationId == null) return;

                        final success = await provider.submitApplication(
                          applicationId,
                        );

                        if (success) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DashboardScreen(),
                            ),
                            (route) => false,
                          );

                          showTopSnackBar(
                            context: context,
                            message: "Application submitted successfully!",
                            backgroundColor: Colors.green,
                          );
                        } else {
                          final message =
                              provider.submitErrorMessage?.replaceFirst(
                                'Exception: ',
                                '',
                              ) ??
                              'Something went wrong';
                          showTopSnackBar(
                            context: context,
                            message: message,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      label: const Text(
                        "Submit Details",
                        style: TextStyle(color: AppColors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
