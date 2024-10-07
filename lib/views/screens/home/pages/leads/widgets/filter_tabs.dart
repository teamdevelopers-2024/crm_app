import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildFilterTabs(LeadBloc leadBloc, LeadLoaded state) {
  final List<String> filters = [
    'All',
    'Pending',
    'Not Responded',
    'Closed',
    'Need to Follow Up',
    'Rejected'
  ];
  String selectedFilter = 'All';
  return BlocBuilder<LeadBloc, LeadState>(
    builder: (context, state) {
      if (state is LeadLoaded) {
        
        selectedFilter = state.selectedFilter!;
      }
      return Container(
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        height: 35,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: filters.map((filter) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4.0), // Add some padding between chips
                child: ChoiceChip(
                  shadowColor: Colors.transparent,
                  elevation: 0.0,
                  side: BorderSide.none,
                  showCheckmark: false,
                  backgroundColor: const Color.fromARGB(252, 17, 24, 40),
                  selectedColor: CRMAppColorPallete.dropdownText,
                  label: Text(filter),
                  labelStyle: TextStyle(
                      color: filter == selectedFilter
                          ? Colors.white
                          : Colors.white.withOpacity(0.7)),
                  selected: filter == selectedFilter,
                  onSelected: (selected) {
                    if (selected) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        leadBloc.add(ChangeFilter(filter));
                      });
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
