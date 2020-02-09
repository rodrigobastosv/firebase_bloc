import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc/ui/signin/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupBloc bloc;
  GlobalKey<FormState> formKey;
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userRef = Firestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    bloc = SignupBloc();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<SignupBloc, SignupState>(
          bloc: bloc,
          builder: (_, state) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      controller: email,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      controller: senha,
                    ),
                    SizedBox(height: 12),
                    RaisedButton(
                      child: Text('Signup'),
                      onPressed: () async {
                        final authResult =
                            await _auth.createUserWithEmailAndPassword(
                                email: email.text, password: senha.text);
                        await userRef.document(authResult.user.uid).setData({
                          'uid': authResult.user.uid,
                          'email': authResult.user.email,
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    RaisedButton(
                      child: Text('Signin'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => SigninPage()),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
