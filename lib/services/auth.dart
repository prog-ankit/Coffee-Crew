import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //sign in anon
  // await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInano() async {
    try {
      final UserCredential credential = await _auth.signInAnonymously();
      // print(result.user);
      final user = credential.user;

      // print(user);
      return user;
    } catch (e) {
      print('Error ==> $e');
    }
  }

  //sign in email
  //register using email
  //signout

}
