import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/constants/Widgets/task_card.dart';

class UserProject extends ConsumerStatefulWidget {
  const UserProject({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProjectState();
}

class _UserProjectState extends ConsumerState<UserProject> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore Projects",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 0),
                          border: OutlineInputBorder(),
                          isCollapsed: true,
                          hintText: "Search Task",
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.sort),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Projects",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "My Projects",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TaskCard(
                image:
                    "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                title: "TaskSphere Project Task",
                description: "Tasksphere Mobile App",
                percent: 80,
                writeup: "Assigned: 2 days ago",
              ),
              const SizedBox(height: 10),
              TaskCard(
                image:
                    "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                title: "TaskSphere Project Task",
                description: "Tasksphere Mobile App",
                percent: 80,
                writeup: "Assigned: 2 days ago",
              ),
              const SizedBox(height: 10),
              TaskCard(
                image:
                    "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                title: "TaskSphere Project Task",
                description: "Tasksphere Mobile App",
                percent: 80,
                writeup: "Assigned: 2 days ago",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
