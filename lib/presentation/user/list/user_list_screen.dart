import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';

class UserListScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final _dataManager = ref.read(dataManager);

    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text("Log out",
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