// leads_page.dart
import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:crm_android/views/screens/home/pages/leads/widgets/filter_tabs.dart';
import 'package:crm_android/views/screens/home/pages/leads/widgets/leads_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeadsPage extends StatelessWidget {
  const LeadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    LeadBloc leadBloc =
        context.read<LeadBloc>(); // Get the LeadBloc from the context

    return Scaffold(
      backgroundColor: const Color(0xFF172554),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: BlocBuilder<LeadBloc, LeadState>(
          builder: (context, state) {
            if (state is LeadInitial) {
              leadBloc.add(LoadLeads());
              return const Center(child: Text("Welcome!"));
            } else if (state is LeadLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LeadLoaded) {
              
              return Column(
                children: [
                  _buildSearchBar(context),
                  buildFilterTabs(leadBloc, state),
                  const SizedBox(
                    height: 10,
                  ),
                  buildLeadsList(leadBloc),
                ],
              );
            } else if (state is LeadError) {
              return Center(child: Text(state.error));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: Screen.getWidth(context: context)*0.03),
      child: TextField(
        
        onChanged: (query) {
          context.read<LeadBloc>().add(SearchLeads(query));
        },

        style: const TextStyle(color: Colors.white,),
        decoration: InputDecoration(labelText: 'Search leads',contentPadding: EdgeInsets.zero,enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: const BorderSide(color: CRMAppColorPallete.searchBarBackground)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: CRMAppColorPallete.boldTextColor),borderRadius: BorderRadius.circular(12)),
          hintText: 'Search leads...',
          labelStyle:const TextStyle(color: Colors.white70),
          hintFadeDuration: const Duration(milliseconds: 700),
          alignLabelWithHint: true,
          hintStyle: const TextStyle(color: Colors.white70),
          
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: const TextStyle(color: CRMAppColorPallete.boldTextColor),
          filled: true,
          fillColor: CRMAppColorPallete.cardTile.withOpacity(0.6),
          
          prefixIcon: const Icon(CupertinoIcons.doc_text_search, color: Colors.white70),
        ),
      ),
    );
  }
}
