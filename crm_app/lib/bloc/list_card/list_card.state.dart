part of 'list_card.bloc.dart';


@immutable
sealed class LeadState extends Equatable {
  const LeadState();

  @override
  List<Object?> get props => [];
}

class LeadInitial extends LeadState {}

class LeadLoading extends LeadState {}

class LeadLoaded extends LeadState {
  final List<Lead> leads;
  final String selectedFilter;
  final String searchQuery;

  const LeadLoaded({
    required this.leads,
    required this.selectedFilter,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [leads, selectedFilter, searchQuery];
}

class LeadError extends LeadState {
  final String error;

  const LeadError(this.error);

  @override
  List<Object?> get props => [error];
}

