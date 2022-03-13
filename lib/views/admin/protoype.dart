import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/views/admin/settings.dart';

import 'analytics.dart';
import 'home.dart';
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
        actions: [IconButton(onPressed: () {FirebaseAuth.instance.signOut();}, icon: Icon(Icons.logout))],
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
                      icon: Icon(Icons.stacked_line_chart),
                      label: Text("Analytics"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text("Users"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text("Settings"),
                    ),
                  
                  ],
                  selectedIndex: _selectedIndex),
              Divider(
                height: 4.0,
              ),
              getAdminWidgets()[_selectedIndex],
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> getAdminWidgets() {
  return [
    Home(),
    Analytics(),
    Users(),
    Settings(),
  ];
}