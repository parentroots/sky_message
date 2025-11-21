import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_message/Services/firebase_services.dart' show FirebaseService;


class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseService _service = FirebaseService();


  var user = Rxn<User>();


  @override
  void onInit() {
    user.value = _auth.currentUser;
    super.onInit();
  }


  Future<String?> signUp(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      user.value = cred.user;
      await _service.createUserInFirestore(uid: user.value!.uid, name: email.split("@")[0], email: email);
      return null;
    } catch (e) {
      return e.toString();
    }
  }


  Future<String?> signIn(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      user.value = cred.user;
      return null;
    } catch (e) {
      return e.toString();
    }
  }


  Future<void> signOut() async {
    await _auth.signOut();
    user.value = null;
  }

}

