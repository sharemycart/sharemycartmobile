import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    var authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }


  Future<String> signUpWithEmailAndPassword(String email, password) async {
   var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
   return authResult.user.uid;
  }

}