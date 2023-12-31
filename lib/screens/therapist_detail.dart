import 'package:flutter/material.dart';
import 'package:moodee/models/therapists_model.dart';

class TherapistDetailScreen extends StatelessWidget {
  TherapistDetailScreen(
      {Key? key, required this.index, required this.therapistList})
      : super(key: key);

  List<Therapist> therapistList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(therapistList[index].name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(therapistList[index].image),
            Text(therapistList[index].name),
            Text(therapistList[index].title),
            Text(
              therapistList[index].rating.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
