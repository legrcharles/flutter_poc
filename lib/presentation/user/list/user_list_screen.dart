import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final _dataManager = Provider.of<DataManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text("Log out",
                style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await _dataManager.signOut();
              Navigator.of(context).popUntil(ModalRoute.withName(Routes.home.path));

            }
          ),
        ]
      ),
    );
  }

}