import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nfc_library/blocs/authentication_bloc/authentication_event.dart';
import 'package:nfc_library/blocs/register_bloc/register_bloc.dart';
import 'package:nfc_library/blocs/register_bloc/register_event.dart';
import 'package:nfc_library/blocs/register_bloc/register_state.dart';
import 'package:nfc_library/widgets/gradient_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String username,telNo,address,programme,role,email;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Register Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registering...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration( icon: Icon(Icons.person),
                      labelText: "Username",
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      username=value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration( icon: Icon(Icons.phone),
                      labelText: "Tel No.",
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      telNo=value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Telephone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration( icon: Icon(Icons.book),
                      labelText: "Programme",
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      programme=value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Programme';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration( icon: Icon(Icons.home),
                      labelText: "Address",
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      address=value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                    onChanged: (value) {
                    email=value;
                  },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Password",
                    ),
                    obscureText: true,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                    width: 150,
                    height: 45,
                    onPressed: () {
                      if (isButtonEnabled(state)) {
                        _onFormSubmitted();
                        role="Student";
                        userSetup(email, username, telNo, address, programme, role);
                      }
                    },
                    text: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(RegisterSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }
  Future<void> userSetup(String email,String username, String telNo, String address, String programme, String role ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    users.doc(email).set({'email': email, 'admin': role, 'username':username, 'tel_no': telNo, 'programme': programme, 'address':address});
    return;
  }

}
