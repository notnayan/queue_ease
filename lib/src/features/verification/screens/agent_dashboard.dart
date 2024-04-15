import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home.drawer.dart';
import 'package:queue_ease/src/features/verification/screens/agent.registration.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class AgentDashboard extends StatelessWidget {
  const AgentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "REQUESTS",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                color: QEColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("FirstName0"),
                      const Text("Location0"),
                      const Text("Destination0"),
                      const Text("Price0"),
                      const Text("Comments0"),
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: QEColors.success,
                              size: QESizes.iconLg,
                            ),
                          ),
                          const SizedBox(
                            width: QESizes.defaultSpace,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: QEColors.error,
                              size: QESizes.iconLg,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                color: QEColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("FirstName1"),
                      const Text("Location1"),
                      const Text("Destination1"),
                      const Text("Price1"),
                      const Text("Comments1"),
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: QEColors.success,
                              size: QESizes.iconLg,
                            ),
                          ),
                          const SizedBox(
                            width: QESizes.defaultSpace,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: QEColors.error,
                              size: QESizes.iconLg,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                color: QEColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("FirstName2"),
                      const Text("Location2"),
                      const Text("Destination2"),
                      const Text("Price2"),
                      const Text("Comments2"),
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: QEColors.success,
                              size: QESizes.iconLg,
                            ),
                          ),
                          const SizedBox(
                            width: QESizes.defaultSpace,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: QEColors.error,
                              size: QESizes.iconLg,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                color: QEColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("FirstName3"),
                      const Text("Location3"),
                      const Text("Destination3"),
                      const Text("Price3"),
                      const Text("Comments3"),
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: QEColors.success,
                              size: QESizes.iconLg,
                            ),
                          ),
                          const SizedBox(
                            width: QESizes.defaultSpace,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: QEColors.error,
                              size: QESizes.iconLg,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
