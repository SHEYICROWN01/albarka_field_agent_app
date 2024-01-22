import 'package:albarka_agent_app/controller/dashboard_controller.dart';
import 'package:albarka_agent_app/route/route_name.dart';
import 'package:albarka_agent_app/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dashboard_action_button.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({super.key});

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  late String availableBalance = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDashboard(context);
  }

  Widget _buildDashboard(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            // ... Your existing code ...
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: ColorConstant.primaryColor,
              ),
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Balance',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.3,
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RouteName.dailyTransaction),
                          child: const Text(
                            "Transaction History >",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  viewModel.dashboardModels != null
                      ? Text(
                          NumberFormat.currency(symbol: '', decimalDigits: 0)
                              .format(tryParseDouble(availableBalance,
                                  viewModel.dashboardModels!.totalCash)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : SpinKitPumpingHeart(
                          color: ColorConstant.whiteA700,
                          size: 30.0,
                        ),
                  const SizedBox(height: 10),
                  // ... Your existing code ...
                  DashboardActionButtons(
                    updateText: (text) {
                      setState(() {
                        availableBalance = text;
                      });
                      // ... Your existing code ...
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  double tryParseDouble(String value, String value2) {
    if (value.isEmpty && value2.isEmpty) {
      return 0.0; // Default value
    }
    try {
      return double.parse(value.isEmpty ? value2 : value);
    } catch (e) {
      return 0.0; // Default value
    }
  }
}
