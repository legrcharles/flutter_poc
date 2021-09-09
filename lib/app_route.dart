import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/authsplash/authsplash.dart';
import 'package:flutter_architecture/presentation/counter/counter.dart';
import 'package:flutter_architecture/presentation/home/home_screen.dart';
import 'package:flutter_architecture/presentation/movie/list/movie_list_screen.dart';
import 'package:flutter_architecture/presentation/quiz/question/quiz_question_screen.dart';
import 'package:flutter_architecture/presentation/register/register_screen.dart';
import 'package:flutter_architecture/presentation/signin/signin.dart';
import 'package:flutter_architecture/presentation/user/list/user_list_screen.dart';

enum Routes {
  home,
  quiz,
  counter,
  movieList,
  authSplash,
  register,
  signin,
  userList
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

      case Routes.authSplash:
        return "/authSplash";

      case Routes.register:
        return "/register";

      case Routes.signin:
        return "/signin";

      case Routes.userList:
        return "/userList";
    }
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final route = Routes.values.firstWhereOrNull((e) => e.path == settings.name);

    if (route != null) {
      switch (route) {
        case Routes.home :
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => HomeScreen());

        case Routes.quiz:
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => QuizQuestionScreen());

        case Routes.counter:
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => CounterPage());

        case Routes.movieList:
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => MovieListScreen());

        case Routes.authSplash:
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => AuthSplashPage());

        case Routes.register:
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => RegisterScreen());

        case Routes.signin:
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => SignInPage());

        case Routes.userList:
          return CupertinoPageRoute(
              settings: RouteSettings(name: route.path),
              builder: (context) => UserListScreen());

        default:
          return _buildFailPage();
      }
    } else {
      return _buildFailPage();
    }
  }

  static MaterialPageRoute _buildFailPage() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(title: Text("Error"), centerTitle: true),
            body: Center(
              child: Text("Page not found"),
            )
        )
    );
  }
}

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