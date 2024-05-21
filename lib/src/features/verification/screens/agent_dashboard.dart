import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home.drawer.dart';
import 'package:queue_ease/src/features/chat/screens/chat_screen.dart';
import 'package:queue_ease/src/services/socket_service.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';
import 'package:queue_ease/src/utils/http/http_client.dart';

import '../../../models/request.dart';
import '../../common/snackbar.dart';

class AgentDashboard extends StatefulWidget {
  final token;
  const AgentDashboard({Key? key, @required this.token}) : super(key: key);

  @override
  State<AgentDashboard> createState() => _AgentDashboardState();
}

class _AgentDashboardState extends State<AgentDashboard> {
  List<Request> requests = [];
  @override
  void initState() {
    super.initState();
    getRequests();
    SocketService.newRequestStream.listen((event) {
      setState(() {
        requests.insert(0, event);
      });
    });
  }

  Future<void> getRequests() async {
    try {
      final res = await QEHttpHelper.get('request');
      if (!context.mounted) return;
      setState(() {
        requests = (res['requests'] as List<dynamic>)
            .map((e) => Request.fromJson(e))
            .toList();
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      SnackBarUtil.showErrorBar(context, e.toString());
    }
  }

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
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  return _buildRequestCard(requests[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(Request request) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: dark ? QEColors.darkContainer : QEColors.lightContainer,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${request.requester.firstName}${' '}${request.requester.lastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TimerWidget(createdAt: request.createdAt),
              ],
            ),
            Text("Destination: ${request.destination}"),
            Text("Price: Rs ${request.price}"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Get.to(() => ChatPage(
                            receiverId: request.requester.id,
                            name:
                                '${request.requester.firstName} ${request.requester.lastName}',
                            phoneNumber: request.requester.phoneNumber,
                          ));
                    },
                    child: Text(
                      'ACCEPT',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.green),
                    )),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'REJECT',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  final String createdAt;
  const TimerWidget({super.key, required this.createdAt});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  // time remaining
  int time = 0;
  late DateTime dtCreatedAt;

  String get timerString {
    final hours = time ~/ 3600;
    final minutes = (time % 3600) ~/ 60;
    final seconds = time % 60;

    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');

    if (hours > 0) {
      final hoursStr = hours.toString();
      return '$hoursStr:$minutesStr:$secondsStr';
    } else {
      return '$minutesStr:$secondsStr';
    }
  }

  @override
  void initState() {
    super.initState();
    dtCreatedAt = DateTime.parse(widget.createdAt);

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        time = dtCreatedAt
            .add(const Duration(hours: 1))
            .difference(DateTime.now())
            .inSeconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Expires In: $timerString',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.red));
  }
}
