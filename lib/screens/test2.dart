// import 'package:flutter/material.dart';
// import 'package:moodee/data/events.dart';
// import 'package:moodee/screens/events/event_details.dart';

// class Test2Screen extends StatelessWidget {
//   const Test2Screen({super.key, required this.index});
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ElevatedButton(
//                 child: const Text("Event 1"),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       for (int i = 0; i < eventList.length; i++) {
//                         if (i == index) {
//                           return EventDetailsScreen(
//                             index: i,
//                             eventList: eventList,
//                           );
//                         }
//                       }
//                       return EventDetailsScreen(
//                         index: 0,
//                         eventList: eventList,
//                       );
//                     },
//                   );
//                 }, // open pop up
//               ),
//               ElevatedButton(
//                 child: const Text("Event 2"),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return EventDetailsScreen(
//                         eventList: [],
//                         index: null,
//                       ); // Your custom popup content
//                     },
//                   );
//                 }, // open pop up
//               ),
//               ElevatedButton(
//                 child: const Text("Event 3"),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return EventDetailsScreen(); // Your custom popup content
//                     },
//                   );
//                 }, // open pop up
//               ),
//               ElevatedButton(
//                 child: const Text("Event 4"),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return EventDetailsScreen(); // Your custom popup content
//                     },
//                   );
//                 }, // open pop up
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
