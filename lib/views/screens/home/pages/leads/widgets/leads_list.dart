import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc package

const List<String> leadStatuses = [
  'Closed',
  'Not Responded',
  'Rejected',
  'Pending',
  'Need to Follow Up',
]; // leads_list.dart
Widget buildLeadsList(LeadBloc leadBloc) {
  return BlocBuilder<LeadBloc, LeadState>(
    bloc: leadBloc,
    builder: (context, state) {
      if (state is LeadLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is LeadError) {
        return Center(child: Text('Error: ${state.error}'));
      } else if (state is LeadLoaded) {
        final leads = state.leads;

        return Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: CRMAppColorPallete
                  .containerBackground, // Background color for the list area

              borderRadius:
                  BorderRadius.circular(10), // Optional: Rounded corners
            ),
            child: ListView.builder(
              // controller:,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0), // Optional: Padding around the list

              // physics: NeverScrollableScrollPhysics(), // Prevent scrolling on the ListView

              shrinkWrap:
                  true, // Allow ListView to take only the space it needs

              itemCount: leads.length,

              itemBuilder: (context, index) {
                final lead = leads[index];

                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0), // Space between cards

                  child: _buildLeadCard(leadBloc, lead, context),
                );
              },
            ),
          ),
        );
      } else {
        return const Center(child: Text('No leads available.'));
      }
    },
  );
}

Widget _buildLeadCard(LeadBloc leadBloc, Lead lead, BuildContext context) {
  // Set current status based on lead.status
  String? currentStatus = lead.status;

  return Card(
    color: CRMAppColorPallete
        .transparent, // Lighter card color as seen in the image
    elevation: 1.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Circle Avatar at the top left
               FittedBox(
                // fit: BoxFit.cover,
                child: CircleAvatar(
                  radius: Screen.getWidth(context: context)*0.05,
                  backgroundColor: CRMAppColorPallete
                      .boldTextColor, // You can change this to any color or image
                  child: Icon(Icons.person,
                      color: CRMAppColorPallete.cardTile, size: Screen.getWidth(context: context)*0.05 * 1.5),
                ),
              ),
              const SizedBox(width: 10.0), // Small gap after the avatar

              // Lead Name and Location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lead Name
                    Text(
                      lead.name,
                      style: TextStyle(
                        fontSize: Screen.getWidth(context: context)*0.04,
                        fontWeight: FontWeight.bold,
                        color: CRMAppColorPallete.boldTextColor,
                      ),
                    ),
                    // Lead Location
                    Text(
                      lead.location,
                      style: TextStyle(
                        fontSize: Screen.getWidth(context: context)*0.03,
                        color: CRMAppColorPallete.textColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Close Request Button at the top right
              ElevatedButton.icon(
                onPressed: () {
                  // Add your close request logic here
                  // leadBloc.add(SendCloseRequest(lead.id)); // Assuming there's an event for this
                },
                icon: Icon(CupertinoIcons.person_crop_circle_fill_badge_checkmark, color: CRMAppColorPallete.lightBlue,size: Screen.getWidth(context: context)*0.06,),
                label: Text(
                  'Close request',
                  style: TextStyle(color: CRMAppColorPallete.lightBlue,fontSize: Screen.getWidth(context: context)*0.03),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  elevation: 0,
                  side: const BorderSide(color: CRMAppColorPallete.lightBlue),
                  backgroundColor: CRMAppColorPallete.lightBlue.withOpacity(0.04), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 8.0), // Gap between name/location and email/phone

          // Email and Phone
          Text(
            lead.email,
            style: const TextStyle(
                fontSize: 14.0, color: CRMAppColorPallete.textColor),
          ),
          const SizedBox(height: 4.0),
          Text(
            lead.phone,
            style: const TextStyle(
                fontSize: 14.0, color: CRMAppColorPallete.textColor),
          ),

          const SizedBox(
              height: 12.0), // Gap between email/phone and dropdown/call button

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dropdown Button at the bottom left
              Container(
                
                padding: const EdgeInsets.only(left:8,right:8,top: 6,bottom: 6),
                decoration: BoxDecoration(
                  
                  border: Border.all(color: CRMAppColorPallete.boldTextColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))
                ),
                child: DropdownButton<String>(
                  elevation: 0,
                  enableFeedback: false,  
                  isExpanded: false,
                  isDense: true,
                  underline: const SizedBox(),
                hint: const Text('Select status'),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                
                  value: currentStatus,
                
                  dropdownColor: CRMAppColorPallete
                      .dropdownBackground, // Match dropdown background
                  icon: const Icon(CupertinoIcons.arrowtriangle_down_circle,
                      color: CRMAppColorPallete.textColor),
                  items:
                      leadStatuses.map<DropdownMenuItem<String>>((String status) {
                    return DropdownMenuItem<String>(
                      
                      value: status,
                      enabled: status != 'Closed', // Disable the 'Closed' option
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: Screen.getWidth(context: context)*0.03,
                          color: status == 'Closed' ? Colors.grey : CRMAppColorPallete.textColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newStatus) {
                    // Only allow updates if the new status is not 'Closed'
                    if (newStatus != null &&
                        newStatus != 'Closed' &&
                        newStatus != currentStatus) {
                      leadBloc.add(UpdateLeadStatus(lead.id, newStatus));
                    }
                  },
                ),
              ),

              // Call Button at the bottom right
              ElevatedButton.icon(
                onPressed: () {
                  // Add your call logic here, perhaps using url_launcher to dial the number
                },
                icon: Icon(CupertinoIcons.phone_arrow_up_right, color: CRMAppColorPallete.boldTextColor,size: Screen.getWidth(context: context)*0.05,),
                label:
                    const Text('Call', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  side: const BorderSide(color: CRMAppColorPallete.boldTextColor),
                  elevation: 0,
                  backgroundColor:
                      CRMAppColorPallete.transparent, // Adjust the color of the call button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Rounded corners for the button
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
