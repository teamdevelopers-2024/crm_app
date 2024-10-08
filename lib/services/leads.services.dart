import 'dart:convert';
import 'package:crm_android/models/leads_model.dart';
import 'package:http/http.dart' as http;

class LeadsServices {
  Future<List<Lead>?> getLeads() async {
    try {
      final uri = Uri.parse("http://157.173.219.135:3001/api/getLeads");
      final response = await http.post(uri, body: {"id": "#CNC0011"});
      if (response.statusCode == 200) {
        final leadsJson = jsonDecode(response.body)['data'] as List<dynamic>;
        final List<Lead> leads =
            leadsJson.map((lead) => Lead.fromJson(lead)).toList();
        return leads;
      } else {
        print('Failed to load leads. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching leads: $e');
      return null;
    }
  }
}
