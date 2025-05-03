import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TaskTodayCard extends ConsumerWidget {
  String image;
  String title;
  String description;
  int percent;
  String writeup;
  TaskTodayCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.percent,
    required this.writeup,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // height: 300,
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(description),
          const SizedBox(height: 20),

          LinearPercentIndicator(
            // width: MediaQuery.of(context).size.width - 50,
            animation: true,
            lineHeight: 15.0,
            animationDuration: 2500,
            percent: 0.8,
            barRadius: Radius.circular(10),
            center: Text(
              "${percent.toString()} %",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),

            progressColor: Colors.indigoAccent,
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.timer_outlined),
                const SizedBox(width: 10),
                Text(writeup),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("Go to details", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
