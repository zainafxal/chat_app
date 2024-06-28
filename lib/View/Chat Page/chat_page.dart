import 'package:chat_app/Configs/Components/chat_bubble.dart';
import 'package:chat_app/Configs/Components/my_textfield.dart';
import 'package:chat_app/Services/auth_service.dart';
import 'package:chat_app/Services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //  Text Controller for messages
  final TextEditingController _messageController = TextEditingController();

  // For text field focus
  FocusNode myFocusNode = FocusNode();


  // Scroll controller
  final ScrollController _scrollController = ScrollController();
  void ScrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //   add listner to Focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //   cause the delay so that tha keyboard has time to show up
        //   then the amount of releasing space will be calcuated
        //   then scroll down
        Future.delayed(
          const Duration(microseconds: 500),
          () => ScrollDown(),
        );
      }
    });

  //   Scroll down the messages list autometically
    Future.delayed(const Duration(microseconds: 200), ()=> ScrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }



  // chat and auth services
  final ChatService chatService = ChatService();

  final AuthService authService = AuthService();




  // send message
  void sendMessage() async {
//if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverID, _messageController.text);

      // clear text controller
      _messageController.clear();
    }

    // Call Scroll Down method to scrolldown when we send message
    ScrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.receiverEmail, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Set the leading widget (back arrow) explicitly
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Set color to white
          onPressed: () =>
              Navigator.pop(context), // Handle back button press (optional)
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //   Show messages
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15, top: 2),
              child: _buildMessageList(),
            ),
          ),

          //  user input to send messages

          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 1),
            child: _buildUserInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(widget.receiverID, senderID),
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
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

//   build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;

    // is message align to right,if sender is the current user otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(
        message: data["message"],
        timestamp: data["timestamp"].toDate(),
        isCurrentUser: isCurrentUser,
      ),
    );
  }



//  build message Input
  Widget _buildUserInput() {
    return Row(
      children: [
        //   Text field should take up most of the space
        Expanded(
            child: MyTextField(
          controller: _messageController,
          hintText: "Type a Message",
          focusNode: myFocusNode,
          showVisibilityIcon: false,
          obsc: false,
        )),



        //   Send Button
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade700,
            ),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                )),
          ),
        )
      ],
    );
  }
}
