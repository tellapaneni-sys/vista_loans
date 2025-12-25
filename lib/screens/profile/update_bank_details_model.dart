class UpdateDetails {
  final String? address1;
  final String? address2;
  final String? city;
  final String? pincode;
  final String? pan;
  final String? accountNumber;
  final String? bankName;
  final String? ifscCode;

  UpdateDetails({
    this.address1,
    this.address2,
    this.city,
    this.pincode,
    this.pan,
    this.accountNumber,
    this.bankName,
    this.ifscCode,
  });

  factory UpdateDetails.fromJson(Map<String, dynamic> json) {
    return UpdateDetails(
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      pincode: json['pincode']?.toString(),
      pan: json['pan'] as String?,
      accountNumber: json['account_number'] as String?,
      bankName: json['bank_name'] as String?,
      ifscCode: json['ifsc_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address1": address1,
      "address2": address2,
      "city": city,
      "pincode": pincode,
      "pan": pan,
      "account_number": accountNumber,
      "bank_name": bankName,
      "ifsc_code": ifscCode,
    }..removeWhere((key, value) => value == null); // optional: remove nulls
  }
}
