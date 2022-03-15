import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/views/admin/protoype.dart';

import '../../logic/web3/deets.dart';

class Users extends StatefulWidget {
  const Users({ Key? key }) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  var address;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: address,
              ),
              Divider(),
              CupertinoButton.filled(
                child: Text('Set admin'),
                onPressed: () async {
                  dbInstance.setAdmin(address.text, credentials: credentials);
                },
              )
            ],
          ),],),
    );
  }
}