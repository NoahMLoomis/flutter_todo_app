import 'package:flutter/material.dart';
import 'package:todo_app_copy/widgets/input.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailTextController =
        TextEditingController(text: "nloomis@spiria.com");
    final TextEditingController passwordTextController =
        TextEditingController(text: "Password1#");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  EmailTextInput(textController: emailTextController),
                  PasswordTextInput(
                    textController: passwordTextController,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailTextController.text,
                            password: passwordTextController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                        }
                      },
                      child: const Text("Register"),
                    ),
                  )
                ],
              );
            default:
              return const Text("Loading");
          }
        },
      ),
    );
  }
}
