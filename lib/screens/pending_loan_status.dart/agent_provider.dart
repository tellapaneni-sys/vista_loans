import 'package:agent_application/screens/pending_loan_status.dart/agent_api_service.dart';
import 'package:agent_application/screens/pending_loan_status.dart/pending_application_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PendingApplicationsProvider extends ChangeNotifier {
  final AgentApiService _api = AgentApiService();

  bool isLoading = false;
  String? error;

  String selectedStatus = "All";

  List<Application> pending = [];
  List<Application> completed = [];
  List<Application> approved = [];

  Future<void> fetchApplicationDetail() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _api.fetchApplications();
      pending = response.result.pending;
      completed = response.result.completed;
      approved = response.result.approved;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeStatus(String status) {
    selectedStatus = status;
    notifyListeners();
  }

  List<Application> get filteredApplications {
    if (selectedStatus == "All") {
      return [...pending, ...completed, ...approved];
    }

    final allApps = [...pending, ...completed, ...approved];

    final statusMap = {
      "Completed": "Completed",
      "Pending": "Pending",
      "Approved": "Approved",
      "Rejected": "Rejected",
    };

    final apiStatus = statusMap[selectedStatus] ?? selectedStatus;

    return allApps
        .where(
          (app) =>
              app.applicationStatus.toLowerCase() == apiStatus.toLowerCase(),
        )
        .toList();
  }
}
