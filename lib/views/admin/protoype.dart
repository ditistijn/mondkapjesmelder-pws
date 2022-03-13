import 'package:flutter/material.dart';
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
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
    Users(),
  ];
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}