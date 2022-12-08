import 'package:brew_crew/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  custUser _userFromFirebase(User? user) {
    return user != null ? custUser(uid: user.uid) : custUser(uid: null);
  }

  Stream<custUser?> get users {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user));
  }

  //sign in anon
  Future signInano() async {
    try {
      final UserCredential credential = await _auth.signInAnonymously();
      // print(result.user);
      final user = credential.user;

      return _userFromFirebase(user);

      // This part has been done in _userFromFirebase()
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

  //register using email
  Future<custUser> registerWithEmailAndPassword(
      String email, String pwd) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );

      final user = credential.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      print(e);
      return custUser(uid: null);
    } catch (e) {
      print(e);
      return custUser(uid: null);
    }
  }

  //sign in email
  Future<custUser> loginWithEmailAndPassword(String email, String pwd) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );

      final user = credential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print("Error =>${e}");
      return custUser(uid: null);
    }
  }

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
