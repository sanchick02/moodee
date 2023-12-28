import 'package:flutter/material.dart';

class EventsNearbyWidget extends StatelessWidget {
  final String Location;
  final String Event;
  final String Desc;
  final String ImagePath;
  final String Month;
  final String Date;
  final String Day;
  final String Time;
  // Parameter to hold the image path
  const EventsNearbyWidget({
    required this.Location,
    required this.Event,
    required this.Desc,
    required this.ImagePath,
    required this.Month,
    required this.Date,
    required this.Day,
    required this.Time,
    // Require imagePath when creating the widget
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(children: [
        Stack(
          children: [
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                image: DecorationImage(
                    image: AssetImage(ImagePath), fit: BoxFit.cover),
              ),
            ),
            Container(
              height: 180,
              width: 180,
              padding:
                  EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xFFB887FF).withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "lib/assets/icons/Location.png",
                            height: 15,
                            width: 15,
                          ),
                          Text(
                            Location,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Image.asset(
                        "lib/assets/icons/bell.png",
                        height: 20,
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            Event,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  Spacer(),
                  Text(
                    Desc,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Month,
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    Date,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.black,
            ),
            Container(
              height: 50,
              width: 120,
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Day),
                  Text(
                    Time,
                    style: TextStyle(fontSize: 11),
                  )
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}

class BookTherapistWidget extends StatelessWidget {
  final String imagePath;
  final String rating;
  final String name;
  final String role; // Parameter to hold the image path
  const BookTherapistWidget({
    required this.imagePath,
    required this.rating,
    required this.name,
    required this.role,
    // Require imagePath when creating the widget
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 180,
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "lib/assets/images/meshGrad1.png",
                  ),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "lib/assets/icons/Rating.png",
                                height: 10,
                                width: 10,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(rating),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            role,
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: 160,
                        width: 100,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                imagePath,
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ), // Use the provided imagePath here
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "View More",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset(
                "lib/assets/icons/arrow_next_gray_small.png",
                height: 20,
                width: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}

class MusicWidget extends StatelessWidget {
  final String Title;
  final String Singer;
  final String Minute;
  final String ImagePath;

  // Parameter to hold the image path
  const MusicWidget({
    required this.Title,
    required this.Singer,
    required this.Minute,
    required this.ImagePath,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(children: [
        Stack(
          children: [
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                image: DecorationImage(
                    image: AssetImage(ImagePath), fit: BoxFit.cover),
              ),
            ),
            Container(
                height: 180,
                width: 180,
                padding:
                    EdgeInsets.only(top: 50, right: 15, left: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFF).withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 130,
                      height: 90,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Title,
                              style: TextStyle(fontSize: 20),
                            )
                          ]),
                    ),
                    Spacer(),
                    Text(Singer + " • " + Minute + "mins")
                  ],
                )),
          ],
        ),
        Container(
          height: 50,
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Start Therapy",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              Image.asset(
                "lib/assets/icons/play_music.png",
                height: 23,
                width: 23,
              )
            ],
          ),
        )
      ]),
    );
    ;
  }
}
