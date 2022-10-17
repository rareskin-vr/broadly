
import 'package:broadly/helper/image.dart';
import 'package:broadly/helper/redirect.dart';
import 'package:broadly/ui/homepage.dart';
import 'package:broadly/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var logged = prefs.getBool('logged');
  runApp(MyApp(logged: logged??false));
}

class MyApp extends StatelessWidget {
  final bool logged;
  const MyApp({Key? key, required this.logged}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: ImageAccess(context))
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Broadly',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: logged==true?const  Redirect():const Login()
      ),
    );
  }
}
