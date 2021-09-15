import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_architecture/generated/locale_keys.g.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
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
            icon: Icon(
              Icons.outlined_flag,

            ),
            onPressed: () => _showCountryDialog(context),
          )
        ],
      ),
      body: ListView(
        children: [
          HomeItem(LocaleKeys.quiz_title.tr(), Icons.question_answer, () => {
            Navigator.pushNamed(context, Routes.quiz.path)
          }),
          HomeItem(LocaleKeys.counter_title.tr(), Icons.looks_one, () => {
            Navigator.pushNamed(context, Routes.counter.path, arguments: 6)
          }),
          HomeItem(LocaleKeys.movies_title.tr(), Icons.movie_creation_outlined, () => {
            Navigator.pushNamed(context, Routes.movieList.path)
          }),
          HomeItem("Auth Splash", Icons.verified_user, () => {
            Navigator.pushNamed(context, Routes.authSplash.path)
          })
        ],
      ),
    );
  }

  void _showCountryDialog(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text(LocaleKeys.home_popup_country_title).tr(),
        content: const Text(LocaleKeys.home_popup_country_content).tr(),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText('France'),
            onPressed: () {
              context.setLocale(const Locale('fr'));
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: PlatformText('English'),
            onPressed: () {
              context.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}