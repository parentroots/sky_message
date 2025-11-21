import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../Services/firebase_services.dart';
import '../chat_screen.dart';
import 'package:badges/badges.dart' as badges;

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    with WidgetsBindingObserver {
  final myId = FirebaseAuth.instance.currentUser!.uid;
  final service = FirebaseService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setOnline(true);
  }

  void setOnline(bool online) {
    final ref = service.statusRef(myId);
    ref.set({'online': online, 'lastSeen': ServerValue.timestamp});
    ref.onDisconnect().set({
      'online': false,
      'lastSeen': ServerValue.timestamp,
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    setOnline(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused)
      setOnline(false);
    else if (state == AppLifecycleState.resumed)
      setOnline(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sky-Message"), actions: [Icon(Icons.search)]),
      body: StreamBuilder(
        stream: service.usersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final docs = (snapshot.data as dynamic).docs;
          return Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(

                              radius: 28,            // perfect round
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                    

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Text("Chats"),
                  Icon(Icons.more_horiz)
                ],),
              ),


              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final d = docs[i];
                    if (d.id == myId) return SizedBox();
                    return FutureBuilder(
                      future: service.statusRef(d.id).get(),
                      builder: (context, snap) {
                        bool online = false;
                        String lastSeen = '';
                        if (snap.hasData && (snap.data as dynamic).exists) {
                          final val = (snap.data as dynamic).value as Map;
                          online = val['online'] == true;
                          if (val['lastSeen'] != null) {
                            lastSeen = DateTime.fromMillisecondsSinceEpoch(
                              val['lastSeen'],
                            ).toString();
                          }
                        }
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(d['name'] ?? d['email'],style: TextStyle(
                              fontSize: 18
                            ),),
                            subtitle: Text(
                              online ? 'Online' : 'Last seen: $lastSeen',
                            ),
                            onTap: () => Get.to(
                              () => ChatPage(
                                friendId: d.id,
                                friendName: d['name'] ?? d['email'],
                              ),
                            ),
                            trailing: Column(children: [

                              badges.Badge(
                                badgeContent: Text('3',style: TextStyle(
                                  fontSize: 10
                                ),),
                                child: Icon(Icons.message,size: 15,),
                               badgeAnimation: badges.BadgeAnimation.rotation(loopAnimation: true),
                              )
                            ],),
                          ),
                        );
                      },
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
