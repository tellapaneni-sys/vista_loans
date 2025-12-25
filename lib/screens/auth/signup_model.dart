class SignupModel {
  final bool status;
  final String message;

  SignupModel({required this.status, required this.message});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
