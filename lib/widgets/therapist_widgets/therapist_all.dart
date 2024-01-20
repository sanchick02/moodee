import 'package:flutter/material.dart';
import 'package:moodee/data/therapists.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_card.dart';

class TherapistAll extends StatelessWidget {
  const TherapistAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rowWidgets = <Widget>[];
    for (int i = 0; i < therapistList.length; i += 2) {
      final card1 = i < therapistList.length
          ? TherapistCard(
              therapistList: therapistList,
              index: i,
              margin: const EdgeInsets.only(left: 15),
            )
          : Container();
      final card2 = (i + 1) < therapistList.length
          ? TherapistCard(
              index: i + 1,
              therapistList: therapistList,
              margin: const EdgeInsets.only(right: 15),
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
