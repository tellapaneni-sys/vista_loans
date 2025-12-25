class CustomerIncomeRequest {
  final int applicationId;
  final String incomeAmount;
  final String incomeType;
  final int experienceYears;

  CustomerIncomeRequest({
    required this.applicationId,
    required this.incomeAmount,
    required this.incomeType,
    required this.experienceYears,
  });

  Map<String, dynamic> toJson() {
    return {
      "application_id": applicationId,
      "income_amount": incomeAmount,
      "income_type": incomeType,
      "experience_years": experienceYears,
    };
  }
}

class CustomerIncomeResponse {
  final int applicationId;
  final String applicationStatus;
  final int currentStep;

  CustomerIncomeResponse({
    required this.applicationId,
    required this.applicationStatus,
    required this.currentStep,
  });

  factory CustomerIncomeResponse.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>? ?? {};
    return CustomerIncomeResponse(
      applicationId: result['application_id'] ?? 0,
      applicationStatus: result['application_status'] ?? '',
      currentStep: result['current_step'] ?? 0,
    );
  }
}
