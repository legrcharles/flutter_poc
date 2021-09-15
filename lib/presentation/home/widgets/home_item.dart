import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';

class HomeItem extends StatelessWidget {

  final String _name;
  final IconData _icon;
  final VoidCallback _onTap;

  const HomeItem(this._name, this._icon, this._onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Card(
        color: AppColor.backgroundLight1,
        elevation: Platform.isIOS ? 0 : 2,
        child: ListTile(
          leading: Icon(_icon, color: Theme.of(context).colorScheme.secondary),
          title: Text(_name, style: TextStyle(color: AppColor.text))
        ),
      ),
    );
  }
}