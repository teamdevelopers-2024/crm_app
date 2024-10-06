import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motta/models/leads_model.dart';
import 'package:motta/utils/enums.dart';

part 'list_card.event.dart';
part 'list_card.state.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  LeadBloc() : super(LeadInitial()) {
    // Load leads
    on<LoadLeads>((event, emit) async {
      emit(LeadLoading());

      try {
        // Simulate API call or data fetch
        await Future.delayed(Duration(seconds: 2));

        List<Lead> leads = [
          Lead(id: 1, name: "John Doe", location: "New York", email: "john@example.com", phone: "123456789", status: "Pending"),
          Lead(id: 2, name: "Jane Smith", location: "California", email: "jane@example.com", phone: "987654321", status: "Closed"),
          Lead(id: 2, name: "Jane Smith", location: "California", email: "jane@example.com", phone: "987654321", status: "Closed"),
          Lead(id: 2, name: "Jane Smith", location: "California", email: "jane@example.com", phone: "987654321", status: "Closed"),
          Lead(id: 2, name: "Jane Smith", location: "California", email: "jane@example.com", phone: "987654321", status: "Closed"),
          Lead(id: 2, name: "Jane Smith", location: "California", email: "jane@example.com", phone: "987654321", status: "Closed"),
        ];

        emit(LeadLoaded(leads: leads, selectedFilter: 'All', searchQuery: ''));
      } catch (e) {
        emit(LeadError("Failed to load leads."));
      }
    });

    // Filter leads
    on<FilterLeads>((event, emit) {
      if (state is LeadLoaded) {
        final currentState = state as LeadLoaded;
        emit(LeadLoaded(
          leads: currentState.leads,
          selectedFilter: event.filter,
          searchQuery: currentState.searchQuery,
        ));
      }
    });

    // Search leads
    on<SearchLeads>((event, emit) {
      if (state is LeadLoaded) {
        final currentState = state as LeadLoaded;
        emit(LeadLoaded(
          leads: currentState.leads,
          selectedFilter: currentState.selectedFilter,
          searchQuery: event.query,
        ));
      }
    });

    // Update lead status
    on<UpdateLeadStatus>((event, emit) {
      if (state is LeadLoaded) {
        final currentState = state as LeadLoaded;

        List<Lead> updatedLeads = currentState.leads.map((lead) {
          // Instead of copyWith, we use the method to return a new instance with updated status
          if (lead.id == event.leadId) {
            return lead.updateStatus(event.newStatus);
          }
          return lead;
        }).toList();

        emit(LeadLoaded(
          leads: updatedLeads,
          selectedFilter: currentState.selectedFilter,
          searchQuery: currentState.searchQuery,
        ));
      }
    });
  }
}
