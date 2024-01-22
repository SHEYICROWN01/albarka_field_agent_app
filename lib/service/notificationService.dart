import 'dart:convert';
import 'dart:io';
import 'package:albarka_agent_app/model/notificationModel.dart';

import 'package:http/http.dart' as http;

class NotificationService {
  Future<List<WithdrawalStatus>> getAllNotifications(String agentId) async {
    try {
      final response = await http.post(Uri.parse(
          'https://dashboard.albarkaltd.com/mobileapi/withdrawalStatus.php?agentID=$agentId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => WithdrawalStatus.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load Savings');
      }
    } on SocketException {
      throw Exception('Failed to connect to the server');
    } catch (e) {
      throw Exception('Failed to load Savings');
    }
  }
}
