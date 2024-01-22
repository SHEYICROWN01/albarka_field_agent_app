import 'dart:convert';
import 'dart:io';
import 'package:albarka_agent_app/model/viewDailySavingsModel.dart';
import 'package:http/http.dart' as http;

class SavingsByDateService {
  Future<List<ViewDailySavingsModel>> getSavingsByDate(
      String agentID, String date) async {
    try {
      final response = await http.post(Uri.parse(
          'https://dashboard.albarkaltd.com/albarkaAPI/dailyTransaction.php?agentID=$agentID&tdate=$date'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => ViewDailySavingsModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load Savings');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Failed to load Savings: $e');
    }
  }
}
