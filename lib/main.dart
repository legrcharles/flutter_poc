import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/app_route.dart';
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
      child: MaterialApp(
        title: 'Flutter Quiz',
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blueGrey,
              primaryColorDark: Colors.indigo,
              accentColor: Colors.redAccent),
        )
      ),
    );
  }
}
