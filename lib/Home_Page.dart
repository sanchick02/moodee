import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moodee/navbar.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5E7F2),
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: 120,
                        child: Row(
                          children: [Image.asset("lib/assets/images/Logo.png")],
                        ),
                      ),
                      Container(
                          height: 40,
                          width: 30,
                          child: Image.asset("lib/assets/icons/bell.png"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Good Day, Sam!",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 115,
                        width: 115,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: Offset(0, 3), // Offset from the container
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/images/moodtracker.png",
                              width: 65,
                              height: 77,
                            ),
                            Text(
                              "Mood Tracker",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "LeagueSpartan"),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 115,
                        width: 230,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: Offset(0, 3), // Offset from the container
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Progress",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Moodee Journey")
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 35,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFE5E7F2),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text("0%")],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 180,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Color(0xFFE5E7F2),
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 180,
                  width: 370,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF8E83FF)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Events Nearby",
                        style: TextStyle(
                          fontFamily: "LeagueSpartan",
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF8E83FF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See All",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EventsNearbyWidget(
                        Time: "10:00am - 11:00am",
                        Day: "Monday",
                        Month: "Jan",
                        Date: "01",
                        Location: "sunway pyramid",
                        ImagePath: "lib/assets/images/event1.jpg",
                        Event: "Mindfulness Workshop",
                        Desc: "Stress Management",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      EventsNearbyWidget(
                        Time: "10:00am - 11:00am",
                        Day: "Monday",
                        Month: "Jan",
                        Date: "01",
                        ImagePath: "lib/assets/images/event2.png",
                        Location: "sunway pyramid",
                        Event: "Art & Expressive Therapy",
                        Desc: "Emotional Release",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      EventsNearbyWidget(
                        Time: "12:00pm - 13:00pm",
                        Day: "Monday",
                        Month: "Jan",
                        Date: "01",
                        ImagePath: "lib/assets/images/event3.jpg",
                        Location: "sunway pyramid",
                        Event: "Book Clubs & Literature Circles",
                        Desc: "Space for Discussion",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Book a Therapist",
                          style: TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF8E83FF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See All",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BookTherapistWidget(
                        name: "Sheryl",
                        role: "Psychologist",
                        rating: "4.1",
                        imagePath: "lib/assets/images/therapist1.png",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      BookTherapistWidget(
                        name: "John",
                        role: "psychologist",
                        rating: "4.1",
                        imagePath: "lib/assets/images/therapist2.png",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      BookTherapistWidget(
                        name: "Monica",
                        role: "Mental Health Counselor",
                        rating: "4.1",
                        imagePath: "lib/assets/images/therapist3.png",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Featured Therapy",
                          style: TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF8E83FF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See All",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MusicWidget(
                        ImagePath: "lib/assets/images/music1.jpeg",
                        Minute: "2",
                        Singer: "Moode",
                        Title: "Dreamweave Celestial Reverie",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      MusicWidget(
                        ImagePath: "lib/assets/images/music2.jpg",
                        Minute: "2",
                        Singer: "Lauv",
                        Title: "idk",
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      MusicWidget(
                        ImagePath: "lib/assets/images/music1.jpeg",
                        Minute: "2",
                        Singer: "Moode",
                        Title: "Dreamweave Celestial Reverie",
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Navigation(),
          )
        ]));
  }
}
