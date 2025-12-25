import 'package:agent_application/constant/app_prefs.dart';
import 'package:flutter/material.dart';
import 'auth_api.dart';
import 'signup_model.dart';
import 'login_model.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool loading = false;
  String? error;

  // ================= LOGIN =================
  Future<LoginModel?> login(String email, String password) async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final response = await _apiService.login(email, password);
      await AppPrefs.setToken(response.token);
      return response;
    } catch (e) {
      error = e.toString().replaceAll("Exception:", "").trim();
      return null;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // ================= REGISTER =================
  Future<SignupModel?> register({
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
    try {
      loading = true;
      error = null;
      notifyListeners();

      final result = await _apiService.register(
        firstName: firstName,
        lastName: lastName,
        address1: address1,
        address2: address2,
        pincode: pincode,
        city: city,
        email: email,
        phone: phone,
        password: password,
      );

      return result;
    } catch (e) {
      error = e.toString().replaceAll("Exception:", "").trim();
      return null;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
