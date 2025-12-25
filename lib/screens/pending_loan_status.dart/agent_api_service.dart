import 'dart:convert';
import 'package:agent_application/constant/app_prefs.dart';
import 'package:agent_application/screens/pending_loan_status.dart/pending_application_model.dart';
import 'package:http/http.dart' as http;

class AgentApiService {
  static const String _baseUrl =
      'https://api.vistaloans.in/api/agent/applications';

  Future<ApplicationResponse> fetchApplications() async {
    final token = await AppPrefs.getToken();

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch applications");
    }

    final jsonData = jsonDecode(response.body);
    return ApplicationResponse.fromJson(jsonData);
  }
}
