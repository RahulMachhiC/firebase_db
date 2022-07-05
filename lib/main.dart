import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:immence/screens/loginscreen.dart';
import 'package:immence/screens/pages.dart';

final storage = GetStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    // checkuser();
    super.initState();
  }

  String checkname = storage.read("name") ?? "";

  // Future<String> checkuser() async {
  //   checkname = await storage.read("name");
  //   return checkname;
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkname == "" ? LoginScreen() : PagesWidget(),
    );
  }
}
