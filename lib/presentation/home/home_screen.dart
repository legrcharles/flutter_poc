import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/presentation/home/widgets/home_item.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: [
          HomeItem("Quiz", Icons.question_answer, () => {
            Navigator.pushNamed(context, Routes.quiz.path)
          }),
          HomeItem("Counter", Icons.looks_one, () => {
            Navigator.pushNamed(context, Routes.counter.path, arguments: 6)
          }),
          HomeItem("Movie List", Icons.movie_creation_outlined, () => {
            Navigator.pushNamed(context, Routes.movieList.path)
          }),
          HomeItem("Form", Icons.dynamic_form, () => {
            Navigator.pushNamed(context, Routes.form.path)
          }),
          HomeItem("Auth Splash", Icons.verified_user, () => {
            Navigator.pushNamed(context, Routes.authSplash.path)
          })
        ],
      ),
    );
  }

}