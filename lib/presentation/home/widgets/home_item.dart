import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeItem extends StatelessWidget {

  final String _name;
  final IconData _icon;
  final VoidCallback _onTap;

  HomeItem(this._name, this._icon, this._onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
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