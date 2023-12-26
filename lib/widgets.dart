import 'package:flutter/material.dart';

class EventsNearbyWidget extends StatelessWidget {
  const EventsNearbyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(children: [
        Container(
            height: 151,
            width: 155,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Color(0xFF8E83FF)))
      ]),
    );
  }
}

class BookTherapistWidget extends StatelessWidget {
  const BookTherapistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(children: [
        Container(
            height: 151,
            width: 155,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Color(0xFF8E83FF)))
      ]),
    );
  }
}
