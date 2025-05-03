import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tasksphere_riverpod/constants/Widgets/task_card.dart';
import 'package:tasksphere_riverpod/constants/Widgets/task_today_card.dart';
import 'package:tasksphere_riverpod/models/user_model.dart';
import 'package:tasksphere_riverpod/pages/userDashboard/calendar.dart';
import 'package:tasksphere_riverpod/pages/userDashboard/user_dashboard.dart';
import 'package:tasksphere_riverpod/pages/userDashboard/user_profile.dart';
import 'package:tasksphere_riverpod/pages/userDashboard/user_project.dart';
import 'package:tasksphere_riverpod/providers/auth_provider.dart';
import 'package:tasksphere_riverpod/providers/dio_provider.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final dio = ref.watch(dioProvider);

    // Add interceptor once using a valid ref
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final authState = ref.read(authControllerProvider);
            if (authState is AsyncData<User?> && authState.value != null) {
              options.headers['Authorization'] =
                  'Bearer ${authState.value!.token}';
            }
            return handler.next(options);
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401) {
              await ref.read(authControllerProvider.notifier).logout();
            }
            return handler.next(error);
          },
        ),
      );
    }

    final PageController _pageController = PageController();
    int currentPage = 0;

    List<Widget> _pages = [
      UserDashboard(),
      UserProject(),
      Calendar(),
      UserProfile(),
    ];

    void onDrawerItemTapped(int index) {
      setState(() {
        currentPage = index;
      });
      _pageController.jumpToPage(index);
      Navigator.of(context, rootNavigator: true).pop(); // Close the drawer
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Image.asset("assets/images/logo.png")),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => onDrawerItemTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.add_task_sharp),
              title: Text("Projects"),
              onTap: () => onDrawerItemTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text("Calendar"),
              onTap: () => onDrawerItemTapped(2),
            ),
            ListTile(
              leading: Icon(Icons.person_pin),
              title: Text("Settings"),
              onTap: () => onDrawerItemTapped(3),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // title: Text("TaskSphere"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton.outlined(
                      style: ButtonStyle(
                        // iconSize: 15,
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        minimumSize: WidgetStatePropertyAll(const Size(28, 28)),
                        // fixedSize: WidgetStatePropertyAll(const Size(24, 24)),
                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.add, size: 20),
                    ),
                    IconButton.outlined(
                      style: ButtonStyle(
                        // iconSize: 15,
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        minimumSize: WidgetStatePropertyAll(const Size(28, 28)),
                        // fixedSize: WidgetStatePropertyAll(const Size(24, 24)),
                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.notifications, size: 20),
                    ),
                    IconButton.outlined(
                      style: ButtonStyle(
                        // iconSize: 15,
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        minimumSize: WidgetStatePropertyAll(const Size(28, 28)),
                        // fixedSize: WidgetStatePropertyAll(const Size(24, 24)),
                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.person, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      body: PageView(
        controller: _pageController,
        physics:
            NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
