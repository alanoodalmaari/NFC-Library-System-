/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_event.dart';
import 'package:nfc_library/blocs/simple_bloc_observer.dart';
import 'package:nfc_library/repositories/user_repository.dart';
import 'package:nfc_library/screens/login/login_screen.dart';
import 'package:nfc_library/screens/pages/StaffHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/login_bloc/login_bloc.dart';
import 'package:nfc_library/repositories/user_repository.dart';
import 'package:nfc_library/widgets/curved_widget.dart';

import 'lib\screens\login\login_form.dart';


import '../main.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AuthenticationStarted()),
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
Color primaryColor =Colors.blue[900];
Color secondaryColor = Colors.blue;
Color logoColor = Colors.lightBlueAccent;

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      /*appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Sign in with Google"),
      ),*/
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //We take the image from the assets
          Image.asset(
            'images/book.png',
            height: 250,
          ),
          SizedBox(
            height: 20,
          ),
          //Texts and Styling of them
          Text(
            'NFC Library',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          SizedBox(height: 20),
          Text(
            'Welcome, Tap the button to continue',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
      Container(
        margin: const EdgeInsets.only(top: 230),
        child: LoginForm(userRepository: _userRepository,),
      )
        ],
      ),
    );
  }
}

 */
