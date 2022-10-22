import 'package:brew_crew/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //sign in anon
  // await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  custUser _userFromFirebase(User? user) {
    return user != null ? custUser(uid: user.uid) : custUser(uid: null);
  }

  Stream<custUser?> get users {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user));
  }

  Future signInano() async {
    try {
      final UserCredential credential = await _auth.signInAnonymously();
      // print(result.user);
      final user = credential.user;

      return _userFromFirebase(user);

      // if (user != null) {
      //   _myUser = custUser(uid: user.uid);
      // } else {
      //   _myUser = custUser(uid: "Not Available");
      // }
      // return _myUser;

    } catch (e) {
      print('Error ==> $e');
    }
  }

  //sign in email
  //register using email
  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
