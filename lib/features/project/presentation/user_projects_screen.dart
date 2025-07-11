import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/core/constants/Widgets/task_card.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/presentation/providers/project_provider.dart';

class UserProjectsScreen extends ConsumerStatefulWidget {
  const UserProjectsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProjectState();
}

class _UserProjectState extends ConsumerState<UserProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isInitializing = true;
    Map<String, List<ProjectModel>> projects = {
      'allProjects': [],
      'adminProjects': [],
    };
    String? errorResponse;

    final projectState = ref.watch(projectNotifierProvider);

    projectState.when(
      data: (projectsData) {
        isInitializing = false;
        projects = projectsData;
        projects['adminProjects'] = projectsData['adminProjects']!;
        projects['allProjects'] = projectsData['allProjects']!;
        debugPrint("Found datas!");
      },
      loading: () {
        isInitializing = true;
      },
      error: (error, stackTrace) {
        isInitializing = false;
        error = error.toString();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $error')));
        });
        return const SizedBox();
      },
    );

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

              projects['allProjects']!.isNotEmpty
                  ? ListView.builder(
                    itemBuilder: (context, index) {
                      final allProjects = projects['allProjects'];
                      final project = allProjects![index];
                      return Column(
                        children: [
                          TaskCard(
                            projectModel: project,
                            // id: project.id!,
                            // image:
                            //     project.image ??
                            //     "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                            // title: project.name ?? "No name provided",
                            // description:
                            //     project.description ??
                            //     "No description provided",
                            // percent: int.parse(
                            //   project.completionPercentage ?? '0',
                            // ),
                            // writeup:
                            //     "Project Status: ${project.status?.name ?? "No status provided"}",
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    },
                    itemCount: projects['allProjects']!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                  : Column(
                    children: [
                      const SizedBox(height: 80),
                      Center(
                        child:
                            isInitializing
                                ? CircularProgressIndicator.adaptive()
                                : Column(
                                  children: [
                                    Text('No projects found'),
                                    const SizedBox(height: 10),
                                    Text(
                                      errorResponse ?? '',
                                      style: TextStyle(color: Colors.red),
                                    ),

                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                              projectNotifierProvider.notifier,
                                            )
                                            .getUserProjects();
                                      },
                                      child: Text('Refresh'),
                                    ),
                                  ],
                                ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
