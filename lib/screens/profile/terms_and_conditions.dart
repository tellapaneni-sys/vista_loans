import 'package:agent_application/constant/app_colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: const BackButton(color: AppColors.black),
          title: const Text(
            "Terms & COnditions",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "By acting as a Vista Loans Agent, you agree to the following:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 16),

              _bulletPoint(
                "Act honestly, ethically, and always in the best interest of customers.",
              ),
              _bulletPoint(
                "Clearly explain all available loan options without bias or manipulation.",
              ),
              _bulletPoint(
                "Do not collect any commission, fees, or benefits from customers or third parties.",
              ),
              _bulletPoint(
                "Customer data must remain confidential and may not be shared, disclosed, or misused without explicit consent of the Customer and Vista Loans.",
              ),
              _bulletPoint(
                "Contact customers only between 9:00 AM and 6:00 PM; do not harass, pressure, or mislead.",
              ),
              _bulletPoint(
                "Do not submit false details or influence customer decisions unfairly.",
              ),
              _bulletPoint(
                "Follow all laws, regulatory guidelines, and Vista Loans policies.",
              ),
              _bulletPoint(
                "Any violation may result in termination and legal action.",
              ),
              _bulletPoint(
                "If your actions damage Vista Loans’ reputation or cause customer claims, all losses and liabilities will be recovered from you.",
              ),
              _bulletPoint(
                "Loan approval and servicing are handled only by regulated partner lenders; agents cannot promise approvals.",
              ),
              _bulletPoint("Governing Law: Indian jurisdiction applies."),
              _bulletPoint("Grievance: grievance-redressal@vistaloans.in"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•  ",
            style: TextStyle(fontSize: 18, color: AppColors.black),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.black,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
