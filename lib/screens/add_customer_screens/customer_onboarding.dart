import 'package:agent_application/constant/app_colors.dart';
import 'package:agent_application/constant/app_prefs.dart';
import 'package:agent_application/constant/custom_textfield.dart';
import 'package:agent_application/constant/top_snackbar.dart';
import 'package:agent_application/screens/add_customer_screens/customer_assets_response.dart';
import 'package:agent_application/screens/add_customer_screens/customer_basic_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_income_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_kyc_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_occupation_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_provider.dart';
import 'package:agent_application/screens/add_customer_screens/customer_review_screen.dart';
import 'package:agent_application/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddCustomerScreen extends StatefulWidget {
  final int? applicationId;
  final bool isEdit;

  const AddCustomerScreen({super.key, this.applicationId, this.isEdit = false});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final nameController = TextEditingController();
  final sirnameCOntroller = TextEditingController();
  final emailCOntroller = TextEditingController();
  final loanPurposeCOntroller = TextEditingController();
  final phonenumberCOntroller = TextEditingController();
  final dobCOntroller = TextEditingController();
  final typeOfLoanCOntroller = TextEditingController();
  final loanCategoryCOntroller = TextEditingController();
  final requiredLoanAmountCOntroller = TextEditingController();
  final existingLoanAmountCOntroller = TextEditingController();
  final existingEMIAmountCOntroller = TextEditingController();
  final pincodeCOntroller = TextEditingController();
  final addressCOntroller = TextEditingController();
  final monthlyIncomeController = TextEditingController();
  final experienceController = TextEditingController();
  final landInAcresController = TextEditingController();
  Set<int> _savedTabs = {}; 

  String? selectedKycType;
  String? _selectedPaymentMethod;

  final panController = TextEditingController();
  final voterIdController = TextEditingController();
  final aadhaarController = TextEditingController();

  final _basicFormKey = GlobalKey<FormState>();
  final _basicCustomerFormKey = GlobalKey<FormState>();
  final _kycFormKey = GlobalKey<FormState>();
  final _incomeFormKey = GlobalKey<FormState>();
  String? selectedLoanType; 
  String? selectedEmploymentType; 
  bool _basicSubmitted = false;
  bool _basicCustomerScreen2Submitted = false;
  String? selectedOccupation;
  final otherOccupationController = TextEditingController();
  bool _occupationSubmitted = false;
  String? selectedShopOwnershipType;
  Map<String, String> _assetSelection = {
    "Two Wheeler": "",
    "Four Wheeler": "",
    "Own House": "",
    "Agricultural Land": "",
  };

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadReviewData();
    });
    panController.addListener(() {
      if (panController.text.trim().isNotEmpty && selectedKycType != "PAN") {
        setState(() {
          selectedKycType = "PAN";
        });
      }
    });

    voterIdController.addListener(() {
      if (voterIdController.text.trim().isNotEmpty &&
          selectedKycType != "VOTER") {
        setState(() {
          selectedKycType = "VOTER";
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    monthlyIncomeController.dispose();
    experienceController.dispose();
    nameController.dispose();
    sirnameCOntroller.dispose();
    emailCOntroller.dispose();
    phonenumberCOntroller.dispose();
    dobCOntroller.dispose();
    typeOfLoanCOntroller.dispose();
    loanCategoryCOntroller.dispose();
    requiredLoanAmountCOntroller.dispose();
    existingLoanAmountCOntroller.dispose();
    panController.dispose();
    landInAcresController.dispose();
    voterIdController.dispose();
    aadhaarController.dispose();
    otherOccupationController.dispose();

    super.dispose();
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
      body: Container(
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
            const SizedBox(height: 8),
            const Text(
              "Onboard New Customer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            // const Text(
            //   "Complete all tabs to onboard a customer",
            //   style: TextStyle(color: AppColors.greyText, fontSize: 12),
            // ),
            const SizedBox(height: 12),
            _stepTabs(),
            const SizedBox(height: 12),

            Expanded(
              child: Card(
                color: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _basicDataTab(),
                    _cutomerBasicDataTab(),
                    _kycTab(),
                    _occupationTab(),
                    _assetTab(),
                    _incomeTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _basicDataTab() {
    return Form(
      key: _basicFormKey,
      child: _formWrapper([
        const Text(
          "Name",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Name",
          nameController,
          validator: (v) => v!.isEmpty ? "Name is required" : null,
        ),
        const Text(
          "Surname",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Surname",
          sirnameCOntroller,
          validator: (v) => v!.isEmpty ? "Surname is required" : null,
        ),
        const Text(
          "Phone Number",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Phone Number",
          phonenumberCOntroller,
          keyboardType: TextInputType.phone,
          validator: (v) {
            if (v!.isEmpty) return "Phone number required";
            if (v.length != 10) return "Enter valid 10 digit number";
            return null;
          },
        ),
        const Text(
          "PAN Number",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _inputForKYC(
          "PAN Card Number",
          panController,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
            LengthLimitingTextInputFormatter(10),
            UpperCaseTextFormatter(),
          ],
          validator: (v) {
            if (v == null || v.isEmpty) return null;
            if (v.length != 10) return "PAN must be 10 characters";
            if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(v)) {
              return "Enter valid PAN (ABCDE1234F)";
            }
            return null;
          },
        ),
        const Text(
          "Date of Birth",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: _pickDob,
          child: AbsorbPointer(
            child: _input(
              "Date of Birth",
              dobCOntroller,
              validator: (v) => v!.isEmpty ? "DOB required" : null,
            ),
          ),
        ),
        _saveButton(
          "Save Basic Data",
          onTap: () async {
            setState(() {
              _basicSubmitted = true;
            });

            final isFormValid = _basicFormKey.currentState!.validate();

            if (!isFormValid) return;

            final provider = Provider.of<CustomerProvider>(
              context,
              listen: false,
            );

            final request = CustomerBasicRequest(
              firstName: nameController.text.trim(),
              lastName: sirnameCOntroller.text.trim(),
              phoneNumber: phonenumberCOntroller.text.trim(),
              dob: formatDob(dobCOntroller.text.trim()),
              pan: panController.text.trim(),
            );

            final response = await provider.submitBasicData(request);

            if (provider.errorMessage == null && response != null) {
              final appId = response.applicationId;
              await AppPrefs.setApplicationId(appId);

              _savedTabs.add(0);
              showTopSnackBar(
                context: context,
                message: "Details are Saved Successfully",
                backgroundColor: Colors.green,
              );

              _tabController.animateTo(1);
            } else {
              final message =
                  provider.errorMessage?.replaceFirst('Exception: ', '') ??
                  'Something went wrong';
              showTopSnackBar(
                context: context,
                message: message,
                backgroundColor: Colors.red,
              );
            }
          },
        ),
      ]),
    );
  }

  Widget _cutomerBasicDataTab() {
    return Form(
      key: _basicCustomerFormKey,
      child: _formWrapper([
        const Text(
          "Email Address",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Email Address",
          emailCOntroller,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.isEmpty) return "Email required";
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
              return "Enter valid email";
            }
            return null;
          },
        ),
        const Text(
          "Loan Purpose",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Loan Purpose",
          loanPurposeCOntroller,
          validator: (v) {
            if (v == null || v.isEmpty) return "Loan Purpose is required";
            return null;
          },
        ),
        _sectionTitle("Secured Loan or Unsecured Loan *"),
        Row(
          children: [
            Expanded(
              child: _selectCard(
                label: "Secured Loan",
                icon: Icons.shield_outlined,
                selected: selectedLoanType == "Secured",
                onTap: () {
                  setState(() {
                    selectedLoanType = "Secured";
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _selectCard(
                label: "Unsecured Loan",
                icon: Icons.security_outlined,
                selected: selectedLoanType == "Unsecured",
                onTap: () {
                  setState(() {
                    selectedLoanType = "Unsecured";
                  });
                },
              ),
            ),
          ],
        ),

        if (_basicCustomerScreen2Submitted && selectedLoanType == null)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              "Please select loan type",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        _sectionTitle("Type of Employment *"),
        Row(
          children: [
            Expanded(
              child: _selectCard(
                label: "Salaried",
                icon: Icons.work_outline,
                selected: selectedEmploymentType == "Salaried",
                onTap: () {
                  setState(() {
                    selectedEmploymentType = "Salaried";
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _selectCard(
                label: "Business",
                icon: Icons.storefront_outlined,
                selected: selectedEmploymentType == "Business",
                onTap: () {
                  setState(() {
                    selectedEmploymentType = "Business";
                  });
                },
              ),
            ),
          ],
        ),

        if (_basicCustomerScreen2Submitted && selectedEmploymentType == null)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              "Please select employment type",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

        SizedBox(height: 10),
        const Text(
          "Loan Amount Needed (in INR)",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),

        _input(
          "Loan Amount Needed",
          requiredLoanAmountCOntroller,
          keyboardType: TextInputType.number,
          validator: (v) => v!.isEmpty ? "Loan amount required" : null,
        ),
        const Text(
          "Existing Loans (in INR)",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Existing Loans",
          existingLoanAmountCOntroller,
          keyboardType: TextInputType.number,
        ),
        const Text(
          "Existing EMIS (in INR)",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Existing EMIs",
          existingEMIAmountCOntroller,
          keyboardType: TextInputType.number,
        ),
        const Text(
          "Address",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input("Address", addressCOntroller, keyboardType: TextInputType.text),
        const Text(
          "Pincode",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "pincode",
          pincodeCOntroller,
          keyboardType: TextInputType.number,
        ),
        _saveButton(
          "Save Data",
          onTap: () async {
            setState(() {
              _basicCustomerScreen2Submitted = true;
            });

            final isFormValid = _basicCustomerFormKey.currentState!.validate();
            final isSelectionValid =
                selectedLoanType != null && selectedEmploymentType != null;

            if (!isFormValid || !isSelectionValid) return;

            final provider = Provider.of<CustomerProvider>(
              context,
              listen: false,
            );
            final applicationId = await AppPrefs.getApplicationId();
            final request = CustomerScreen2BasicRequest(
              applicationId: applicationId!,
              loanPurpose: "home",
              loanSecurityType: selectedLoanType == "Secured"
                  ? "secured_loan"
                  : "unsecured_loan",
              employmentType: selectedEmploymentType == "Salaried"
                  ? "salaried"
                  : "business",
              loanAmountRequested: requiredLoanAmountCOntroller.text.trim(),
              noExistingLoans: existingLoanAmountCOntroller.text.isEmpty
                  ? 0
                  : 1,
              existingEmis: existingEMIAmountCOntroller.text.isEmpty ? 0 : 1,
              address: addressCOntroller.text.trim(),
              pincode: pincodeCOntroller.text.trim(),

              email: emailCOntroller.text.trim(),
            );

            final response = await provider.submitScreen2BasicData(request);

            if (provider.errorMessage == null && response != null) {
              showTopSnackBar(
                context: context,
                message: "Details are saved successfully",
                backgroundColor: Colors.green,
              );

              _tabController.animateTo(2);
              _savedTabs.add(1);
            } else {
              final message =
                  provider.errorMessage?.replaceFirst('Exception: ', '') ??
                  'Something went wrong';
              showTopSnackBar(
                context: context,
                message: message,
                backgroundColor: Colors.red,
              );
            }
          },
        ),
      ]),
    );
  }

  Widget _kycTab() {
    return Form(
      key: _kycFormKey,
      child: _formWrapper([
        _choiceRowForKYC(),

        if (selectedKycType == "PAN") ...[
          const Text(
            "PAN Number",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkText,
              fontWeight: FontWeight.bold,
            ),
          ),
          _inputForKYC(
            "PAN Card Number",
            panController,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
              LengthLimitingTextInputFormatter(10),
              UpperCaseTextFormatter(),
            ],
            validator: (v) {
              if (v == null || v.isEmpty) return "PAN is required";
              if (v.length != 10) return "PAN must be 10 characters";
              if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(v)) {
                return "Enter valid PAN (ABCDE1234F)";
              }
              return null;
            },
          ),
        ],

        if (selectedKycType == "VOTER") ...[
          const Text(
            "Voter ID Number",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkText,
              fontWeight: FontWeight.bold,
            ),
          ),
          _inputForKYC(
            "Voter ID",
            voterIdController,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
              LengthLimitingTextInputFormatter(10),
              UpperCaseTextFormatter(),
            ],
            validator: (v) {
              if (v == null || v.isEmpty) return "Voter ID required";
              if (v.length != 10) return "Voter ID must be 10 characters";
              if (!RegExp(r'^[A-Z]{3}[0-9]{7}$').hasMatch(v)) {
                return "Enter valid Voter ID (ABC1234567)";
              }
              return null;
            },
          ),
        ],

        _inputForKYC(
          "Aadhaar Number (12 digits)",
          aadhaarController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(12),
          ],
          validator: (v) {
            if (v == null || v.isEmpty) return "Aadhaar required";
            if (v.length != 12) return "Aadhaar must be 12 digits";
            return null;
          },
        ),

        _saveButton("Save KYC Data", onTap: _saveKyc),
      ]),
    );
  }

  void _saveKyc() async {
    if (selectedKycType == null) {
      showTopSnackBar(
        context: context,
        message: "Please Select KYC document",
        backgroundColor: Colors.red,
      );

      return;
    }

    if (!_kycFormKey.currentState!.validate()) return;

    final applicationId = await AppPrefs.getApplicationId();

    if (applicationId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Application ID missing")));
      return;
    }

    final provider = Provider.of<CustomerProvider>(context, listen: false);

    final request = CustomerKycRequest(
      applicationId: applicationId,
      kycDocumentType: selectedKycType == "PAN" ? "pan" : "voter",
      documentNumber: selectedKycType == "PAN"
          ? panController.text.trim()
          : voterIdController.text.trim(),
      aadhaarNumber: aadhaarController.text.trim(),
    );

    await provider.submitKycData(request: request);

    if (provider.errorKYCMessage == null) {
      showTopSnackBar(
        context: context,
        message: "KYC Details Saved Successfully",
        backgroundColor: Colors.green,
      );

      _tabController.animateTo(3);
      _savedTabs.add(2);
    } else {
      final message =
          provider.errorKYCMessage?.replaceFirst('Exception: ', '') ??
          'Something went wrong';
      showTopSnackBar(
        context: context,
        message: message,
        backgroundColor: Colors.red,
      );
    }
  }

  Widget _occupationTab() {
    final items = [
      "Salaried",
      "Kirana Shop",
      "Hardware Shop",
      "Automobile Shop",
      "Vegetable Shop",
      "Medical Shop",
      "Electronics",
      "General Store",
      "Agriculture",
      "Daily Wage",
      "Self Employed",
      "Others",
    ];

    bool showShopOwnership =
        selectedOccupation != "Salaried" &&
        selectedOccupation != "Daily Wage" &&
        selectedOccupation != "Others";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true, 
            physics:
                const NeverScrollableScrollPhysics(), 
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, i) {
              final item = items[i];
              final isSelected = selectedOccupation == item;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOccupation = item;
                    if (item != "Others") {
                      otherOccupationController?.clear();
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFE3F2FD) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF0D47A1)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF0D47A1)
                            : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
          if (showShopOwnership) ...[
            const SizedBox(height: 20),
            if (selectedOccupation == "Others")
              CustomTextField(
                hint: "Specify your occupation",
                controller: otherOccupationController,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? "Please specify occupation"
                    : null,
              ),

            const SizedBox(height: 12),
            const Text(
              "Shop Ownership Type",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.darkText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _selectCard(
                    label: "Own Shop",
                    icon: Icons.shield_outlined,
                    selected: selectedShopOwnershipType == "Own Shop",
                    onTap: () {
                      setState(() {
                        selectedShopOwnershipType = "Own Shop";
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _selectCard(
                    label: "Rented Shop",
                    icon: Icons.security_outlined,
                    selected: selectedShopOwnershipType == "Rented Shop",
                    onTap: () {
                      setState(() {
                        selectedShopOwnershipType = "Rented Shop";
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
          if (_occupationSubmitted &&
              (selectedOccupation == null ||
                  (selectedOccupation == "Others" &&
                      otherOccupationController.text.trim().isEmpty)))
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                "Please select or specify an occupation",
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),

          const SizedBox(height: 20),
          _saveButton(
            "Save Occupation",
            onTap: () async {
              setState(() {
                _occupationSubmitted = true;
              });

              final isValid =
                  selectedOccupation != null &&
                  (selectedOccupation != "Others" ||
                      otherOccupationController.text.trim().isNotEmpty) &&
                  (!showShopOwnership || selectedShopOwnershipType != null);

              if (!isValid) {
                return;
              }

              final appId = await AppPrefs.getApplicationId();
              if (appId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Application ID missing")),
                );
                return;
              }

              final provider = Provider.of<CustomerProvider>(
                context,
                listen: false,
              );

              final request = CustomerOccupationRequest(
                applicationId: appId,
                occupationName: selectedOccupation == "Others"
                    ? otherOccupationController.text.trim()
                    : selectedOccupation!,
                occupationOwnershipType: selectedShopOwnershipType == "Own Shop"
                    ? "own"
                    : "rent",
              );

              final response = await provider.submitOccupationData(
                request: request,
              );

              if (provider.errorOccupationMessage == null && response != null) {
                await AppPrefs.setApplicationId(response.applicationId);
                showTopSnackBar(
                  context: context,
                  message: "Occupation Details Saved Successfully",
                  backgroundColor: Colors.green,
                );
                _savedTabs.add(3);
                _tabController.animateTo(4); 
              } else {
                final message =
                    provider.errorOccupationMessage?.replaceFirst(
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
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _assetTab() {
    return _formWrapper([
      _yesNo("Two Wheeler", Icons.directions_bike_outlined),
      _yesNo("Four Wheeler", Icons.car_repair),
      _yesNo("Own House", Icons.home),
      _yesNo("Agricultural Land", Icons.agriculture),
      if (_assetSelection["Agricultural Land"] == "Yes") ...[
        const Text(
          "How Many Acres ?",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        _input(
          "Land Acres",
          landInAcresController,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return "Land Acres is required";
            }
            final value = int.tryParse(v.trim());
            if (value == null) return "Enter a valid whole number";
            if (value <= 0) return "Land Acres must be greater than 0";
            return null;
          },
        ),
      ],

      _saveButton(
        "Save Asset Details",
        onTap: () async {
          final hasAnyAsset = _assetSelection.values.any((v) => v.isNotEmpty);

          if (!hasAnyAsset) {
            showTopSnackBar(
              context: context,
              message: 'Please select at least one asset',
              backgroundColor: Colors.red,
            );
            return;
          }

          if (_assetSelection["Agricultural Land"] == "Yes") {
            final landText = landInAcresController.text.trim();

            if (landText.isEmpty) {
              showTopSnackBar(
                context: context,
                message: "Please enter land acres",
                backgroundColor: Colors.red,
              );
              return;
            }

            final acres = int.tryParse(landText);
            if (acres == null || acres <= 0) {
              showTopSnackBar(
                context: context,
                message: "Land acres must be a valid number greater than 0",
                backgroundColor: Colors.red,
              );
              return;
            }
          }

          final appId = await AppPrefs.getApplicationId();
          if (appId == null) {
            showTopSnackBar(
              context: context,
              message: "Application ID missing",
              backgroundColor: Colors.red,
            );
            return;
          }

          final provider = Provider.of<CustomerProvider>(
            context,
            listen: false,
          );

          final request = CustomerAssetRequest(
            applicationId: appId,
            hasTwoWheeler: _assetSelection['Two Wheeler'] ?? "",
            hasFourWheeler: _assetSelection['Four Wheeler'] ?? "",
            hasOwnHouse: _assetSelection['Own House'] ?? "",
            agricultureLandAcres: _assetSelection["Agricultural Land"] == "Yes"
                ? double.parse(landInAcresController.text.trim())
                : 0.0,
          );

          final response = await provider.submitAssetData(request: request);

          if (provider.errorAssetMessage == null && response != null) {
            await AppPrefs.setApplicationId(response.applicationId);

            showTopSnackBar(
              context: context,
              message: "Asset Details Saved Successfully",
              backgroundColor: Colors.green,
            );

            _savedTabs.add(4);
            _tabController.animateTo(5);
          } else {
            final message =
                provider.errorAssetMessage?.replaceFirst('Exception: ', '') ??
                'Something went wrong';

            showTopSnackBar(
              context: context,
              message: message,
              backgroundColor: Colors.red,
            );
          }
        },
      ),
    ]);
  }

  Widget _incomeTab() {
    return Form(
      key:
          _incomeFormKey, 
      child: _formWrapper([
        const Text(
          "Income Amount (Monthly)",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _input(
          "Monthly Income",
          monthlyIncomeController,
          keyboardType: TextInputType.number,
          validator: (v) => v!.isEmpty ? "Monthly income is required" : null,
        ),
        const Text(
          "Income Type",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _choiceRow(["Cash", "Cash & UPI", "Bank Transfer"]),
        const Text(
          "Years in Business/Experience",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _input(
          "Years in Business / Experience",
          experienceController,
          keyboardType: TextInputType.number,
          // validator: (v) => v!.isEmpty ? "Experience is required" : null,
        ),
        _saveButton(
          "Save Income Details",
          onTap: () async {
            if (_selectedPaymentMethod == null) {
              showTopSnackBar(
                context: context,
                message: 'Please select a payment method',
                backgroundColor: Colors.red,
              );
              return;
            }

            if (!(_incomeFormKey.currentState?.validate() ?? false)) return;

            final applicationId = await AppPrefs.getApplicationId();
            if (applicationId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Application ID missing")),
              );
              return;
            }
            String apiIncomeType;
            switch (_selectedPaymentMethod) {
              case "Cash":
                apiIncomeType = "cash";
                break;
              case "Cash & UPI":
                apiIncomeType = "upi";
                break;
              case "Bank Transfer":
                apiIncomeType = "bank";
                break;
              default:
                apiIncomeType = "cash"; 
            }

            final request = CustomerIncomeRequest(
              applicationId: applicationId,
              incomeAmount: monthlyIncomeController.text.trim(),
              incomeType: apiIncomeType,
              experienceYears:
                  int.tryParse(experienceController.text.trim()) ?? 0,
            );

            final provider = Provider.of<CustomerProvider>(
              context,
              listen: false,
            );
            final response = await provider.submitIncomeData(request);

            if (provider.errorMessage == null && response != null) {
              showTopSnackBar(
                context: context,
                message: "Income Details Saved Successfully",
                backgroundColor: Colors.green,
              );

              _savedTabs.add(5);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CustomerReviewScreen(applicationId: applicationId),
                ),
              );
            } else {
              final message =
                  provider.errorMessage?.replaceFirst('Exception: ', '') ??
                  'Something went wrong';
              showTopSnackBar(
                context: context,
                message: message,
                backgroundColor: Colors.red,
              );
            }
          },
        ),
      ]),
    );
  }

  Widget _formWrapper(List<Widget> children) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _input(
    String hintText,
    TextEditingController controller, {
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CustomTextField(
        hint: hintText,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _choiceRow(List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: options.map((option) {
          final isSelected = _selectedPaymentMethod == option;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedPaymentMethod = option;
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: isSelected ? AppColors.primaryBlue : null,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(option, style: TextStyle(fontSize: 12)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _choiceRowForKYC() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: _selectCard(
              label: "PAN Card",
              icon: Icons.credit_card,
              selected: selectedKycType == "PAN",
              onTap: () {
                if (voterIdController.text.trim().isNotEmpty) {
                  showTopSnackBar(
                    context: context,
                    message: "Clear Voter ID details before switching to PAN",
                    backgroundColor: Colors.red,
                  );
                  return;
                }

                setState(() {
                  selectedKycType = "PAN";
                  if (!widget.isEdit) {
                    _kycFormKey.currentState?.reset();
                    aadhaarController.clear();
                  }
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _selectCard(
              label: "Voter ID",
              icon: Icons.how_to_vote,
              selected: selectedKycType == "VOTER",
              onTap: () {
                if (panController.text.trim().isNotEmpty) {
                  showTopSnackBar(
                    context: context,
                    message: "Clear PAN details before switching to Voter ID",
                    backgroundColor: Colors.red,
                  );
                  return;
                }

                setState(() {
                  selectedKycType = "VOTER";
                  _kycFormKey.currentState?.reset();
                  aadhaarController.clear();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _yesNo(String label, IconData icon) {
    _assetSelection.putIfAbsent(label, () => "");

    final isSelected = [
      _assetSelection[label] == "Yes",
      _assetSelection[label] == "No",
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 5),
              Icon(icon, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          ToggleButtons(
            isSelected: isSelected,
            borderRadius: BorderRadius.circular(8),
            constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
            onPressed: (index) {
              setState(() {
                _assetSelection[label] = index == 0 ? "Yes" : "No";
                if (label == "Agricultural Land" && index == 1) {
                  landInAcresController.clear();
                }
              });
            },
            children: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 18),
                  SizedBox(width: 6),
                  Text("Yes"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined, size: 18),
                  SizedBox(width: 6),
                  Text("No"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget yesNo(String label) {
    _assetSelection.putIfAbsent(label, () => ""); 
    bool isYesSelected = _assetSelection[label] == "Yes";
    bool isNoSelected = _assetSelection[label] == "No";

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _assetSelection[label] = "Yes";
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: isYesSelected ? Colors.blue : null,
                  foregroundColor: isYesSelected ? Colors.white : Colors.black,
                ),
                child: const Text("Yes"),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _assetSelection[label] = "No";
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: isNoSelected ? Colors.blue : null,
                  foregroundColor: isNoSelected ? Colors.white : Colors.black,
                ),
                child: const Text("No"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _saveButton(String text, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepTabs() {
    final tabs = ["Basic", "Customer", "KYC", "Occupation", "Asset", "Income"];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(tabs.length, (index) {
        final isSaved = _savedTabs.contains(index);
        final isActive = _tabController.index == index;

        Color bgColor;
        Color textColor;

        if (isSaved) {
          bgColor = Colors.green;
          textColor = Colors.white;
        } else if (isActive) {
          bgColor = AppColors.redTabColor;
          textColor = Colors.white;
        } else {
          bgColor = AppColors.greyBorder;
          textColor = Colors.black87;
        }

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _tabController.animateTo(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSaved)
                  const Icon(Icons.check_circle, size: 14, color: Colors.white),
                if (isSaved) const SizedBox(width: 4),
                Text(
                  tabs[index],
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _selectCard({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE3F2FD) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF1565C0) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? const Color(0xFF1565C0) : Colors.grey),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: selected ? const Color(0xFF1565C0) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.darkText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      dobCOntroller.text = formatted;
    }
  }

  String formatDob(String input) {
    if (input.length == 8) {
      final day = input.substring(0, 2);
      final month = input.substring(2, 4);
      final year = input.substring(4, 8);
      return "$year-$month-$day";
    }
    return input;
  }

  Widget _inputForKYC(
    String hintText,
    TextEditingController controller, {
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.greyBorder,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Future<void> _loadReviewData() async {
    final provider = context.read<CustomerProvider>();

    await provider.fetchReviewData(widget.applicationId!);
    if (!mounted) return;

    final review = provider.reviewData;
    if (review == null) {
      debugPrint("❌ Review data still null");
      return;
    }

    final app = review.application;
    final kyc = review.kyc;

    nameController.text = app.customerFirstName ?? '';
    sirnameCOntroller.text = app.customerLastName ?? '';
    phonenumberCOntroller.text = app.phoneNumber ?? '';
    dobCOntroller.text = app.dob ?? '';

    loanPurposeCOntroller.text = app.loanPurpose ?? '';

    requiredLoanAmountCOntroller.text =
        app.loanAmountRequested?.toString() ?? '';

    existingLoanAmountCOntroller.text = app.noExistingLoans == 1 ? 'Yes' : '';

    existingEMIAmountCOntroller.text = app.existingEmis == 1 ? 'Yes' : '';

    selectedLoanType = app.loanSecurityType == 'secured_loan'
        ? 'Secured'
        : 'Unsecured';

    selectedEmploymentType = app.employmentType == 'salaried'
        ? 'Salaried'
        : 'Business';

    if (kyc != null) {
      selectedKycType = kyc.documentType == 'pan' ? 'PAN' : 'VOTER';

      aadhaarController.text = kyc.aadhaarNumber ?? '';

      if (selectedKycType == 'PAN') {
        panController.text = kyc.documentNumber ?? '';
      } else {
        voterIdController.text = kyc.documentNumber ?? '';
      }
    }

    selectedOccupation = app.occupationName;
    selectedShopOwnershipType = app.occupationOwnershipType == 'own'
        ? 'Own Shop'
        : app.occupationOwnershipType == 'rent'
        ? 'Rented Shop'
        : null;

    _assetSelection['Two Wheeler'] = app.hasTwoWheeler ?? '';
    _assetSelection['Four Wheeler'] = app.hasFourWheeler ?? '';
    _assetSelection['Own House'] = app.hasOwnHouse ?? '';

    if (app.agricultureLandAcres != null && app.agricultureLandAcres != 0) {
      _assetSelection['Agricultural Land'] = 'Yes';
      landInAcresController.text = app.agricultureLandAcres.toString();
    } else {
      _assetSelection['Agricultural Land'] = 'No';
    }

    monthlyIncomeController.text = app.incomeAmount?.toString() ?? '';

    experienceController.text = app.experienceYears?.toString() ?? '';

    if (app.incomeType != null) {
      _selectedPaymentMethod = app.incomeType == 'cash'
          ? 'Cash'
          : app.incomeType == 'upi'
          ? 'Cash & UPI'
          : 'Bank Transfer';
    }

    if (app.currentStep != null) {
      _jumpToCorrectStep(app.currentStep!);
    }

    for (int i = 0; i < (app.currentStep ?? 0); i++) {
      _savedTabs.add(i);
    }

    setState(() {});
  }

  void _jumpToCorrectStep(int currentStep) {
    final tabCount = _tabController.length;

    final targetIndex = currentStep.clamp(0, tabCount - 1);

    _tabController.animateTo(targetIndex);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
