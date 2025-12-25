class CustomerAssetRequest {
  final int applicationId;
  final String hasTwoWheeler;
  final String hasFourWheeler;
  final String hasOwnHouse;
  var agricultureLandAcres;

  CustomerAssetRequest({
    required this.applicationId,
    required this.hasTwoWheeler,
    required this.hasFourWheeler,
    required this.hasOwnHouse,
    required this.agricultureLandAcres,
  });

  Map<String, dynamic> toJson() {
    return {
      "application_id": applicationId,
      "has_two_wheeler": hasTwoWheeler,
      "has_four_wheeler": hasFourWheeler,
      "has_own_house": hasOwnHouse,
      "agriculture_land_acres": agricultureLandAcres,
    };
  }
}

class CustomerAssetResponse {
  final int applicationId;
  final String applicationStatus;
  final int currentStep;

  CustomerAssetResponse({
    required this.applicationId,
    required this.applicationStatus,
    required this.currentStep,
  });

  factory CustomerAssetResponse.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>? ?? {};
    return CustomerAssetResponse(
      applicationId: result['application_id'] ?? 0,
      applicationStatus: result['application_status'] ?? '',
      currentStep: result['current_step'] ?? 0,
    );
  }
}
