class CustomerReviewResponse {
  final ApplicationModel application;
  final KycDocument? kyc;

  CustomerReviewResponse({required this.application, required this.kyc});

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) {
    return CustomerReviewResponse(
      application: ApplicationModel.fromJson(
        json['application'] as Map<String, dynamic>,
      ),
      kyc: json['kyc_documnet'] != null
          ? KycDocument.fromJson(json['kyc_documnet'] as Map<String, dynamic>)
          : null,
    );
  }
}

class KycDocument {
  final int? id;
  final int? loanApplicationId;
  final String? documentType;
  final String? documentNumber;
  final String? aadhaarNumber;

  KycDocument({
    this.id,
    this.loanApplicationId,
    this.documentType,
    this.documentNumber,
    this.aadhaarNumber,
  });

  factory KycDocument.fromJson(Map<String, dynamic> json) {
    return KycDocument(
      id: json['id'] as int?,
      loanApplicationId: json['loan_application_id'] as int?,
      documentType: json['document_type']?.toString(),
      documentNumber: json['document_number']?.toString(),
      aadhaarNumber: json['aadhaar_number']?.toString(),
    );
  }
}

class ApplicationModel {
  final int? id;
  final int? userId;
  final int? agentId;
  final String? applicationStatus;
  final int? currentStep;
  final String? customerFirstName;
  final String? customerLastName;
  final String? phoneNumber;
  final String? dob;
  final String? loanPurpose;
  final String? loanSecurityType;
  final String? employmentType;
  final int? loanAmountRequested;
  final int? noExistingLoans;
  final int? existingEmis;

  final String? occupationName;
  final String? occupationOwnershipType;

  final String? hasTwoWheeler;
  final String? hasFourWheeler;
  final String? hasOwnHouse;
  final dynamic agricultureLandAcres;

  final int? incomeAmount;
  final String? incomeType;
  final int? experienceYears;

  ApplicationModel({
    this.id,
    this.userId,
    this.agentId,
    this.applicationStatus,
    this.currentStep,
    this.customerFirstName,
    this.customerLastName,
    this.phoneNumber,
    this.dob,
    this.loanPurpose,
    this.loanSecurityType,
    this.employmentType,
    this.loanAmountRequested,
    this.noExistingLoans,
    this.existingEmis,
    this.occupationName,
    this.occupationOwnershipType,
    this.hasTwoWheeler,
    this.hasFourWheeler,
    this.hasOwnHouse,
    this.agricultureLandAcres,
    this.incomeAmount,
    this.incomeType,
    this.experienceYears,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      agentId: json['agent_id'] as int?,
      applicationStatus: json['application_status']?.toString(),
      currentStep: json['current_step'] as int?,
      customerFirstName: json['customer_first_name']?.toString(),
      customerLastName: json['customer_last_name']?.toString(),
      phoneNumber: json['phone_number']?.toString(),
      dob: json['dob']?.toString(),
      loanPurpose: json['loan_purpose']?.toString(),
      loanSecurityType: json['loan_security_type']?.toString(),
      employmentType: json['employment_type']?.toString(),
      loanAmountRequested: json['loan_amount_requested'] as int?,
      noExistingLoans: json['no_existing_loans'] as int?,
      existingEmis: json['existing_emis'] as int?,
      occupationName: json['occupation_name']?.toString(),
      occupationOwnershipType: json['occupation_ownership_type']?.toString(),
      hasTwoWheeler: json['has_two_wheeler']?.toString(),
      hasFourWheeler: json['has_four_wheeler']?.toString(),
      hasOwnHouse: json['has_own_house']?.toString(),
      agricultureLandAcres: json['agriculture_land_acres'],
      incomeAmount: json['income_amount'] as int?,
      incomeType: json['income_type']?.toString(),
      experienceYears: json['experience_years'] as int?,
    );
  }
}
