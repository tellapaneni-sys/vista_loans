import 'package:agent_application/screens/profile/profile_api.dart';
import 'package:agent_application/screens/profile/profile_model.dart';
import 'package:agent_application/screens/profile/update_bank_details_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  bool _isLoading = true;
  String? _errorMessage;
  User? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  Future<void> loadProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _profileService.fetchProfile();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  bool isSavingBank = false;
  UpdateDetails? _addressDetails;

  UpdateDetails? get addressDetails => _addressDetails;

  Future<void> saveDetails(UpdateDetails details) async {
    try {
      isSavingBank = true;
      notifyListeners();

      await _profileService.updateDetails(details);

      _user = await _profileService.fetchProfile();

      isSavingBank = false;
      notifyListeners();
    } catch (e) {
      isSavingBank = false;
      notifyListeners();
      rethrow;
    }
  }
}
