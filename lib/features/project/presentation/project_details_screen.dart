import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/features/project/presentation/providers/project_details_provider.dart';

class ProjectDetailsScreen extends ConsumerStatefulWidget {
  final String projectId;
  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends ConsumerState<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(projectDetailsNotifierProvider(widget.projectId));
      // .getProjectDetails(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.read(
      projectDetailsNotifierProvider(widget.projectId),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Project Details")),
      body: projectState.when(
        data: (details) {
          debugPrint("Project details fetched successfully!: $details");
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $error')));
          });
          return Center(
            child: Column(
              children: [
                Text('Failed to load project details'),
                ElevatedButton(
                  onPressed: () => ref.refresh(projectDetailsNotifierProvider(widget.projectId)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  const DataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      // widget.projectModel.image ??
                      "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Upcoming Deadline",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Icon(Icons.timer_outlined),
                      const SizedBox(width: 5),
                      Text("Started:"),
                      const SizedBox(width: 5),
                      Text(''),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.edit_square, color: Colors.green),
                          const SizedBox(width: 10),
                          Icon(Icons.delete, color: Colors.red),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("No description provided"),
                  const SizedBox(height: 25),
                  Text(
                    "Project Tasks",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.add_circle_outline, color: Colors.blue),
                      const SizedBox(width: 5),
                      Text("Add Task", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Collaborators",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add, weight: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
