import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_message/Utils/AppColors/app_colors.dart';
import 'package:badges/badges.dart' as badges;

import '../../../Services/firebase_services.dart';
import '../chat_screen.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> with WidgetsBindingObserver {
  final myId = FirebaseAuth.instance.currentUser!.uid;
  final service = FirebaseService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    goOnline();
  }

  /// ----------- Set Online ----------
  void goOnline() {
    service.setOnlineStatus(myId, true);
  }

  /// ----------- Set Offline ----------
  void goOffline() {
    service.setOnlineStatus(myId, false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    goOffline();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      goOnline();
    } else {
      goOffline();
    }
  }

  /// Timestamp parser
  int parseLastSeen(dynamic value) {
    if (value is int) return value;
    if (value is Timestamp) return value.millisecondsSinceEpoch;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sky-Message")),

      body: StreamBuilder<QuerySnapshot>(
        stream: service.usersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          final docs = snapshot.data!.docs;

          return Column(
            children: [
              /// Search box
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Card(
                  color: Colors.grey.shade300,
                  elevation: 4,
                  child: Row(
                    children: [
                      SizedBox(width: 50),
                      Icon(Icons.search, color: AppColors.blackColor),
                      SizedBox(
                        width: 220,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Search Here"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Horizontal list
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),

              /// Header
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chats",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    Icon(Icons.more_horiz),
                  ],
                ),
              ),

              /// User list
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final d = docs[i];

                    if (d.id == myId) return SizedBox();

                    bool online = d['online'] ?? false;
                    int last = parseLastSeen(d['lastSeen']);
                    String lastSeen = last != 0
                        ? DateTime.fromMillisecondsSinceEpoch(last).toString()
                        : "";

                    return Card(
                      elevation: 0,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          d['name'] ?? d['email'],
                          style: TextStyle(fontSize: 18),
                        ),

                        subtitle: Text(
                          online ? "Online" : "Last seen: $lastSeen",
                        ),

                        onTap: () => Get.to(() => ChatPage(
                          friendId: d.id,
                          friendName: d['name'] ?? d['email'],
                        )),

                        trailing: badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: online ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
