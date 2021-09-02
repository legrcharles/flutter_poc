import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/presentation/home/widgets/home_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: [
          HomeItem(Routes.quiz, "Quiz", Icons.question_answer),
          HomeItem(Routes.counter, "Counter", Icons.looks_one),
          HomeItem(Routes.movieList, "Movie List", Icons.movie_creation_outlined)
        ],
      ),
    );
  }

}