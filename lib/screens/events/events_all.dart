// JUST FOR TESTING

import 'package:flutter/material.dart';
import 'package:moodee/data/events.dart';
import 'package:moodee/widgets/event_widgets/event_card.dart';

class EventsAll extends StatelessWidget {
  const EventsAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rowWidgets = <Widget>[];
    for (int i = 0; i < eventList.length; i += 2) {
      final card1 = i < eventList.length
          ? EventCard(eventList: eventList, index: i)
          : Container();
      final card2 = (i + 1) < eventList.length
          ? EventCard(index: i + 1, eventList: eventList)
          : Container();

      final row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [card1, card2],
      );

      rowWidgets.addAll([row, const SizedBox(height: 15)]);
    }

    return Column(
      children: rowWidgets,
    );
  }
}
