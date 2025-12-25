class LoginModel {
  final int code;
  final String message;
  final String token;
  final UserModel user;

  LoginModel({
    required this.code,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['result'] ?? {}),
    );
  }
}

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address1;
  final String address2;
  final String city;
  final int pincode;
  final String role;
  final int isActive;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address1,
    required this.address2,
    required this.city,
    required this.pincode,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? 0,
      role: json['role'] ?? '',
      isActive: json['is_active'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
