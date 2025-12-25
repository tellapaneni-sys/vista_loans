import 'package:agent_application/screens/add_customer_screens/customer_api_service.dart';
import 'package:agent_application/screens/add_customer_screens/customer_assets_response.dart';
import 'package:agent_application/screens/add_customer_screens/customer_basic_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_income_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_kyc_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_occupation_request.dart';
import 'package:agent_application/screens/add_customer_screens/customer_review_response_model.dart';
import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  final CustomerApiService _apiService = CustomerApiService();

  bool isLoading = false;
  bool isKYCLoading = false;
  String? errorMessage;
  String? errorKYCMessage;
  CustomerReviewResponse? reviewData;
  bool isReviewLoading = false;
  String? reviewErrorMessage;
  Future<void> fetchReviewData(int applicationId) async {
    try {
      isReviewLoading = true;
      reviewErrorMessage = null;
      notifyListeners();

      reviewData = await _apiService.fetchReviewData(
        applicationId: applicationId,
      );

    } catch (e) {
      reviewErrorMessage = e.toString();
    } finally {
      isReviewLoading = false;
      notifyListeners();
    }
  }

  Future<CustomerBasicResponse?> submitBasicData(
    CustomerBasicRequest request,
  ) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await _apiService.submitBasicData(request);
      return response;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<CustomerScreen2BasicRequest?> submitScreen2BasicData(
    CustomerScreen2BasicRequest request,
  ) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await _apiService.submitScreen2BasicData(request);
      return response;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Submit KYC Data
  Future<CustomerKycRequest?> submitKycData({
    required CustomerKycRequest request,
  }) async {
    try {
      isKYCLoading = true;
      errorKYCMessage = null;
      notifyListeners();

      final response = await _apiService.submitKyc(request: request);

      return response;
    } catch (e) {
      errorKYCMessage = e.toString();
      return null;
    } finally {
      isKYCLoading = false;
      notifyListeners();
    }
  }

  bool isOccupationLoading = false;
  String? errorOccupationMessage;

  Future<CustomerOccupationResponse?> submitOccupationData({
    required CustomerOccupationRequest request,
  }) async {
    try {
      isOccupationLoading = true;
      errorOccupationMessage = null;
      notifyListeners();

      final response = await _apiService.submitOccupationData(request: request);

      return response;
    } catch (e) {
      errorOccupationMessage = e.toString();
      return null;
    } finally {
      isOccupationLoading = false;
      notifyListeners();
    }
  }

  bool isAssetLoading = false;
  String? errorAssetMessage;

  Future<CustomerAssetResponse?> submitAssetData({
    required CustomerAssetRequest request,
  }) async {
    try {
      isAssetLoading = true;
      errorAssetMessage = null;
      notifyListeners();

      final response = await _apiService.submitAssetData(request: request);

      return response;
    } catch (e) {
      errorAssetMessage = e.toString();
      return null;
    } finally {
      isAssetLoading = false;
      notifyListeners();
    }
  }

  Future<CustomerIncomeResponse?> submitIncomeData(
    CustomerIncomeRequest request,
  ) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await _apiService.submitIncomeData(
        request,
      ); // implement in API service
      return response;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isSubmitting = false;
  String? submitErrorMessage;
  Map<String, dynamic>? submitResponse;

  Future<bool> submitApplication(int applicationId) async {
    try {
      isSubmitting = true;
      submitErrorMessage = null;
      notifyListeners();

      final response = await _apiService.submitApplication(
        applicationId: applicationId,
      );

      submitResponse = response['result'];
      return true;
    } catch (e) {
      submitErrorMessage = e.toString();
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
