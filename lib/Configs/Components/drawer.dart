import 'package:chat_app/Services/auth_service.dart';
import 'package:chat_app/View/Settings%20Page/settings_page.dart';
import 'package:flutter/material.dart';

class Drawerr extends StatelessWidget {
  // Logout method
  void logout() {
    //   Get Auth Service
    final _auth = AuthService();
    _auth.signOut();
  }
  Drawerr({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //   Logo\
              DrawerHeader(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  )),

              //   Home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),

              //   Settings list tile

              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text("S E T T I N G S"),
                    leading: const Icon(Icons.settings),
                    onTap: (){
                      // Close the drawer (if open)
                      Navigator.pop(context); // This closes the drawer
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
                    },
                  )),
            ],
          ),

          //   Logout list tile

          Padding(
              padding: const EdgeInsets.only(left: 25.0,bottom: 25.0),
              child: ListTile(
                title: const Text("L O G  O U T"),
                leading: const Icon(Icons.logout),
                onTap: (){
                  logout();
                },
              )),
        ],
      ),
    );
  }
}
