import 'package:chat_app/Configs/Components/drawer.dart';
import 'package:chat_app/Configs/Components/user_tile.dart';
import 'package:chat_app/Services/auth_service.dart';
import 'package:chat_app/Services/chat_service.dart';
import 'package:chat_app/View/Chat%20Page/chat_page.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();


  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu, // Change this to the icon you want
              color: Colors.white, // Change this to the color you want
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ), // Custom icon
      ),
      drawer: Drawerr(),
      body: _buildUserList(),
    );
  }



//   build a user list except current user logged in

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //   error
          if (snapshot.hasError) {
            return const Text('Error');
          }

          //   loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          //   List view

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

//  build indiual List Tile For User

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
//     All users except current user
    if(userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: userData["email"],
                    receiverID: userData["uid"],
                  )));
        },
      );
    }else{
      return Container();
    }
  }
}
