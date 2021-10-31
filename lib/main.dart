import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_state.dart';
import 'package:nfc_library/blocs/simple_bloc_observer.dart';
import 'package:nfc_library/repositories/user_repository.dart';
import 'package:nfc_library/screens/login/login_screen.dart';
import 'package:nfc_library/screens/pages/StaffHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nfc_library/screens/pages/StudentHomePage.dart';
import 'blocs/authentication_bloc/authentication_event.dart';
import 'package:firebase_auth/firebase_auth.dart';


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

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String email;
  String role;
  final UserRepository _userRepository;
  final FirebaseAuth user = FirebaseAuth.instance;

  MyApp({UserRepository userRepository, this.email}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
        cursorColor: Colors.white70,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen(userRepository: _userRepository,);
          }

          if (state is AuthenticationSuccess) {
                var isAdmin="Admin";
                var student = "Student";
                var admin = "admin";
                String userEmail =user.currentUser.email.toString();
                final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

                getData() {
                  return  _fireStore.collection('Users').doc(userEmail).get();
                }
                getData().then((val){
                    isAdmin = val.get('admin');
                    if(isAdmin == student) {
                      getStudent();
                      print(isAdmin);
                      print(userEmail);

                    }
                  });

                FirebaseFirestore.instance
                    .collection('Users')
                    .where('email', isEqualTo: userEmail)
                    .get()
                    .then((docs) {
                  if (docs.docs[0].exists) {
                    if (docs.docs[0].data()['admin'] == 'Admin') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StaffHomePage(userStatus: isAdmin)),
                      );
                    } else if (docs.docs[0].data()['admin'] == 'Student'){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentHomePage(userStatus: isAdmin)),
                      );}
                  }
                  });
           }

          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(child: Text("Loading...")),
            ),
          );
        },
      ),
    );
  }

  void getEmail(String email){
    this.email = email;
  }

  getStudent(){
    role = "Student";
  }
  getAdmin(){
    role = "Admin";
  }
}

