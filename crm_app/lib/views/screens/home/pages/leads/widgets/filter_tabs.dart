import 'package:flutter/material.dart';
import 'package:motta/bloc/leads/leads.bloc.dart';
import 'package:motta/controller/screen_size_controller.dart';
import 'package:motta/utils/colors.dart';

Widget buildFilterTabs(LeadBloc leadBloc, LeadLoaded state) {
  return Container(
    padding: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    height: 35,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          'All',
          'Pending',
          'Not Responded',
          'Closed',
          'Need to Follow Up',
          'Rejected'
        ].map((filter) {
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
                  color: filter == state.selectedFilter
                      ? Colors.white
                      : Colors.white.withOpacity(0.7)),
              selected: state.selectedFilter == filter,
              onSelected: (selected) {
                if(selected){
                  Future.delayed(Duration(milliseconds: 100), () {
                  leadBloc.add(FilterLeads(filter));
                });
                }
              },
            ),
          );
        }).toList(),
      ),
    ),
  );
}
