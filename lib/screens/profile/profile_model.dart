class ProfileResponse {
  int? code;
  String? message;
  Result? result;

  ProfileResponse({this.code, this.message, this.result});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'] != null
        ? new Result.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  User? user;

  Result({this.user});

  Result.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? address1;
  String? address2;
  String? city;
  int? pincode;
  String? role;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? pan;
  String? ifscCode;
  String? bankName;
  String? accountNumber;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address1,
    this.address2,
    this.city,
    this.pincode,
    this.role,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.pan,
    this.ifscCode,
    this.bankName,
    this.accountNumber,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    pincode = json['pincode'];
    role = json['role'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pan = json['pan'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['role'] = this.role;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pan'] = this.pan;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    return data;
  }
}
