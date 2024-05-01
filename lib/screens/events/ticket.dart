import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/events/google_map.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:moodee/models/events_model.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({
    Key? key,
    required this.index,
    required this.eventList,
    required this.eventImage,
  }) : super(key: key);

  final List<Event> eventList;
  final int index;
  final String eventImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "lib/assets/icons/arrow_back_gray_small.png",
                      width: 30,
                    ),
                  ),
                  const ScreenTitle(title: "Virtual Ticket"),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "You've secured your spot!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Your ticket is displayed below. \nPlease present this virtual ticket at the venue entrance.",
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              TicketWidget(
                width: 350, 
                height: 500, 
                isCornerRounded: true,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 120,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 1.0, color: Colors.purple),
                            ),
                            child: const Center(
                              child: Text(
                                "ENTRY PASS",
                                style: TextStyle(color: Colors.purple),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "lib/assets/images/Logo.png",
                                width: 100,
                                ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Ticket Details:",
                          style: TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.fontColorPrimary,
                          ),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.only(top: 15),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 12, right: 40),
                              child: ticketDetailWidget(
                                'Event Name:', eventList[index].name, 'Description:', eventList[index].description
                              ),
                            ),
                            Padding(
                              padding: 
                              const EdgeInsets.only(top: 12, right: 40),
                                child: ticketDetailWidget('Date:', eventList[index].eventDate, 'Time:', eventList[index].time),
                            ),
                            Padding(
                              padding: 
                              const EdgeInsets.only(top: 12, right: 40),
                                child: ticketDetailWidget('Location:', eventList[index].location, 'Hall:', eventList[index].hall),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
                        child: Container(
                          width: 250.0,
                          height: 60.0,   
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/assets/images/events/barcode.png'),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 75.0, right: 75.0),
                        child: Text(
                          '9824 0972 1742 1298',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: DefaultButton(
                  text: 'Get Direction', 
                  press: () {
                    double lat = double.parse(eventList[index].latitude);
                    double lng = double.parse(eventList[index].longitude);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventDirectory(lat, lng)));
                  }, 
                  backgroundColor: AppColor.btnColorPrimary, 
                  height: 40, 
                  fontStyle: AppFonts.normalRegularTextWhite, 
                  width: double.infinity, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ticketDetailWidget(String firstTitle, String firstDesc, String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 30), // Adjusted left padding for time and hall
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 33), // Adjusted left padding for description
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  secondDesc,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
