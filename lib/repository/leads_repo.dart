import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/services/leads.services.dart';

class LeadsRepo {
  final LeadsServices leadsServices;

  // Constructor that allows LeadsServices to be injected (useful for testing)
  LeadsRepo({required this.leadsServices});

  Future<List<Lead>?> getLeads() async {
    print('Fetching leads from repository');
    return await leadsServices.getLeads();
  }
}
