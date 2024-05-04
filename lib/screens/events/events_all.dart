// JUST FOR TESTING

import 'package:flutter/material.dart';
import 'package:moodee/data/events.dart';
import 'package:moodee/providers/events_provider.dart';
import 'package:moodee/widgets/event_widgets/event_card.dart';
import 'package:provider/provider.dart';

class EventsAll extends StatelessWidget {
  const EventsAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EventsProvider>(context, listen: false);

    final rowWidgets = <Widget>[];
    for (int i = 0; i < provider.eventsList.length; i += 2) {
      final card1 = i < provider.eventsList.length
          ? EventCard(
              eventList: provider.eventsList,
              index: i,
              margin: const EdgeInsets.only(left: 15),
            )
          : Container();
      final card2 = (i + 1) < provider.eventsList.length
          ? EventCard(
              index: i + 1,
              eventList: provider.eventsList,
              margin: const EdgeInsets.only(
                right: 15,
              ),
            )
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
