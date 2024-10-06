// leads_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motta/bloc/list_card/list_card.bloc.dart';
import 'package:motta/models/leads_model.dart';
import 'package:motta/views/screens/home/pages/leads/widgets/filter_tabs.dart';
import 'package:motta/views/screens/home/pages/leads/widgets/leads_list.dart';

class LeadsPage extends StatelessWidget {
  const LeadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    LeadBloc leadBloc = context.read<LeadBloc>(); // Get the LeadBloc from the context

    return Scaffold(
      backgroundColor: Color(0xFF172554),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A4584),
        title: Text('Leads'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: BlocBuilder<LeadBloc, LeadState>(
          builder: (context, state) {
            if (state is LeadInitial) {
              leadBloc.add(LoadLeads());
              return Center(child: Text("Welcome!"));
            } else if (state is LeadLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LeadLoaded) {
              return Column(
                children: [
                  _buildSearchBar(context),
                  buildFilterTabs(leadBloc, state),
                  SizedBox(height: 10,),
                  buildLeadsList(leadBloc),
                ],
              );
            } else if (state is LeadError) {
              return Center(child: Text(state.error));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) {
          context.read<LeadBloc>().add(SearchLeads(query));
        },
        decoration: InputDecoration(
          hintText: 'Search',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(Icons.search, color: Colors.black),
        ),
      ),
    );
  }
}
