import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

// INI LOGIN ANONIMUS
  // static Future<User> signInAnonymous() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User fbuser = result.user;

  //     return fbuser;
  //   } catch (e) {
  //     print(e.toString());

  //     return null;
  //   }
  // }

  static Future<User> signup(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;

      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Stream<User> get firebaseUserstream => _auth.authStateChanges();
}
