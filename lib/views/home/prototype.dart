import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mondkapjesmelder/logic/admin/greeting.dart';
import 'package:mondkapjesmelder/logic/login/usertypes.dart';
import 'package:mondkapjesmelder/logic/web3/deets.dart';
import 'package:mondkapjesmelder/views/admin/protoype.dart';
import 'package:web3dart/web3dart.dart';

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

  var firstName;
  var lastName;

  @override
  void initState() {
    _textController = TextEditingController(text: "");

    setState(() {});
    super.initState();
  }

  ///final students = [];

  Widget build(BuildContext context) {
    Future reportStudent(int _studentId) async {
      BigInt bigStudentId = BigInt.from(_studentId);
      var dateTime = DateTime.now().toString();
      var report = await dbInstance.reportStudent(bigStudentId, dateTime,
          credentials: credentials);

      setState(() {
        reportedCount++;
      });

      return report;
    }

    void addStudent(int studentId, String firstName, String lastName) {
      //implement addStudent
    }

    void setStudentDetails(
        _reportedCount, _studentClass, _firstName, _lastName) {
      reportedCount = _reportedCount;
      studentClass = _studentClass;
      //studentId = _studentId;
      firstName = _firstName;
      lastName = _lastName;
      //imageUri = 'https://api.ipfsbrowser.com/ipfs/download.php?hash=' + _profilePic;
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
                    '${greetingMessage()}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '', //implement wallet address
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getUserType(),
              initialData: true,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    
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
                  
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error.toString()}');
                }
                return Container();
              },
            ),
            ListTile(
              title: Text('Over deze app'),
              leading: Icon(Icons.info),
              onTap: () {
                showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Gemaakt door de beste developers Ruben en Tijn'),
                              
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
                          //implement signOut
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
        title: Text(firstName != null
            ? '$firstName $lastName melden'
            : 'Mondkapjesmelder'),
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
                      const Text("Lln. number"),
                      Container(
                        height: 8,
                      ),
                      CupertinoTextField(
                        controller: _textController,
                        onEditingComplete: () async {
                          var studentInfo = await dbInstance.getStudentInfo(
                              BigInt.parse(_textController.text));
                          int timesReported = studentInfo.timesReported.toInt();
                          setState(() {
                            setStudentDetails(
                                timesReported,
                                studentInfo.classId,
                                studentInfo.firstName,
                                studentInfo.lastName);
                          });
                        },
                        keyboardType: TextInputType.number,
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
                      if (_textController.text == '') {
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
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          SimpleDialog(
                                            children: [
                                              CircularProgressIndicator()
                                            ],
                                          ));
                                  await reportStudent(
                                          int.parse(_textController.text))
                                      .whenComplete(() {
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
                                              setState(() {
                                                credentials =
                                                    EthPrivateKey.fromHex("");
                                              });
                                              Navigator.pop(context);
                                              // Do something destructive.
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).catchError((e) {
                                    showCupertinoDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CupertinoAlertDialog(
                                              title: Text('$e'),
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
                                            ));
                                  });
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
