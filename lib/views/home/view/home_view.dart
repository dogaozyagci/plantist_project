import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_project/views/login/view/login_view.dart';
import 'package:plantist_project/views/signUp/view/signup_view.dart';

class MyHomePageController extends GetxController {}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final MyHomePageController myHomePageController =
      Get.put(MyHomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 75),
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 80,
                  offset: const Offset(0, 1),
                ),
              ]),
              child: Image.asset(
                'assets/images/home/Ekran_Resmi_2024-06-26_15.24.40-removebg-preview.png',
                width: 350,
                height: 350,
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Welcome back to ',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Plantist',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Start our productive life now!',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 350,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.to(SignInPage());
                },
                icon: const Icon(Icons.email, color: Colors.black),
                label: const Text(
                  'Sign in with E-mail',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF6F6F6),
                  onPrimary: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Get.to(SignUpPage());
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Sign up',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
