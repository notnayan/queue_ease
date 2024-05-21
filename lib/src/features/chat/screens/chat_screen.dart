import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/http/http_client.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String name;
  final String phoneNumber;
  const ChatPage(
      {super.key,
      required this.receiverId,
      required this.name,
      required this.phoneNumber});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String referenceId = "";
  bool loading = true;
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  final List<bool> _isUserMessage = []; 

  // Phone call to agent or user number
  Future<void> makePhoneCall(String phoneQE) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneQE);
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  Future<void> connectToSocket() async {
    final chatId = await QEHttpHelper.post('chat/${widget.receiverId}', {
      'userId': Hive.box('user').get('user')['_id'],
    });

    print(chatId);

    // SocketService().listen(chatId, (data) => null);
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 150000,
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

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
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

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
        _isUserMessage.add(true); // Assuming the current user sent this message
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              //GET IMAGE
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://media.licdn.com/dms/image/D4D03AQFiNu9ZPWXEaw/profile-displayphoto-shrink_200_200/0/1671113442731?e=1721865600&v=beta&t=JmV1KvHU8vH_543LvXanZKNaN17bA_1MsqMAHCgJ8kU"),
              ),
            ],
          ),
          title: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(widget.name, style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                makePhoneCall(widget.phoneNumber);
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
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
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
                                              onPressed: payWithKhaltiInApp,
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
        child: Stack(
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
                          contentPadding:
                              const EdgeInsets.all(QESizes.spaceBtwInputFields),
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
      ),
    );
  }
}
