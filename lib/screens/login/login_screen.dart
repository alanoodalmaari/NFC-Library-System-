import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/login_bloc/login_bloc.dart';
import 'package:nfc_library/repositories/user_repository.dart';
import 'package:nfc_library/widgets/curved_widget.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blueAccent
          ),
          child: Scaffold(
            backgroundColor: Colors.indigoAccent,
            /*appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Sign in with Google"),
      ),*/
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60,),
                  //We take the image from the assets
                  Image.asset(
                    'images/book.png',
                    height: 230,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Texts and Styling of them
                  Text(
                    'NFC Library',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28,),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    child: LoginForm(userRepository: _userRepository,),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
