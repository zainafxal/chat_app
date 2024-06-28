import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instance of FirebaseAuth

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instance of FireStore

  User? getCurrentUser(){
    return _auth.currentUser;
  }


  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //   Save user info if user dosent already exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,


          }
      );

      return userCredential; // Corrected variable name
    } on FirebaseAuthException catch (e) {
      rethrow; // Rethrow the exception for proper error handling
    }
  }



// Sign up (implement this functionality as needed)
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //   Save user info in seprate document
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,


        }
      );


      return userCredential; // Corrected variable name
    } on FirebaseAuthException catch (e) {
      rethrow; // Rethrow the exception for proper error handling
    }
  }








// Sign out (implement this functionality as needed)
 Future<void> signOut() async{
    return await _auth.signOut();
 }

// Handle errors (consider adding specific error handling methods here)
// ...
}
