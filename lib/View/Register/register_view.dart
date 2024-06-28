import 'package:chat_app/Configs/Components/my_textfield.dart';
import 'package:chat_app/Services/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Configs/Components/my_button.dart';

class RegisterView extends StatefulWidget {
  final void Function()? onTap;
  RegisterView({super.key, required this.onTap});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

// Email Controller
final TextEditingController _emailController = TextEditingController();

// Password Controller
final TextEditingController _passwordController = TextEditingController();

// Confirm Password Controller
final TextEditingController _confirmpasswordController =
    TextEditingController();

// Register Method
void register(BuildContext context) async {
  // Get Auth Service
  final _auth = AuthService();

  // Basic Input Validation
  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Please fill all fields"),
      ),
    );
    return;
  }

  if (_passwordController.text.length < 6) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Password must be at least 6 characters"),
      ),
    );
    return;
  }

  if (_passwordController.text != _confirmpasswordController.text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Passwords Don't match"),
      ),
    );
    return;
  }

  try {
    await _auth.signUpWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    // Handle successful signup (e.g., navigate to a different screen)
  } on FirebaseAuthException catch (e) {
    // Handle specific errors
    if (e.code == 'weak-password') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password is too weak"),
        ),
      );
    } else if (e.code == 'email-already-in-use') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Email already in use"),
        ),
      );
    } else {
      // Handle other errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("An error occurred"),
        ),
      );
    }
  }
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Message icon

            Icon(
              Icons.message,
              size: 90,
              color: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(
              height: 10,
            ),

            //   Welcome Message
            Text(
              "Lets Create New Account For You",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),

            SizedBox(
              height: 20,
            ),

            //   Email Txt Field
            MyTextField(
              hintText: "Email",
              showVisibilityIcon: false,
              obsc: false,
              controller: _emailController,
            ),

            SizedBox(
              height: 10,
            ),

            //   Password Txt Field
            MyTextField(
              hintText: "Password",
              showVisibilityIcon: true,
              obsc: true,
              controller: _passwordController,
            ),

            SizedBox(
              height: 10,
            ),

            //   Confirm Password Txt Field
            MyTextField(
              hintText: "Confirm Password",
              showVisibilityIcon: true,
              obsc: true,
              controller: _confirmpasswordController,
            ),

            SizedBox(
              height: 30,
            ),

            //   Register Button
        MyButton(text: "Sign Up", onTap: () => register(context)),


            SizedBox(
              height: 30,
            ),

            //   Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
