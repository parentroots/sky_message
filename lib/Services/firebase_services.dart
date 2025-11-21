import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseDatabase _realtime = FirebaseDatabase.instance;


  Future<void> createUserInFirestore({required String uid, required String name, required String email}) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'photo': '',
      'online': true,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }


  Future<void> sendMessage(String roomId, Map<String, dynamic> msg) async {
    await _firestore.collection('chats').doc(roomId).collection('messages').add(msg);
    await _firestore.collection('chats').doc(roomId).set({'lastMessage': msg['message'], 'lastTime': FieldValue.serverTimestamp()}, SetOptions(merge: true));
  }


  Stream<QuerySnapshot> messagesStream(String roomId) {
    return _firestore.collection('chats').doc(roomId).collection('messages').orderBy('time').snapshots();
  }


  Stream<QuerySnapshot> usersStream() => _firestore.collection('users').snapshots();


  DatabaseReference statusRef(String uid) => _realtime.ref('status/$uid');
}