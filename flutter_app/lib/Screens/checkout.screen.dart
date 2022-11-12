import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/components/customButton.dart';
import 'package:flutter_app/components/listCard.dart';
import 'package:flutter_app/utils/app_state.dart';
import 'package:flutter_app/utils/theme.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  static double totalPrice = 0;
  static var cartdetails;

  @override
  Widget build(BuildContext context) {
    CollectionReference userData =
        FirebaseFirestore.instance.collection("userData");
    ApplicationState applicationState =
        Provider.of<ApplicationState>(context, listen: false);
    String uid = applicationState.GetCurrentUserID();
    final Stream<QuerySnapshot> cart = FirebaseFirestore.instance
        .collection("userData")
        .doc(uid)
        .collection("cart")
        .snapshots();

    return SingleChildScrollView(
      child: Column(children: [
        StreamBuilder<QuerySnapshot>(
            stream: cart,
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
              //calculate the total price
              double total = 0;
              for (var i = 0; i < data.docs.length; i++) {
                total += data.docs[i]['unitprice'];
              }
              totalPrice = total;
              cartdetails = data.docs;

              // print(data.docs[1].id);
              // print("total price $total");
              // print(data.docs[1]['name']);
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 30),
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 123,
                      margin: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      decoration: CustomTheme.GetcardDecoration(),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: double.infinity,
                                    child:
                                        Image.network(data.docs[index]['img']),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            data.docs[index]['name'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            "Qty : 1",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            "\$ ${data.docs[index]['unitprice']}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close_sharp,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("userData")
                                            .doc(uid)
                                            .collection("cart")
                                            .doc(data.docs[index].id)
                                            .delete()
                                            .then((value) =>
                                                print("cart deleted"))
                                            .catchError((error) => print(
                                                "Failed to delete: $error"));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 2,
                color: CustomTheme.grey,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      "Total: ",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      "\$  $totalPrice",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: CustomButton(
              text: "Checkout",
              onPress: () {
                // get data
                print(cartdetails.length);

                for (var i = 0; i < cartdetails.length; i++) {
                  print(cartdetails[i].id);
                  userData
                      .doc(uid)
                      .collection("orders")
                      .add({
                        "img": cartdetails[i]['img'],
                        "name": cartdetails[i]['name'],
                        "unitprice": cartdetails[i]['unitprice'],
                        "status":"Pending"
                      })
                      .then((value) => print("order plced"))
                      .catchError((error) => print("Failed to add: $error"));

                  FirebaseFirestore.instance
                      .collection("userData")
                      .doc(uid)
                      .collection("cart")
                      .doc(cartdetails[i].id)
                      .delete()
                      .then((value) => print("cart deleted"))
                      .catchError((error) => print("Failed to delete: $error"));
                      
                }
              },
              loading: false,
            ))
      ]),
    );
  }
}


// priceFooter (){
//   return Padding(
    
//     padding: EdgeInsets.symmetric(horizontal: 30),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(
//           height: 2,
//           color: CustomTheme.grey,
//           thickness: 2,
//         ),
//         Padding(padding: const EdgeInsets.only(top: 20),
//         child: Row(
//           children: [
//             Text("Total: ", style: Theme.of(context).textTheme.headlineSmall,),
//             const Spacer(),
//             Text("\$ Price: ", style: Theme.of(context).textTheme.headlineSmall,)
//           ],
//         ),)
//       ],
//     ),
//   );
// }
