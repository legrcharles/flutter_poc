import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/home/widgets/home_item.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Home"),
        cupertino: (context, platform) {
          return CupertinoNavigationBarData(
            transitionBetweenRoutes: true,
            automaticallyImplyLeading: true,
            previousPageTitle: "Back"
          );
        },
        material: (context, platform) {
          return MaterialAppBarData();
        },
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
          HomeItem("Auth Splash", Icons.verified_user, () => {
            Navigator.pushNamed(context, Routes.authSplash.path)
          })
        ],
      ),
    );
  }

}