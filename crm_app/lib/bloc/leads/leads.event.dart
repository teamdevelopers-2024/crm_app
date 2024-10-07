part of 'leads.bloc.dart';

@immutable
sealed class LeadEvent extends Equatable {
  const LeadEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeads extends LeadEvent {}

class FilterLeads extends LeadEvent {
  final String filter;

  const FilterLeads(this.filter);

  @override
  List<Object?> get props => [filter];
}

class SearchLeads extends LeadEvent {
  final String query;

  const SearchLeads(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateLeadStatus extends LeadEvent {
  final String leadId;
  final String newStatus;

  const UpdateLeadStatus(this.leadId, this.newStatus);

  @override
  List<Object?> get props => [leadId, newStatus];
}