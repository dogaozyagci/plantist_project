import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/login/view/login_view.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isObscure = true.obs;
  var message = ''.obs;

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      addUserToFirestore(userCredential);
      Get.to(() => SignInPage());
    } on FirebaseAuthException catch (e) {
      message.value = 'Failed to register: ${e.message}';
      Get.snackbar(
        "Registration Error",
        e.message ?? "Unknown error",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addUserToFirestore(UserCredential userCredential) async {
    try {
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'email': userCredential.user!.email});
      print('Todo added successfully!');
    } catch (e) {
      print('Error adding todo: $e');
    }
  }
}
