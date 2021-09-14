import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/home/home_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final _appModule = AppModule();
  
  @override
  void dispose() {
    _appModule.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _appModule.dataManager,
      child: Theme(
          data: materialThemeData,
          child: PlatformProvider(
            settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
            builder: (context) => PlatformApp(
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings, context),
              initialRoute: '/',
              debugShowCheckedModeBanner: false,
              title: 'Flutter Platform Widgets',
              material: (_, __) => MaterialAppData(
                theme: materialThemeData,
              ),
              cupertino: (_, __) => CupertinoAppData(
                theme: cupertinoTheme,
              ),
            ),
          )
      )
    );
  }
}

/*
MaterialApp(
title: 'Flutter Quiz',
initialRoute: '/',
onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
debugShowCheckedModeBanner: false,
/*
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blueGrey,
              primaryColorDark: Colors.indigo,
              accentColor: Colors.redAccent),
        )

         */
),
*/
