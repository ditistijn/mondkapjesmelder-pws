import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/logic/login/usertypes.dart';
import 'package:mondkapjesmelder/logic/web3/deets.dart';
import 'package:mondkapjesmelder/views/admin/protoype.dart';
import 'package:mondkapjesmelder/views/home/prototype.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _privatekeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: FutureBuilder<Object>(
                future: getCredentials(),
                builder: (context, snapshot) {
                  if (snapshot.data == 'Yes') {
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CupertinoTextField(
                                  controller: _privatekeyController,
                                  placeholder: 'Private Key',
                                ),
                                Divider(),
                                CupertinoButton.filled(
                                    child: Text('Login'),
                                    onPressed: () async {
                                      final privateKey =
                                          _privatekeyController.text;
                                          
                                      final prefs = await SharedPreferences.getInstance();

                                      setState(() {
                                        prefs.setString('privKey', privateKey);
                                        credentials =
                                          EthPrivateKey.fromHex(privateKey);
                                      });
                                      
                                      var publicKey = credentials.address;

                                      var snackBar = await SnackBar(
                                        content:
                                            Text('Signed in with $publicKey'),
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           PrototypeMain()),
                                      // );
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
                })),
      ),
    );
  }
}

Future<String> signIn(String _email, String _password) async {
  return 'signed in';
}
