import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import '../widgets/input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailTextController =
        TextEditingController(text: "noah.loomis@me.com");
    final TextEditingController passwordTextController =
        TextEditingController(text: "Password1#");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Login",
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
                              .signInWithEmailAndPassword(
                            email: emailTextController.text,
                            password: passwordTextController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "INVALID_LOGIN_CREDENTIALS") {
                            print("Invalid user credentials");
                          }
                        }
                      },
                      child: const Text("Login"),
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
