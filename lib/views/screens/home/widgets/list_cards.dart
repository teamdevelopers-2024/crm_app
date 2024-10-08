  // import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:motta/bloc/list_card/list_card.bloc.dart';
// import 'package:motta/utils/enums.dart';
// // import 'package:intl/intl.dart'; // For formatting the date and time

// Widget listCards(
//     {required BuildContext context, required ListCardBloc listCardBloc}) {
//   LeadStatus? selectedStatus;
//   DateTime?
//       scheduledCallbackTime; // Variable to store the selected callback time

//   // Function to convert LeadStatus to friendly text
//   String getStatusText(LeadStatus status) {
//     switch (status) {
//       case LeadStatus.closed:
//         return 'Closed';
//       case LeadStatus.notResponded:
//         return 'Not Responded';
//       case LeadStatus.rejected:
//         return 'Rejected';
//       case LeadStatus.pending:
//         return 'Pending';
//       case LeadStatus.scheduled:
//         return 'Scheduled';
//       case LeadStatus.needtofollowup:
//         return 'Need To Follow Up';
//       default:
//         return '';
//     }
//   }

//   // Function to show date and time picker
//   Future<void> _selectDateTime(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );

//     if (pickedDate != null) {
//       TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );

//       if (pickedTime != null) {
//         scheduledCallbackTime = DateTime(
//           pickedDate.year,
//           pickedDate.month,
//           pickedDate.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//         listCardBloc.add(ScheduleCallbackTimeChanged(scheduledCallbackTime!));
//       }
//     }
//   }

//   // Function to format the selected callback time
//   // String formatDateTime(DateTime dateTime) {
//   //   return Date('yyyy-MM-dd – kk:mm').format(dateTime);
//   // }

//   return BlocBuilder<ListCardBloc, ListCardState>(
//     builder: (context, state) {
//       if (state is LeadStatusChangedState) {
//         selectedStatus = state.status;
//       }
//       if(state is ScheduledCallbackTimeState){
//         scheduledCallbackTime = state.callbackTime;
//         print(scheduledCallbackTime);
//       }
//       return ListView.separated(
//         itemCount: 10,
//         separatorBuilder: (context, index) => Divider(),
//         itemBuilder: (context, index) => 
//          Card(
//           surfaceTintColor: Colors.red,
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 left: 12.0, right: 15.0, top: 12.0, bottom: 12.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Row(
//                       children: [
//                         CircleAvatar(),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [Text('Dilshad K'), Text("+91 8921405362")],
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12.0, vertical: 8.0),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.deepPurpleAccent),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: const Row(
//                         children: [
//                           Icon(
//                             CupertinoIcons.phone_arrow_up_right,
//                             color: Colors.deepPurpleAccent,
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             'Call',
//                             style: TextStyle(
//                                 fontSize: 16.0, color: Colors.deepPurpleAccent),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Marked as: "),
//                     SizedBox(width: 10),
//                     DropdownButton<LeadStatus>(
//                       hint: Text('Select Status'),
//                       value: selectedStatus,
//                       onChanged: (LeadStatus? latestStatus) {
//                         if (latestStatus != null) {
//                           listCardBloc.add(ChangeLeadStatusRequested(
//                               leadStatus: latestStatus));
//                         }
//                       },
//                       items: LeadStatus.values.map((LeadStatus status) {
//                         return DropdownMenuItem<LeadStatus>(
//                           value: status,
//                           child: Text(getStatusText(status)),
//                         );
//                       }).toList(),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12.0, vertical: 8.0),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.deepPurpleAccent),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: const Row(
//                         children: [
//                           Icon(
//                             CupertinoIcons.mail,
//                             color: Colors.deepPurpleAccent,
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             'Gmail',
//                             style: TextStyle(
//                                 fontSize: 16.0, color: Colors.deepPurpleAccent),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Schedule Callback:"),
//                     ElevatedButton(
//                       onPressed: () async {
//                         await _selectDateTime(context);
//                       },
//                       child: Text('Select Date & Time'),
//                     ),
//                   ],
//                 ),
//                 if (scheduledCallbackTime != null)
//                   Text(
//                     "Scheduled for: ${(scheduledCallbackTime!)}",
//                     style: TextStyle(color: Colors.green),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
