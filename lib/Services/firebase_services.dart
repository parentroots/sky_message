import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final users = FirebaseFirestore.instance.collection('users');

  /// ------------------ Create User ------------------
  Future<void> createUserInFirestore({
    required String uid,
    required String name,
    required String email,
  }) async {
    await users.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'photo': '',
      'online': true,
      'lastSeen': DateTime.now().millisecondsSinceEpoch, // fixed
    }, SetOptions(merge: true));
  }

  /// ------------------ Send Message ------------------
  Future<void> sendMessage(String roomId, Map<String, dynamic> msg) async {
    await _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .add(msg);

    await _firestore.collection('chats').doc(roomId).set({
      'lastMessage': msg['message'],
      'lastTime': DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));
  }

  /// ------------------ Message Stream ------------------
  Stream<QuerySnapshot> messagesStream(String roomId) {
    return _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  /// ------------------ Users Stream ------------------
  Stream<QuerySnapshot> usersStream() {
    return users.snapshots();
  }

  /// ------------------ Online / Offline ------------------
  Future<void> setOnlineStatus(String uid, bool isOnline) async {
    await users.doc(uid).update({
      "online": isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
