import 'package:crm_android/models/leads_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leads.event.dart';
part 'leads.state.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  LeadBloc() : super(LeadInitial()) {
    // Load leads
    on<LoadLeads>((event, emit) async {
      emit(LeadLoading());

      try {
        // Simulate API call or data fetch
        await Future.delayed(const Duration(seconds: 2));

        List<Lead> leads = [
          Lead(
              id: '1',
              name: "John Doe",
              location: "New York",
              email: "john@example.com",
              phone: "123456789",
              status: "Pending"),
          Lead(
              id: '2',
              name: "Jane Smith",
              location: "California",
              email: "jane@example.com",
              phone: "987654321",
              status: "Closed"),
          Lead(
              id: '2',
              name: "Jane Smith",
              location: "California",
              email: "jane@example.com",
              phone: "987654321",
              status: "Closed"),
          Lead(
              id: '2',
              name: "Jane Smith",
              location: "California",
              email: "jane@example.com",
              phone: "987654321",
              status: "Closed"),
          Lead(
              id: '2',
              name: "Jane Smith",
              location: "California",
              email: "jane@example.com",
              phone: "987654321",
              status: "Closed"),
          Lead(
              id: '2',
              name: "Jane Smith",
              location: "California",
              email: "jane@example.com",
              phone: "987654321",
              status: "Closed"),
        ];

        emit(LeadLoaded(leads: leads, selectedFilter: 'All'));
      } catch (e) {
        emit(const LeadError("Failed to load leads."));
      }
    });

    // Filter leads
    on<ChangeFilter>((event, emit) {
      final lead = [
        Lead(
            id: '2',
            name: "Jane Smith",
            location: "California",
            email: "jane@example.com",
            phone: "987654321",
            status: "Closed")
      ];

      emit(LeadLoaded(leads: lead, selectedFilter: event.filter));
    });

    // Search leads
    on<SearchLeads>((event, emit) {});

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
          // searchQuery: currentState.searchQuery,
        ));
      }
    });
  }
}
