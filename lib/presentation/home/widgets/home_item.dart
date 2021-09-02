import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeItem extends StatelessWidget {

  final Routes _routes;
  final String _name;
  final IconData _icon;

  HomeItem(this._routes, this._name, this._icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.pushNamed(context, _routes.path)},
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Icon(_icon, color: Colors.red),
          title: Text(_name,
              style: GoogleFonts.aleo(fontStyle: FontStyle.normal, color: Colors.grey[500])
          ),
        ),
      ),
    );
  }
}