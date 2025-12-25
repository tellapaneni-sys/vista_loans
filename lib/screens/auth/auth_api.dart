import 'dart:convert';
import 'package:agent_application/constant/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:agent_application/screens/auth/signup_model.dart';
import 'package:agent_application/screens/auth/login_model.dart';

class ApiService {
  Future<LoginModel> login(String email, String password) async {
    final url = Uri.parse(ApiConstants.login);

    final res = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    final Map<String, dynamic> responseJson = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (responseJson['code'] == 0) {
        throw Exception(responseJson['message'] ?? "Something went wrong.");
      } else {
        return LoginModel.fromJson(responseJson);
      }
    } else {
      throw Exception(responseJson['message'] ?? "Login failed.");
    }
  }

  // REGISTER API
  Future<SignupModel> register({
    required String firstName,
    required String lastName,
    required String address1,
    required String address2,
    required String pincode,
    required String city,
    required String email,
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.register);

    final res = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "address1": address1,
        "address2": address2,
        "pincode": int.parse(pincode),
        "city": city,
        "email": email,
        "phone_number": phone,
        "password": password,
        "confirm_password": password,
      }),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return SignupModel.fromJson(body);
    } else {
      final errorMessage = body["message"] ?? "Registration failed";
      throw Exception(errorMessage);
    }
  }
}
