import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moodee/data/events.dart';
import 'package:moodee/widgets/event_widgets/event_card.dart';

class RandomWishlist extends StatelessWidget {
  const RandomWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shuffledEvents = eventList.toList()..shuffle(); // Shuffle the event list
    final selectedEvents = shuffledEvents.take(5).toList(); // Take the first 5 events

    final rowWidgets = <Widget>[];
    for (int i = 0; i < selectedEvents.length; i += 2) {
      final card1 = i < selectedEvents.length
          ? EventCard(
              eventList: selectedEvents,
              index: i,
              margin: const EdgeInsets.only(left: 15),
            )
          : Container();
      final card2 = (i + 1) < selectedEvents.length
          ? EventCard(
              index: i + 1,
              eventList: selectedEvents,
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
