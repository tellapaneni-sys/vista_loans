import 'package:agent_application/constant/app_colors.dart';
import 'package:agent_application/screens/profile/profile_provider.dart';
import 'package:agent_application/screens/profile/terms_and_conditions.dart';
import 'package:agent_application/screens/profile/update_bank_details_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditingBank = false;
  bool isEditingAddress = false;

  final _bankFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  late ProfileProvider provider;

  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  late TextEditingController cityController;
  late TextEditingController pincodeController;
  late TextEditingController panController;
  late TextEditingController accountController;
  late TextEditingController bankNameController;
  late TextEditingController ifscController;

  @override
  void initState() {
    super.initState();

    address1Controller = TextEditingController();
    address2Controller = TextEditingController();
    cityController = TextEditingController();
    pincodeController = TextEditingController();
    panController = TextEditingController();
    accountController = TextEditingController();
    bankNameController = TextEditingController();
    ifscController = TextEditingController();

    // IMPORTANT: Initialize provider here
    provider = Provider.of<ProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.loadProfile(); // now safe to use provider
    });
  }

  String display(String v) => v.isEmpty ? 'NA' : v;

  @override
  void dispose() {
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    pincodeController.dispose();
    panController.dispose();
    accountController.dispose();
    bankNameController.dispose();
    ifscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Vista Loans',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = provider.user!;
          if (!isEditingBank && !isEditingAddress) {
            address1Controller.text = user.address1 ?? '';
            address2Controller.text = user.address2 ?? '';
            cityController.text = user.city ?? '';
            pincodeController.text = user.pincode?.toString() ?? '';
            panController.text = user.pan ?? '';
            accountController.text = user.accountNumber ?? '';
            bankNameController.text = user.bankName ?? '';
            ifscController.text = user.ifscCode ?? '';
          }
          final fullName = '${user.firstName} ${user.lastName}';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// USER INFO
                Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 32),
                        _buildInfoRow('Name', fullName),
                        _buildInfoRow('Phone Number', user.phoneNumber ?? ''),
                        _buildInfoRow('Email', user.email ?? ''),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// BANK DETAILS
                _editableCard(
                  title: 'Bank Account Details',
                  editing: isEditingBank,
                  onEditToggle: () =>
                      setState(() => isEditingBank = !isEditingBank),
                  editChild: Form(
                    key: _bankFormKey,
                    child: Column(
                      children: [
                        _requiredField(panController, 'PAN'),
                        _requiredField(accountController, 'Account Number'),
                        _requiredField(bankNameController, 'Bank Name'),
                        _requiredField(ifscController, 'IFSC Code'),
                        _saveButton(() async {
                          if (!_bankFormKey.currentState!.validate()) return;
                          await _saveBankDetails();
                          setState(() => isEditingBank = false);
                        }),
                      ],
                    ),
                  ),
                  viewChild: Column(
                    children: [
                      _buildInfoRow('PAN', display(panController.text)),
                      _buildInfoRow('Account', display(accountController.text)),
                      _buildInfoRow('Bank', display(bankNameController.text)),
                      _buildInfoRow('IFSC', display(ifscController.text)),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// ADDRESS DETAILS
                _editableCard(
                  title: 'Address Details',
                  editing: isEditingAddress,
                  onEditToggle: () =>
                      setState(() => isEditingAddress = !isEditingAddress),
                  editChild: Form(
                    key: _addressFormKey,
                    child: Column(
                      children: [
                        _requiredField(address1Controller, 'Address Line 1'),
                        TextFormField(
                          controller: address2Controller,
                          decoration: const InputDecoration(
                            labelText: 'Address Line 2',
                          ),
                        ),
                        _requiredField(cityController, 'City'),
                        _requiredField(pincodeController, 'Pincode'),
                        _saveButton(() async {
                          if (!_addressFormKey.currentState!.validate()) return;
                          await _saveAddressDetails();
                          setState(() => isEditingAddress = false);
                        }),
                      ],
                    ),
                  ),
                  viewChild: Column(
                    children: [
                      _buildInfoRow(
                        'Address 1',
                        display(address1Controller.text),
                      ),
                      _buildInfoRow(
                        'Address 2',
                        display(address2Controller.text),
                      ),
                      _buildInfoRow('City', display(cityController.text)),
                      _buildInfoRow('Pincode', display(pincodeController.text)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Legal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: AppColors.greyBorder),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TermsAndConditions(),
                                ),
                              );
                            },
                            child: const Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Danger Zone',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Permanently delete your account and all data',
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, 
                            elevation:
                                0, 
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8,
                              ), 
                              side: const BorderSide(
                                color: Colors.red,
                                width: 2, 
                              ),
                            ),
                          ),
                          child: const Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveBankDetails() async {
    if (!_bankFormKey.currentState!.validate()) return;

    try {
      await provider.saveDetails(
        UpdateDetails(
          address1: address1Controller.text,
          address2: address2Controller.text,
          city: cityController.text,
          pincode: pincodeController.text,
          pan: panController.text,
          accountNumber: accountController.text,
          bankName: bankNameController.text,
          ifscCode: ifscController.text,
        ),
      );

      // Sync ALL controllers with fresh data from backend
      final user = provider.user!;
      address1Controller.text = user.address1 ?? '';
      address2Controller.text = user.address2 ?? '';
      cityController.text = user.city ?? '';
      pincodeController.text = user.pincode?.toString() ?? '';
      panController.text = user.pan ?? '';
      accountController.text = user.accountNumber ?? '';
      bankNameController.text = user.bankName ?? '';
      ifscController.text = user.ifscCode ?? '';

      _toast(context, 'Bank details updated successfully');
    } catch (e) {
      _toast(context, 'Failed to update: $e');
      print("Save error: $e");
    } finally {
      setState(() => isEditingBank = false);
    }
  }

  // SAVE ADDRESS DETAILS (but send ALL fields)
  Future<void> _saveAddressDetails() async {
    if (!_addressFormKey.currentState!.validate()) return;

    try {
      await provider.saveDetails(
        UpdateDetails(
          address1: address1Controller.text,
          address2: address2Controller.text,
          city: cityController.text,
          pincode: pincodeController.text,
          pan: panController.text,
          accountNumber: accountController.text,
          bankName: bankNameController.text,
          ifscCode: ifscController.text,
        ),
      );

      // Sync ALL controllers
      final user = provider.user!;
      address1Controller.text = user.address1 ?? '';
      address2Controller.text = user.address2 ?? '';
      cityController.text = user.city ?? '';
      pincodeController.text = user.pincode?.toString() ?? '';
      panController.text = user.pan ?? '';
      accountController.text = user.accountNumber ?? '';
      bankNameController.text = user.bankName ?? '';
      ifscController.text = user.ifscCode ?? '';

      _toast(context, 'Address updated successfully');
    } catch (e) {
      _toast(context, 'Failed to update: $e');
      print("Save error: $e");
    } finally {
      setState(() => isEditingAddress = false);
    }
  }

  /// UI HELPERS
  Widget _editableCard({
    required String title,
    required bool editing,
    required VoidCallback onEditToggle,
    required Widget editChild,
    required Widget viewChild,
  }) {
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _sectionHeader(title, editing, onEditToggle),
            const SizedBox(height: 12),
            editing ? editChild : viewChild,
          ],
        ),
      ),
    );
  }

  Widget _requiredField(TextEditingController c, String label) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(labelText: label),
      validator: (v) =>
          v == null || v.trim().isEmpty ? '$label is required' : null,
    );
  }

  Widget _saveButton(VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onTap, child: const Text('Save')),
    );
  }

  Widget _sectionHeader(String title, bool editing, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onTap, child: Text(editing ? 'Cancel' : 'Edit')),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
