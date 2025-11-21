import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Services/firebase_services.dart';


class ChatController extends GetxController {
  FirebaseService service = FirebaseService();
  final myId = FirebaseAuth.instance.currentUser!.uid;

  String roomId(String friendId) {
    return myId.compareTo(friendId) > 0 ? "$myId\_$friendId" : "$friendId\_$myId";
  }

  Future<void> sendMessage(String friendId, String text) async {
    final msg = {
      'senderId': myId,
      'receiverId': friendId,
      'message': text,
      'time': DateTime.now().millisecondsSinceEpoch
    };
    await service.sendMessage(roomId(friendId), msg);
  }
}
