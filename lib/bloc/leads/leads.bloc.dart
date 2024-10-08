import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/repository/leads_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leads.event.dart';
part 'leads.state.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  final LeadsRepo leadsRepo;
  LeadBloc({required this.leadsRepo}) : super(LeadInitial()) {
    // Load leads
    on<LoadLeads>((event, emit) async {
      emit(LeadLoading());

      // try {
      //   List<Lead>? leads = await leadsRepo.getLeads();

      //   if (leads != null) {
      //     emit(LeadLoaded(leads: leads, selectedFilter: 'All'));
      //   } else {
      //     emit(const LeadError("Failed to load leads."));
      //   }
      // } catch (e) {
      //   emit(LeadError("An error occurred: $e"));
      // }
    });

    // Filter leads
    on<ChangeFilter>((event, emit) {
      final lead = [
        Lead(
            id: '2',
            name: "Jane Smith",
            course: "California",
            email: "jane@example.com",
            phone: "987654321",
            status: "Closed")
      ];

      emit(LeadLoaded(leads: lead, selectedFilter: event.filter));
    });

    // Search leads
    on<SearchLeads>((event, emit) {});

    // Update lead status
    on<UpdateLeadStatus>((event, emit) {});
  }
}
