import 'dart:convert';
import 'package:agent_application/constant/app_prefs.dart';
import 'package:agent_application/screens/add_customer_screens/customer_assets_response.dart';
import 'package:agent_application/screens/add_customer_screens/customer_basic_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_income_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_kyc_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_occupation_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_review_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerApiService {
  static const String _baseUrl = 'https://api.vistaloans.in/api/customer';

  Future<CustomerBasicResponse> submitBasicData(
    CustomerBasicRequest request,
  ) async {
    final token = await AppPrefs.getToken();

    final response = await http.post(
      Uri.parse("$_baseUrl/screen1"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(request.toJson()),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CustomerBasicResponse.fromJson(data);
    } else {
      final errorText = data['message'] ?? 'Failed to submit basic data';

      throw Exception(errorText);
    }
  }

  Future<CustomerScreen2BasicRequest> submitScreen2BasicData(
    CustomerScreen2BasicRequest request,
  ) async {
    final token = await AppPrefs.getToken();

    final response = await http.post(
      Uri.parse("$_baseUrl/screen2"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(request.toJson()),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CustomerScreen2BasicRequest.fromJson(data);
    } else {
      final errorText =
          data['result']?.toString() ??
          data['message'] ??
          'Failed to submit basic data';
      throw Exception(errorText);
    }
  }

  Future<CustomerKycRequest> submitKyc({
    required CustomerKycRequest request,
  }) async {
    final token = await AppPrefs.getToken();
    final response = await http.post(
      Uri.parse("$_baseUrl/screen3"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(request.toJson()),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CustomerKycRequest.fromJson(data);
    } else {
      final errorText =
          data['result']?.toString() ??
          data['message'] ??
          'Failed to submit KYC data';
      throw Exception(errorText);
    }
  }

  Future<CustomerOccupationResponse> submitOccupationData({
    required CustomerOccupationRequest request,
  }) async {
    final token = await AppPrefs.getToken();
    final response = await http.post(
      Uri.parse("$_baseUrl/screen4"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(request.toJson()),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CustomerOccupationResponse.fromJson(data);
    } else {
      final errorText =
          data['result']?.toString() ??
          data['message'] ??
          'Failed to submit occupation data';
      throw Exception(errorText);
    }
  }

  Future<CustomerAssetResponse> submitAssetData({
    required CustomerAssetRequest request,
  }) async {
    final token = await AppPrefs.getToken();
    final response = await http.post(
      Uri.parse("$_baseUrl/screen5"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return CustomerAssetResponse.fromJson(data);
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Failed to submit asset data');
    }
  }

  Future<CustomerIncomeResponse> submitIncomeData(
    CustomerIncomeRequest request,
  ) async {
    final token = await AppPrefs.getToken();
    final response = await http.post(
      Uri.parse("$_baseUrl/screen6"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(request.toJson()),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CustomerIncomeResponse.fromJson(data);
    } else {
      final errorText =
          data['result']?.toString() ??
          data['message'] ??
          "Failed to submit income data";
      throw Exception(errorText);
    }
  }

  Future<CustomerReviewResponse> fetchReviewData({
    required int applicationId,
  }) async {
    final token = await AppPrefs.getToken();

    final response = await http.post(
      Uri.parse("$_baseUrl/review-data"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"application_id": applicationId}),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return CustomerReviewResponse.fromJson(data['result']);
    } else {
      throw Exception(data['message'] ?? "Failed to fetch review data");
    }
  }

  Future<Map<String, dynamic>> submitApplication({
    required int applicationId,
  }) async {
    final token = await AppPrefs.getToken();

    final response = await http.post(
      Uri.parse("$_baseUrl/submit-data"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"application_id": applicationId}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      throw Exception(data['message'] ?? "Failed to submit application");
    }
  }
}

class CustomerBasicResponse {
  final int applicationId;

  CustomerBasicResponse({required this.applicationId});

  factory CustomerBasicResponse.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>? ?? {};

    final appId = result['application_id'] is int
        ? result['application_id'] as int
        : int.tryParse(result['application_id']?.toString() ?? '0') ?? 0;

    return CustomerBasicResponse(applicationId: appId);
  }
}
