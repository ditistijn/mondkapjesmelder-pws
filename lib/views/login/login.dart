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
          child:Container(
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
                                        'shank'),
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
              )
           
          ),
       
    ),);
  }
}

Future<String> signIn(String _email, String _password) async {
  return 'signed in';
}
