import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc/repository/firebase_congress_repository.dart';
import 'package:firebase_bloc/ui/bloc/bloc.dart';
import 'package:firebase_bloc/ui/congress/congress_list_page.dart';
import 'package:firebase_bloc/ui/signup/signup_page.dart';
import 'package:firebase_bloc/ui/user_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/signin_bloc.dart';
import 'bloc/signin_state.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  SigninBloc bloc;
  GlobalKey<FormState> formKey;
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userRef = Firestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    bloc = SigninBloc();
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
        child: BlocBuilder<SigninBloc, SigninState>(
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
                      child: Text('Login'),
                      onPressed: () async {
                        final authResult =
                            await _auth.signInWithEmailAndPassword(
                                email: email.text, password: senha.text);
                        final userData =
                            await userRef.document(authResult.user.uid).get();
                        print('@@@@@@@@@@@@');
                        print(userData.data);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider<UserBloc>(
                              create: (_) => UserBloc(userData.data),
                              child: BlocProvider(
                                create: (_) =>
                                    CongressBloc(FirebaseCongressRepository())
                                      ..add(CongressFetch()),
                                child: CongressListPage(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    RaisedButton(
                      child: Text('Signup'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => SignupPage()),
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
