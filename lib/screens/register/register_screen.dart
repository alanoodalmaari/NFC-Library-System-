import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/register_bloc/register_bloc.dart';
import 'package:nfc_library/repositories/user_repository.dart';
import 'package:nfc_library/screens/register/register_form.dart';
import 'package:nfc_library/widgets/curved_widget.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegisterScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepository: _userRepository),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white70,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                CurvedWidget(
                  child: Container(
                    padding: const EdgeInsets.only(top: 100, left: 50),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(color: Colors.indigoAccent,
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 230),
                  child: RegisterForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
