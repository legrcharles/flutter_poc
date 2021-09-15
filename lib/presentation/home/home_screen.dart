import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_architecture/generated/locale_keys.g.dart';
import 'package:flutter_architecture/presentation/home/widgets/home_item.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text(LocaleKeys.home_title).tr(),
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
        trailingActions: [
          PlatformIconButton(
            padding: const EdgeInsets.all(4.0),
            icon: const Icon(
              Icons.outlined_flag,
            ),
            onPressed: () {
              context.setLocale(context.locale == const Locale('fr') ? const Locale('en') : const Locale('fr'));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          HomeItem(LocaleKeys.home_items_quiz.tr(), Icons.question_answer, () => {
            Navigator.pushNamed(context, Routes.quiz.path)
          }),
          HomeItem(LocaleKeys.home_items_counter.tr(), Icons.looks_one, () => {
            Navigator.pushNamed(context, Routes.counter.path, arguments: 6)
          }),
          HomeItem(LocaleKeys.home_items_movies.tr(), Icons.movie_creation_outlined, () => {
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