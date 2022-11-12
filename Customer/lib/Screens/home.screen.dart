import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/Auth/login.screen.dart';
import 'package:flutter_app/Screens/product.screen.dart';
import 'package:flutter_app/components/gridcard.dart';
import 'package:flutter_app/utils/theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final data = ["1", "2", "3", "4"];
  

  @override
  Widget build(BuildContext context) {
      onCardPress() {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Product()));
    }
final Stream<QuerySnapshot> products =
      FirebaseFirestore.instance.collection("Products").snapshots();
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: products,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading...");
          }
          final data = snapshot.requireData;
          return GridView.builder(
              itemCount: data.size,
              padding: const EdgeInsets.symmetric(vertical: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 30, crossAxisSpacing: 30),
              itemBuilder: ( context, index) {
                return Container(
      margin: index % 2 == 0
          ? EdgeInsets.only(left: 22)
          : EdgeInsets.only(right: 22),
      decoration: CustomTheme.GetcardDecoration(),
      child: GestureDetector(
        onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => Product(img: data.docs[index]['img'],title: data.docs[index]['name'], description:data.docs[index]['description'] , price:data.docs[index]['price'] , )));
    },
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(35),
          child: Column(children: [
            Expanded(
              flex: 4,
              child: SizedBox(
              width: double.infinity,
              child: Image.network(data.docs[index]['img']),
              )
              ),  
              Expanded(
              flex: 5,
              child: Center(
                child: Column(children: [
                  Padding(padding: EdgeInsets.symmetric(vertical:6),child: Text("${data.docs[index]['name']}", style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  
                  ),
                  Text("\$${data.docs[index]['price']}", style: Theme.of(context).textTheme.headlineSmall,)
                ],
                ),
              )
              )
          ]),
          ),
      ),
    );
              });
        },
      ),
    );
  }
}
