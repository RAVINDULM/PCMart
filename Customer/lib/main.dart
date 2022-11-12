// import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/Screens/orders.screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Auth/login.screen.dart';
import 'package:flutter_app/Screens/checkout.screen.dart';
import 'package:flutter_app/Screens/home.screen.dart';
import 'package:flutter_app/Screens/profile.screen.dart';
import 'package:flutter_app/utils/app_state.dart';
import 'package:flutter_app/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) =>
        Consumer<ApplicationState>(builder: (context, applicationState, _) {
      Widget child;
      switch (applicationState.loginState) {
        case ApplicationLogInState.loggedout:
          child = Login();
          break;
        case ApplicationLogInState.loggedin:
          child = MyApp();
          break;
        default:
          child = Login();
      }
      return MaterialApp(theme: CustomTheme.getTheme(), home: child);
    }),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("PCMart"),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                boxShadow: CustomTheme.cardShadow,
              ),
              child: const TabBar(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(icon: Icon(Icons.home)),
                    Tab(icon: Icon(Icons.person)),
                    Tab(icon: Icon(Icons.shopping_cart_checkout)),
                    Tab(icon: Icon(Icons.shopping_bag)),
                  ]),
            ),
            body: TabBarView(
                children: [const Home(), const Profile(), const Checkout(), const Orders()]),
          )
          );
  }
}
