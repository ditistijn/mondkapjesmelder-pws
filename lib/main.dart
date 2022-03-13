import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/views/admin/home.dart';
import 'package:mondkapjesmelder/views/login/login.dart';
import 'views/home/prototype.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('firebase initialized');
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
