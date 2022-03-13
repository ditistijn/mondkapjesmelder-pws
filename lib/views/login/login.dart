import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/logic/login/usertypes.dart';
import 'package:mondkapjesmelder/views/admin/protoype.dart';
import 'package:mondkapjesmelder/views/home/prototype.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PrototypeMain();
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welkom bij de Mondkapjesmelder!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CupertinoTextField(
                              controller: _usernameController,
                              placeholder: 'Gebruikersnaam',
                            ),
                            Divider(),
                            CupertinoTextField(
                              controller: _passwordController,
                              placeholder: 'Wachtwoord',
                              obscureText: true,
                            ),
                            Divider(),
                            CupertinoButton.filled(
                                child: Text('Login'),
                                onPressed: () async {
                                  final username = _usernameController.text;
                                  final password = _passwordController.text;

                                  var snackBar = await SnackBar(
                                    content: Text(
                                        '${await sendLoginData(username, password)}'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future sendLoginData(String _username, String _password) {
  final email = _username +
      '@mondkapjesmelder.nl'; // should be done using just username but firebase does not support username sign-ins yet -> https://stackoverflow.com/questions/35120939/username-authentication-instead-of-email
  final password = _password;

  return signIn(email, password);
}

Future<String> signIn(String _email, String _password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password);

    return 'Ingelogd';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'Gebruiker niet gevonden.';
    } else if (e.code == 'wrong-password') {
      return 'Onjuist wachtwoord.';
    } else {
      return 'Fail: ${e.message}';
    }
  }
}
