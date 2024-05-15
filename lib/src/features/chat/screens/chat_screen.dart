import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 100,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: QESizes.iconMd,
                ),
                SizedBox(
                  width: QESizes.spaceBtwItems,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/headshot.png"),
                ),
              ],
            ),
          ),
          title: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text("Nayan", style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.videocam),
            // ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            )
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: const InputDecoration(
                          labelText: "Type a message",

                          // File, Camera
                          // suffixIcon: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     IconButton(
                          //       onPressed: () {},
                          //       icon: const Icon(Icons.attach_file),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {},
                          //       icon: const Icon(Icons.camera_alt),
                          //     ),
                          //   ],
                          // ),

                          contentPadding:
                              EdgeInsets.all(QESizes.spaceBtwInputFields),
                        ),
                      ),
                    ),
                  ),
                  //const Spacer(),

                  //MIC

                  // Padding(
                  //   padding: const EdgeInsets.only(right: 8),
                  //   child: CircleAvatar(
                  //     backgroundColor: QEColors.primary,
                  //     radius: 25,
                  //     child: IconButton(
                  //         onPressed: () {}, icon: const Icon(Icons.mic)),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
