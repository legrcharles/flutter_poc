import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final _dataManager = Provider.of<DataManager>(context);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("User List"),
        automaticallyImplyLeading: true,
          cupertino: (context, platform) {
            return CupertinoNavigationBarData(
                transitionBetweenRoutes: true,
                automaticallyImplyLeading: true,
                previousPageTitle: "Counter"
            );
          },
        trailingActions: <Widget>[
          TextButton(
            child: PlatformText("Log out",
                style: const TextStyle(color: Colors.white)),
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