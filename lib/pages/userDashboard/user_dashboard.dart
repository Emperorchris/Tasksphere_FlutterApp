import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:tasksphere_riverpod/core/constants/Widgets/task_card.dart';
import 'package:tasksphere_riverpod/core/constants/Widgets/task_today_card.dart';
import 'package:tasksphere_riverpod/pages/userDashboard/calendar.dart';

class UserDashboard extends ConsumerStatefulWidget {
  const UserDashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDashboardState();
}

class _UserDashboardState extends ConsumerState<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Hi, Emperor",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text('let\'s finish your task today!'),
                const SizedBox(height: 20),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: const Color.fromARGB(218, 9, 30, 99),
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Running Task',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Container(
                            height: 75,
                            width: 75,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: const Text(
                                '0%',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // center vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('Tasks'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 300,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(53, 120, 121, 122),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Activity'), Text('This week')],
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 220,
                        // width: double.infinity - 80,
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const days = [
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat',
                                      'Sun',
                                    ];
                                    final index = value.toInt();
                                    return Text(
                                      days[index % days.length],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              border: Border(
                                left: BorderSide(),
                                bottom: BorderSide(),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 0),
                                  FlSpot(1, 3),
                                  FlSpot(3, 5),
                                  FlSpot(4, 6),
                                  FlSpot(7, 5),
                                ],
                                isCurved: true,
                                color: Colors.indigoAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "New Tasks",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                ),
                const Divider(),
                const SizedBox(height: 10),
                // TaskCard(
                //   image:
                //       "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                //   title: "TaskSphere Project Task",
                //   description: "Tasksphere Mobile App",
                //   percent: 80,
                //   writeup: "Assigned: 2 days ago",
                // ),
                // const SizedBox(height: 30),
                // const Text(
                //   "Upcoming Deadline",
                //   style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                // ),
                // const Divider(),
                // const SizedBox(height: 10),
                // TaskCard(
                //   image:
                //       "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
                //   title: "Second Project Task",
                //   description: "Sleek Mobile App",
                //   percent: 80,
                //   writeup: "Assigned: 6 days ago",
                // ),
                const SizedBox(height: 30),
                HorizontalWeekCalendar(
                  activeBackgroundColor: Colors.indigoAccent,
                  activeNavigatorColor: Colors.indigoAccent,
                  initialDate: DateTime.now(),
                  minDate: DateTime(2023, 1, 1),
                  maxDate: DateTime.now().add(Duration(days: 365 * 100)),
                  onDateChange: (date) {
                    setState(() {
                      // selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Calendar()),
                      // );
                    },
                    child: Text(
                      "Open calendar",
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
            TaskTodayCard(
              image:
                  "https://task-sphere-five.vercel.app/assets/task-image2-BVkfm2uA.png",
              title: "TaskSphere Project Task",
              description: "Tasksphere Mobile App",
              percent: 80,
              writeup: "3 hours ago",
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
