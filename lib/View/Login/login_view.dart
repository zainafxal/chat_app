
import 'package:chat_app/Configs/Components/my_button.dart';
import 'package:chat_app/Configs/Components/my_textfield.dart';
import 'package:chat_app/Services/auth_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginView extends StatefulWidget {
  final void Function()? onTap;
  LoginView({super.key, required this.onTap});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {



  // Email Controller
  final TextEditingController _emailController = TextEditingController();

  // Password Controller
  final TextEditingController _passwordController = TextEditingController();


  // Login Method

  void login(BuildContext context) async{

    final authService = AuthService();

  //   Try Block
    try{
      await authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    }

  //   Catch any errors
    catch(e){

      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ));

    }

  }
  

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
              "Welcome Back, You've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
              ),
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
              height: 30,
            ),


            //   Login Button
            MyButton(text: "Login",
                onTap: () => login(context),

            ),


            SizedBox(
              height: 30,
            ),



            //   Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Not a member?",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: widget.onTap, // Access the onTap function passed from parent
                  child: Text("Register Now", style: TextStyle(fontWeight: FontWeight.bold)),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}
