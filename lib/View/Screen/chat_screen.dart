import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../Controller/chat_controller.dart';
import '../../Utils/helpers.dart';

class ChatPage extends StatefulWidget {
  final String friendId;
  final String friendName;

  ChatPage({required this.friendId, required this.friendName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatC = Get.find<ChatController>();

  final myId = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController textC = TextEditingController();

  String get roomId => makeRoomId(myId, widget.friendId);

  final ScrollController scrollC = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.friendName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(roomId)
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final msgs = snapshot.data!.docs;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollC.hasClients) scrollC.jumpTo(scrollC.position.maxScrollExtent);
                });
                return ListView.builder(
                  controller: scrollC,
                  itemCount: msgs.length,
                  itemBuilder: (context, i) {
                    final m = msgs[i];
                    bool isMe = m['senderId'] == myId;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m['message'], style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                            SizedBox(height: 6),
                            Text(formatTimestamp(m['time']), style: TextStyle(fontSize: 10, color: isMe ? Colors.white70 : Colors.black54)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textC,
                    decoration: InputDecoration(hintText: 'Type message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (textC.text.trim().isNotEmpty) {
                      chatC.sendMessage(widget.friendId, textC.text.trim());
                      textC.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
