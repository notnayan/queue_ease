import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home.drawer.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class AgentDashboard extends StatefulWidget {
  final token;
  const AgentDashboard({Key? key, @required this.token}) : super(key: key);

  @override
  State<AgentDashboard> createState() => _AgentDashboardState();
}

class _AgentDashboardState extends State<AgentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QETexts.appName),
        elevation: 0,
      ),
      drawer: MyDrawer(token: widget.token),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "YOUR REQUESTS",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildRequestCard(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: QEColors.primary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FirstName$index",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("LastName$index"),
            Text("Destination$index"),
            Text("Price$index"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    color: QEColors.success,
                    size: QESizes.iconLg,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.clear_circled_solid,
                    color: QEColors.error,
                    size: QESizes.iconLg,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
