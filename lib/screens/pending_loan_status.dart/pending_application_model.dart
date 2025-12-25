class ApplicationResponse {
  final int code;
  final String message;
  final ApplicationResult result;

  ApplicationResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationResponse(
      code: json['code'],
      message: json['message'],
      result: ApplicationResult.fromJson(json['result']),
    );
  }
}

class ApplicationResult {
  final List<Application> pending;
  final List<Application> completed;
  final List<Application> approved;

  ApplicationResult({
    required this.pending,
    required this.completed,
    required this.approved,
  });

  factory ApplicationResult.fromJson(Map<String, dynamic> json) {
    List<Application> parse(dynamic section) {
      return (section['data'] as List)
          .map((e) => Application.fromJson(e))
          .toList();
    }

    return ApplicationResult(
      pending: parse(json['pending']),
      completed: parse(json['completed']),
      approved: parse(json['approved']),
    );
  }
}

class Application {
  final int id;
  final String applicationStatus;
  final int currentStep;
  final String firstName;
  final String lastName;
  final String phone;
  final String? updated_at;
  final int? loan_amount_requested;

  Application({
    required this.id,
    required this.applicationStatus,
    required this.currentStep,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.updated_at,
    required this.loan_amount_requested,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      applicationStatus: json['application_status'],
      currentStep: json['current_step'],
      firstName: json['customer_first_name'],
      lastName: json['customer_last_name'],
      phone: json['phone_number'],
      updated_at: json['updated_at'],
      loan_amount_requested: json['loan_amount_requested'],
    );
  }
}
