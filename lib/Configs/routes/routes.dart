import 'package:chat_app/Configs/routes/routes_name.dart';
import 'package:chat_app/View/Login/login_view.dart';
import 'package:chat_app/ViewModel/Auth/auth_gate.dart';
import 'package:chat_app/ViewModel/Auth/login_or_register.dart';
import 'package:flutter/material.dart';


class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.authGate:
        return MaterialPageRoute(builder: (BuildContext context) => const AuthGate());
      //
      case RoutesName.loginOrRegister:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginOrRegister());
      //
      // case RoutesName.login:
      //   final onTap = settings.arguments as LoginOrRegister?;
      //   return MaterialPageRoute(builder: (BuildContext context) =>  LoginView(onTap: onTap,));

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}