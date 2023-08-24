import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

// Stream is a flow of data from one point to another point
// A Stream will be built between the flutter app and firebase auth service
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<custUser?>.value(
      initialData: custUser(uid: null),
      value: AuthService().users,
      child: MaterialApp(
        routes: {
          '/': (context) => Wrapper(),
          '/authenticate': (context) => Authenticate(),
          '/home': (context) => Home()
        },
        // home: Wrapper(),
      ),
    );
  }
}
