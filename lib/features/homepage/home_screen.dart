import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/features/homepage/provider/home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // @override
    // void initState() {
    //   super.initState();
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     ref.read(homeNotifierProvider);
    //   });
    // }

    final state = ref.watch(homeNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Material(
                  elevation: 10,
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: MediaQuery.of(context).size.width - 200,
                          ),
                          Row(
                            children: [
                              state.isLoading
                                  ? const CircularProgressIndicator()
                                  : InkWell(
                                    onTap: () {
                                      ref
                                          .read(homeNotifierProvider.notifier)
                                          .navigateToDashboard(context);
                                    },
                                    child: Icon(Icons.person_outline, size: 30),
                                  ),
                              const SizedBox(width: 15),
                              Icon(Icons.menu, size: 30),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
