import 'package:adminpcmart/firebase_options.dart';
import 'package:adminpcmart/screens/addproducts.screen.dart';
import 'package:adminpcmart/screens/orders.screen.dart';
import 'package:adminpcmart/screens/products.screen.dart';
import 'package:adminpcmart/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.shopping_bag)),
                Tab(icon: Icon(Icons.add_business_outlined)),
                Tab(icon: Icon(Icons.shopping_cart)),
              ],
            ),
            title: const Text('Admin PCMart'),
          ),
          body: const TabBarView(
            children: [
              Orders(),
              AddProducts(),
              Products()
            ],
          ),
        ),
      ),
    );
  }
}
