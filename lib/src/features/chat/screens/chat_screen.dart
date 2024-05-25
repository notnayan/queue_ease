// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:queue_ease/src/features/booking/screens/home/home_screen.dart';
import 'package:queue_ease/src/services/socket_service.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/http/http_client.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> chatScaffoldKey = GlobalKey();

class ChatPage extends StatefulWidget {
  final String? requestId;
  final String? receiverId;
  final String? name;
  final String? phoneNumber;
  const ChatPage(
      {super.key,
      this.receiverId,
      this.name,
      this.phoneNumber,
      this.requestId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String referenceId = "";
  bool loading = true;
  final TextEditingController _messageController = TextEditingController();

  String name = 'Loading ..';
  String phoneNumber = 'Loading ..';
  String chatId = '';
  List<dynamic> messages = [];
  num? price;

  // Phone call to agent or user number
  Future<void> makePhoneCall(String phoneQE) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneQE);
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      name = widget.name!;
    }

    if (widget.phoneNumber != null) {
      phoneNumber = widget.phoneNumber!;
    }

    getChat();
  }

  void getChat() async {
    final res = await QEHttpHelper.post('chat', {
      'userId': Hive.box('user').get('user')['_id'],
    });

    final chat = res['chats'];
    setState(() {
      name = chat['users'][0]['firstName'] + " " + chat['users'][0]['lastName'];
      phoneNumber = chat['users'][0]['phoneNumber'];
      chatId = chat['_id'];
      messages = chat['messages'] ?? [];
      price = res['request']['price'] ?? 9999;
    });

    messages = messages.reversed.toList();

    SocketService().listen(chat['_id'], (data) {
      print(data);
      setState(() {
        messages.insert(0, data['message']);
      });
    });

    SocketService().listen("endRequest", (data) {
      print(data);
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    SocketService().removeListener(chatId);
    super.dispose();
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: price!.toInt() * 1,
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) async {
    await QEHttpHelper.post("request/endChat", {
      'userId': Hive.box('user').get('user')['_id'],
    });
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          actions: [
            SimpleDialogOption(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    referenceId = success.idx;
                  });
                  Navigator.pop(context);
                  if (chatScaffoldKey.currentState != null) {
                    Navigator.pop(chatScaffoldKey.currentState!.context);
                  }
                })
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await QEHttpHelper.post('chat/send', {
        "chatId": chatId,
        "text": _messageController.text,
        "userId": Hive.box('user').get('user')['_id'],
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: chatScaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: QEColors.primary,
          leadingWidth: 100,
          titleSpacing: 0,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: QESizes.iconMd,
                ),
              ),
            ],
          ),
          title: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(name, style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                makePhoneCall(phoneNumber);
              },
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text(
                          "CONFIRMATION",
                          style: TextStyle(fontSize: 20),
                        ),
                        content: const Text(
                          "Are you sure you want to end the service?",
                          style: TextStyle(fontSize: 16),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: QEColors.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Center(
                                          child: Text(
                                            "SERVICE COMPLETED",
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: QESizes.defaultSpace,
                                        ),
                                        const Text(
                                          "The service has ended. Please proceed with the payment option. If you have any complains please click the support button.",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                            height: QESizes.defaultSpace),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(24),
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                payWithKhaltiInApp();
                                              },
                                              child: const Text(
                                                "KHALTI",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(24),
                                                  backgroundColor:
                                                      QEColors.success,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)))),
                                              onPressed: () =>
                                                  makePhoneCall('9804302504'),
                                              child: const Text(
                                                "SUPPORT",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "YES",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "NO",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(CupertinoIcons.stop_circle),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {
                    final isSentByMe = messages[index]['sender'] ==
                        Hive.box('user').get('user')['_id'];
                    return ListTile(
                      title: Row(
                          mainAxisAlignment: isSentByMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [Text(isSentByMe ? "YOU" : name)]),
                      subtitle: Row(
                        mainAxisAlignment: isSentByMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(messages[index]['text']),
                        ],
                      ),
                      leading: isSentByMe
                          ? null
                          : const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq9Q8_e7jHb57d-9Ym5Ryv-R2HkRPLx6YE9TKLixS7pA&s'),
                            ),
                      trailing: isSentByMe
                          ? const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq9Q8_e7jHb57d-9Ym5Ryv-R2HkRPLx6YE9TKLixS7pA&s'),
                            )
                          : null,
                    );
                  },
                  itemCount: messages.length),
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _messageController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            decoration: InputDecoration(
                              labelText: "Type a message",
                              contentPadding: const EdgeInsets.all(
                                  QESizes.spaceBtwInputFields),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                  icon: const Icon(CupertinoIcons.paperplane),
                                  onPressed: _sendMessage,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
