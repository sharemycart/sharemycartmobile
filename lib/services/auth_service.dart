import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    var authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    return authResult.user;
  }


  Future<String> signUpWithEmailAndPassword(String email, password) async {
   var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
   return authResult.user.uid;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> get firebaseUserUID async {
    return await _auth.currentUser().then((value) => value.uid);
  }

}