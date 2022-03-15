import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/logic/web3/deets.dart';
import 'package:mondkapjesmelder/views/home/prototype.dart';
import 'users.dart';

class AdminPrototype extends StatefulWidget {
  const AdminPrototype({Key? key}) : super(key: key);

  @override
  _AdminPrototypeState createState() => _AdminPrototypeState();
}

class _AdminPrototypeState extends State<AdminPrototype> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminPrototypeHome(),
    );
  }
}

class AdminPrototypeHome extends StatefulWidget {
  const AdminPrototypeHome({Key? key}) : super(key: key);

  @override
  _AdminPrototypeHomeState createState() => _AdminPrototypeHomeState();
}

class _AdminPrototypeHomeState extends State<AdminPrototypeHome> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mondkapjesmelder Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrototypeHomeScreen()
                    ),
                  );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Row(
            children: [
              NavigationRail(
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text("Home"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text("Users"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text("Student Info"),
                    ),
                  ],
                  selectedIndex: _selectedIndex),
              Divider(
                height: 4.0,
              ),
              Expanded(
                child: adminWidgets[_selectedIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// List<Widget> getAdminWidgets {
//   return [
//     Home(),
//     Users(),
//   ];
// }

List adminWidgets = [
  Home(),
  Users(),
  Students(),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController studentId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: studentId,
                keyboardType: TextInputType.number,
              ),
              Divider(),
              CupertinoButton.filled(
                child: Text('Get reports'),
                onPressed: () async {
                  final report =
                      await dbInstance.getReports(BigInt.parse(studentId.text));
                  final userdata = await dbInstance
                      .getStudentInfo(BigInt.parse(studentId.text));
                  //final data = json.decode(report!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Reports(
                        reports: report,
                        name: '${userdata.firstName} ${userdata.lastName}',
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Reports extends StatelessWidget {
  const Reports({Key? key, required this.reports, required this.name})
      : super(key: key);

  final List reports;
  final name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(reports[index]),
            );
          },
          itemCount: reports.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }
}

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
TextEditingController _firstName = TextEditingController();
TextEditingController _lastName = TextEditingController();
TextEditingController _class = TextEditingController();
TextEditingController _studentId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text('Leerling nr.'),
          TextField(controller: _studentId,),
          Divider(),
          Text('Voornaam'),
          TextField(controller: _firstName,),
          Divider(),
          Text('Achternaam'),
          TextField(controller: _lastName,),
          Divider(),
          Text('Klas'),
          TextField(controller: _class,),
          Divider(),
          CupertinoButton.filled(child: Text('Student Toevoegen'), onPressed: () async {
            final result = await dbInstance.addStudent(BigInt.parse(_studentId.text), _firstName.text, _lastName.text, _class.text, credentials: credentials).whenComplete(() {final snackBar = SnackBar(
            content: const Text('Gelukt!'),
            
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
            );
            print(result);
          })
        ],
      ),
    );
  }
}
