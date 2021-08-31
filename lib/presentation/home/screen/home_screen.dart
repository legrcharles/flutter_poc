import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends HookWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, Routes.quiz.path)
            },
            child: Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.question_answer, color: Colors.red),
                title: Text(
                    "Quiz"
                , style: GoogleFonts.aleo(fontStyle: FontStyle.normal, color: Colors.grey[500])),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, Routes.counter.path, arguments: 12)
            },
            child: Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.looks_one, color: Colors.red),
                title: Text(
                    "Counter"
                    , style: GoogleFonts.aleo(fontStyle: FontStyle.normal, color: Colors.grey[500])),
              ),
            ),
          )
        ],
      ),
    );
  }

}