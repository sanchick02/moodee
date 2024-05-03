import 'package:flutter/material.dart';
import 'package:moodee/data/therapists.dart';
import 'package:moodee/providers/therapist_provider.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_card.dart';
import 'package:provider/provider.dart';

class TherapistAll extends StatelessWidget {
  const TherapistAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TherapistProvider>(context);

    final rowWidgets = <Widget>[];
    for (int i = 0; i < provider.therapistsList.length; i += 2) {
      final card1 = i < provider.therapistsList.length
          ? TherapistCard(
              therapistList: provider.therapistsList,
              index: i,
              margin: const EdgeInsets.only(left: 15),
            )
          : Container();
      final card2 = (i + 1) < provider.therapistsList.length
          ? TherapistCard(
              index: i + 1,
              therapistList: provider.therapistsList,
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
