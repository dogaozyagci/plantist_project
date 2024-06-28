import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantist_project/views/login/view/login_view.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isObscure = true.obs;
  var message = ''.obs;

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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
      await _firestore.collection('users').doc(userCredential.user!.uid).set({'email': userCredential.user!.email});
      print('Todo added successfully!');
    } catch (e) {
      print('Error adding todo: $e');
    }
  }
}

class SignUpPage extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Sign up with email',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Enter your email and password',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 35),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Obx(() => TextField(
                controller: passwordController,
                obscureText: signUpController.isObscure.value,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      signUpController.isObscure.value = !signUpController.isObscure.value;
                    },
                    icon: Icon(signUpController.isObscure.value ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              )),
              const SizedBox(height: 30),
              SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    signUpController.signUp(emailController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  // todo: Privacy Policy
                },
                child: const Text.rich(
                  TextSpan(
                    text: "By continuing, you agree to our",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' and',
                      ),
                      TextSpan(
                        text: ' Terms of Use.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
