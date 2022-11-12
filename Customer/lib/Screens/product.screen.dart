import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Screens/checkout.screen.dart';
import 'package:flutter_app/components/customButton.dart';
import 'package:flutter_app/utils/app_state.dart';
import 'package:flutter_app/utils/theme.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  final String title;
  final String img;
  final double price;
  final String description;
  const Product(
      {Key? key,
      required this.img,
      required this.title,
      required this.description,
      required this.price})
      : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool addButtonLoad = false;

  void onAddToCart() async {
    setState(() {
      addButtonLoad = true;
    });
    setState(() {
      addButtonLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference cart = FirebaseFirestore.instance.collection("cart");
    CollectionReference userData = FirebaseFirestore.instance.collection("userData");
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Image.network(
                        '${widget.img}',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    Positioned(
                        top: 35,
                        right: 35,
                        child: Container(
                          decoration: ShapeDecoration(
                              color: CustomTheme.blue,
                              shape: CircleBorder(),
                              shadows: [
                                BoxShadow(
                                    color: CustomTheme.grey,
                                    blurRadius: 15,
                                    offset: Offset(1, 3))
                              ]),
                          child: IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            color: Colors.black,
                            onPressed: () { 
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout()));},
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.headlineLarge!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(widget.title),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Text("MRP: "),
                              Text("\$ ${widget.price}")
                            ],
                          ),
                        ),
                        CustomButton(
                          text: "Add to Cart",
                          onPress: () {
                            ApplicationState applicationState = Provider.of<ApplicationState>(context,listen: false);
                            String uid = applicationState.GetCurrentUserID();
                            print("here is the uid  $uid");
                            userData.doc(uid).collection("cart").add({
                                  "img": widget.img,
                                  "name": widget.title,
                                  "unitprice": widget.price,
                                  "total": widget.price,
                                })
                                .then((value) => print("cart updated"))
                                .catchError(
                                    (error) => print("Failed to add: $error"));
                          },
                          loading: addButtonLoad,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "About the product",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            widget.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 35,
              left: 30,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: CustomTheme.grey,
                          blurRadius: 3,
                          offset: Offset(1, 3))
                    ]),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              )),
        ],
      )),
    );
  }
}
