import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/presentation/project_details_screen.dart';

class TaskCard extends ConsumerWidget {
  // final String id;
  // final String image;
  // final String title;
  // final String description;
  // final int percent;
  // final String writeup;
  // const TaskCard({
  //   super.key,
  //   required this.image,
  //   required this.title,
  //   required this.description,
  //   required this.percent,
  //   required this.writeup,
  //   required this.id,
  // });

  final ProjectModel projectModel;
  const TaskCard({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ProjectDetailsScreen(projectId: projectModel.id!,),
          ),
        );
      },
      child: Container(
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
              child: Image.network(
                "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                // child: Image.network(
                //   projectModel.image ??
                //       "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                height: 150,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              projectModel.name ?? "No name provided",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(projectModel.description!),
            const SizedBox(height: 20),

            LinearPercentIndicator(
              // width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 15.0,
              animationDuration: 2500,
              percent: int.parse(projectModel.completionPercentage!) / 100,
              barRadius: Radius.circular(10),
              center: Text(
                "${projectModel.completionPercentage} %",
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
                  Text("Project Status: ${projectModel.status}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
