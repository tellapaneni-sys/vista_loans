import 'package:agent_application/constant/app_prefs.dart';
import 'package:agent_application/screens/profile/profile_model.dart';
import 'package:agent_application/screens/profile/update_bank_details_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileService {
  static const String baseUrl = 'https://api.vistaloans.in/api';

  Future<User> fetchProfile() async {
    final url = Uri.parse('$baseUrl/fetch_profile');
    final token = await AppPrefs.getToken();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData['code'] == 1) {
        return User.fromJson(jsonData['result']['user']);
      } else {
        throw Exception(jsonData['message'] ?? 'Unknown error');
      }
    } else {
      throw Exception('Failed to fetch profile: ${response.statusCode}');
    }
  }

  Future<UpdateDetails> updateDetails(UpdateDetails account) async {
    print("UPDATE API CALLED with data: ${account.toJson()}");
    final token = await AppPrefs.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/update_profile'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(account.toJson()),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['code'] == 1) {
      return UpdateDetails.fromJson(data['result']['account_details']);
    } else {
      throw Exception(data['message'] ?? 'Failed to update bank details');
    }
  }
}
