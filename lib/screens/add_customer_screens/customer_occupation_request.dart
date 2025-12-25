class CustomerOccupationRequest {
  final int applicationId;
  final String occupationName;
  final String occupationOwnershipType;

  CustomerOccupationRequest({
    required this.applicationId,
    required this.occupationName,
    required this.occupationOwnershipType,
  });

  Map<String, dynamic> toJson() {
    return {
      "application_id": applicationId,
      "occupation_name": occupationName,
      "occupation_ownership_type": occupationOwnershipType,
    };
  }
}

class CustomerOccupationResponse {
  final int applicationId;
  final String applicationStatus;
  final int currentStep;

  CustomerOccupationResponse({
    required this.applicationId,
    required this.applicationStatus,
    required this.currentStep,
  });

  factory CustomerOccupationResponse.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>? ?? {};
    return CustomerOccupationResponse(
      applicationId: result['application_id'] ?? 0,
      applicationStatus: result['application_status'] ?? '',
      currentStep: result['current_step'] ?? 0,
    );
  }
}
