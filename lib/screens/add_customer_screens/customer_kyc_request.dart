class CustomerKycRequest {
  final int applicationId;
  final String kycDocumentType;
  final String documentNumber;
  final String aadhaarNumber;

  CustomerKycRequest({
    required this.applicationId,
    required this.kycDocumentType,
    required this.documentNumber,
    required this.aadhaarNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "application_id": applicationId,
      "kyc_document_type": kycDocumentType,
      "document_number": documentNumber,
      "aadhaar_number": aadhaarNumber,
    };
  }

  factory CustomerKycRequest.fromJson(Map<String, dynamic> json) {
    return CustomerKycRequest(
      applicationId: json['application_id'] ?? 0,
      kycDocumentType: json['kyc_document_type'] ?? '',
      documentNumber: json['document_number'] ?? '',
      aadhaarNumber: json['aadhaar_number'] ?? '',
    );
  }
}
