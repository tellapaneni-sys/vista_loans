class CustomerBasicRequest {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dob;
  final String? pan;

  CustomerBasicRequest({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dob,
    required this.pan,
  });

  Map<String, dynamic> toJson() {
    return {
      "customer_first_name": firstName,
      "customer_last_name": lastName,
      "phone_number": phoneNumber,
      "dob": dob,
      "pan": pan,
    };
  }

  factory CustomerBasicRequest.fromJson(Map<String, dynamic> json) {
    return CustomerBasicRequest(
      firstName: json['customer_first_name'] ?? '',
      lastName: json['customer_last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      dob: json['dob'] ?? '',
      pan: json['pan'] ?? '',
    );
  }
}

class CustomerScreen2BasicRequest {
  final int applicationId;
  final String loanPurpose;
  final String loanSecurityType;
  final String employmentType;
  final String loanAmountRequested;
  final int noExistingLoans;
  final int existingEmis;
  final String address;
  final String pincode;
  final String email;

  CustomerScreen2BasicRequest({
    required this.applicationId,
    required this.loanPurpose,
    required this.loanSecurityType,
    required this.employmentType,
    required this.loanAmountRequested,
    required this.noExistingLoans,
    required this.existingEmis,
    required this.address,
    required this.pincode,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "application_id": applicationId,
      "loan_purpose": loanPurpose,
      "loan_security_type": loanSecurityType,
      "employment_type": employmentType,
      "loan_amount_requested": loanAmountRequested,
      "no_existing_loans": noExistingLoans,
      "existing_emis": existingEmis,
      "address": address,
      "pincode": pincode,
      "email": email,
    };
  }

  factory CustomerScreen2BasicRequest.fromJson(Map<String, dynamic> json) {
    return CustomerScreen2BasicRequest(
      applicationId: json['application_id'] ?? 0,
      loanPurpose: json['loan_purpose'] ?? '',
      loanSecurityType: json['loan_security_type'] ?? '',
      employmentType: json['employment_type'] ?? '',
      loanAmountRequested: json['loan_amount_requested'] ?? '',
      noExistingLoans: json['no_existing_loans'] ?? 0,
      existingEmis: json['existing_emis'] ?? 0,
      address: json['address'] ?? '',
      pincode: json['pincode'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
