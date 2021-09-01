import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/counter/screen/counter_screen.dart';
import 'package:flutter_architecture/presentation/home/screen/home_screen.dart';
import 'package:flutter_architecture/presentation/movie/list/screen/movie_list_screen.dart';
import 'package:flutter_architecture/presentation/quiz/screen/quiz_screen.dart';
import 'package:collection/collection.dart';

enum Routes {
  home,
  quiz,
  counter,
  movieList
}

extension RoutesExtension on Routes {
  String get path {
    switch(this) {
      case Routes.home:
        return "/";

      case Routes.quiz:
        return "/quiz";

      case Routes.counter:
        return "/counter";

      case Routes.movieList:
        return "/movies";
    }
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final route = Routes.values.firstWhereOrNull((e) => e.path == settings.name);

    switch(route) {
      case Routes.home :
        return CupertinoPageRoute(builder: (context) => HomeScreen());

      case Routes.quiz:
        return CupertinoPageRoute(builder: (context) => QuizScreen());

      case Routes.counter:
        return CupertinoPageRoute(builder: (context) => CounterScreen(title: "My Counter", initialValue: int.parse(settings.arguments.toString())));

      case Routes.movieList:
        return CupertinoPageRoute(builder: (context) => MovieListScreen());
        /*
      case Routes.quiz:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => QuizScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(curve: Curves.ease, parent: animation);
              return FadeTransition(
                opacity:animation,
                child: child,
              );
            }
        );
*/
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(title:Text("Error"), centerTitle: true),
                body: Center(
                  child: Text("Page not found"),
                )
            )
        );
    }
  }
}