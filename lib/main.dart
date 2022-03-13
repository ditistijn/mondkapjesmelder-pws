import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/views/login/login.dart';
// Import the generated file


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        //https://github.com/flutter/flutter/issues/93140
        fontFamily: 'SF'
      ),
    ),
  );
}
