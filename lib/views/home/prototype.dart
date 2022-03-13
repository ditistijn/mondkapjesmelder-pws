import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mondkapjesmelder/logic/admin/greeting.dart';
import 'package:mondkapjesmelder/logic/login/usertypes.dart';
import 'package:mondkapjesmelder/views/admin/protoype.dart';

import 'package:mondkapjesmelder/firebase_options.dart';

import '../../logic/home/backend.dart';

class PrototypeMain extends StatefulWidget {
  const PrototypeMain({Key? key}) : super(key: key);

  @override
  _PrototypeMainState createState() => _PrototypeMainState();
}

class _PrototypeMainState extends State<PrototypeMain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(fontFamily: '--apple-system'),
      home: PrototypeHomeScreen(),
    );
  }
}

class PrototypeHomeScreen extends StatefulWidget {
  const PrototypeHomeScreen({Key? key}) : super(key: key);

  @override
  _PrototypeHomeScreenState createState() => _PrototypeHomeScreenState();
}

class _PrototypeHomeScreenState extends State<PrototypeHomeScreen> {
  late TextEditingController _textController;
  var imageUri = '';
  var reportedCount = 0;
  var studentClass = '';
  var studentId = '';
  var user = FirebaseAuth.instance.currentUser;
  var uid = getUser();

  @override
  void initState() {
    _textController = TextEditingController(text: "");

    setState(() {});
    super.initState();
  }

  final students = FirebaseFirestore.instance.collection('students');

  Widget build(BuildContext context) {
    void reportStudent(int studentId) async {
      var studentRef =
          FirebaseFirestore.instance.collection('students').doc('$studentId');
      studentRef.update({"reportedCount": FieldValue.increment(1)});

      students
          .doc('$studentId')
          .collection('reports')
          .doc('${DateTime.now()}')
          .set({"dateTime": DateTime.now(), "reportedBy": "skanker"})
          .then((value) => print("Student Reported"))
          .catchError((error) => print("Failed to add user: $error"));

      setState(() {
        reportedCount++;
      });
    }

    void addStudent(int studentId, String firstName, String lastName) {
      students
          .doc('$studentId')
          .set({
            "firstName": firstName,
            "lastName": lastName,
            "reportedCount": 0,
          })
          .then((value) => print("Student Reported"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    void setStudentProfilePicture(suggestion) async {
      setState(() {
        imageUri = suggestion['profilePicture'];
      });
    }

    void setStudentDetails(suggestion) {
      reportedCount = suggestion['reportedCount'];
      studentClass = '${suggestion['class']}';
      studentId = '${suggestion['studentId']}';
      setStudentProfilePicture(suggestion);
    }

    void setTextField(String data) {
      setState(() {
        _textController.text = '$data';
      });
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${greetingMessage()},',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${FirebaseAuth.instance.currentUser!.email!.substring(0, FirebaseAuth.instance.currentUser!.email!.length - 20)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ) //verwijder de laatste 20 characters- @mondkapjesmelder.nl om de username te krijgen
                ],
              ),
            ),
            FutureBuilder(
              future: getUserType(),
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data == 'admin') {
                      return ListTile(
                        title: Text('Admin omgeving'),
                        leading: Icon(Icons.admin_panel_settings),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPrototype()),
                          );
                        },
                      );
                    }
                  }
                } else if (snapshot.hasError) {
                  return Text('no data');
                }
                return Container();
              },
            ),
            ListTile(
              title: Text('Over deze app'),
              leading: Icon(Icons.info),
              onTap: () {},
            ),
            ListTile(
              title: Text('Mijn Meldingen'),
              leading: Icon(Icons.assignment),
              onTap: () {},
            ),
            ListTile(
              title: Text('Uitloggen'),
              leading: Icon(Icons.logout),
              onTap: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: Text('Weet je zeker dat je wilt uitloggen?'),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        child: const Text('Bevestigen'),
                        onPressed: () async {
                          FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Uitgelogd'),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text('OK'),
                                  isDestructiveAction: false,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Do something destructive.
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Mondkapjes Melder"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text("Naam of lln. number"),
                      Container(
                        height: 8,
                      ),
                      CupertinoTypeAheadField(
                        textFieldConfiguration: CupertinoTextFieldConfiguration(
                            controller: _textController),
                        suggestionsCallback: (pattern) async {
                          return await SearchService().getStudents(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          final student = suggestion!;
                          final firstName =
                              (student as Map<String, dynamic>)['firstName'];
                          final lastName = (student)['lastName'];
                          final studentClass = student['class'];
                          return Material(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text('$firstName $lastName'),
                              subtitle: Text(studentClass),
                            ),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          final student = suggestion!;
                          final firstName =
                              (student as Map<String, dynamic>)['firstName'];
                          final lastName = (student)['lastName'];

                          //load user info (image class reportedCount)
                          setState(() {
                            setStudentDetails(suggestion);
                            setTextField('$firstName $lastName');
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Center(
                            child: Image.network(
                              imageUri,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Icon(Icons.person);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Aantal keer gemeld:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("$reportedCount")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Klas:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("$studentClass")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  CupertinoButton.filled(
                    child: const Text("Melding Indienen"),
                    onPressed: () {
                      if (studentId == '') {
                        showCupertinoDialog<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title:
                                const Text('Ongeldig leerlingnummer ingevuld'),
                            actions: <CupertinoDialogAction>[
                              CupertinoDialogAction(
                                child: const Text('OK'),
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Do something destructive.
                                },
                              )
                            ],
                          ),
                        );
                      } else {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: Text(
                                'Melding indienen voor ${_textController.text}?'),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                child: const Text('Bevestigen'),
                                onPressed: () async {
                                  reportStudent(int.parse(studentId));
                                  Navigator.pop(context);
                                  showCupertinoDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                      title: const Text(
                                          'Bedankt voor het melden!'),
                                      actions: <CupertinoDialogAction>[
                                        CupertinoDialogAction(
                                          child: const Text('OK'),
                                          isDestructiveAction: false,
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // Do something destructive.
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
