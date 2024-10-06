import 'package:flutter/material.dart';
import 'package:motta/bloc/list_card/list_card.bloc.dart';
import 'package:motta/utils/enums.dart';

Widget buildFilterTabs(LeadBloc leadBloc, LeadLoaded state) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        'all',
        'pending',
        'notResponded',
        'closed',
        'needtofollowup',
        'rejecte}'
      ].map((filter) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add some padding between chips
          child: ChoiceChip(
            label: Text(filter),
            selected: state.selectedFilter == filter,
            onSelected: (selected) {
              leadBloc.add(FilterLeads(filter));
            },
          ),
        );
      }).toList(),
    ),
  );
}
