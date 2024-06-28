import 'package:chat_app/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
//   Get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Get user stream

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user final user
        final user = doc.data();
        return user;
      }).toList();
    });
  }

// Send message
  Future<void> sendMessage(String receiverID, message) async {
    //   get current user info
    final String currenUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //   create a new message
    Message newMessage = Message(
        senderID: currenUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //   cunstruct chat room id for the to users(stored to ensure uniqueness)
    List<String> ids = [currenUserID, receiverID];
    ids.sort(); // Sort the ids (ensure the cat room id is same for any two people)

    String chatRoomID = ids.join('_');

    //   add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

// Get message
 Stream<QuerySnapshot> getMessages(String userID, otherUserID){
 //    construct a chatroom ID for two users
   List<String> ids = [userID, otherUserID];
   ids.sort(); // Sort the ids (ensure the cat room id is same for any two people)

   String chatRoomID = ids.join('_');

   //   add new message to database
   return _firestore
       .collection("chat_rooms")
       .doc(chatRoomID)
       .collection("messages")
       .orderBy("timestamp", descending: false)
       .snapshots();
       
 }


}
