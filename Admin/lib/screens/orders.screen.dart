import 'package:adminpcmart/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
 @override
  Widget build(BuildContext context) {
    CollectionReference userData =
        FirebaseFirestore.instance.collection("userData");
    final Stream<QuerySnapshot> cart = FirebaseFirestore.instance
    .collection("userData")
        .doc("zXBBDbrOpsQrkJM4ldfrEUY90KI2")
        .collection("orders")
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
              print(data.docs[1].id);
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
                                  flex: 5,
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
                                  TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 50, 66, 79)),
    // backgroundColor: ,
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (data.docs[index]['status']=="Pending")
          return Colors.yellow.withOpacity(0.54);
        if (data.docs[index]['status']=="Shipped")
          return Colors.blue.withOpacity(0.42);
        if(data.docs[index]['status']=="Completed")
          return Colors.green.withOpacity(0.42);
        return null; // Defer to the widget's default.
      },
    ),
  ),
  onPressed: () { },
  child:
   Text(data.docs[index]['status'])
)

                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child:(data.docs[index]['status']=="Pending") ? 
                                 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 50, 66, 79)),
    // backgroundColor: ,
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
          return Color.fromARGB(255, 11, 123, 41).withOpacity(0.54);
         // Defer to the widget's default.
      },
    ),
  ),
  onPressed: () {
        FirebaseFirestore.instance.collection("userData").doc("zXBBDbrOpsQrkJM4ldfrEUY90KI2")
            .collection('orders')
            .doc(data.docs[index].id)
            .update({
              "status":"Shipped"
            }).then((result){
              print("order shipped");
            }).catchError((onError){
             print(onError);
                   });
                              },
                              child:
                               Text("Ship Now")
                              )

                                  ],
                                )
                                
                                : 
                                
                                (data.docs[index]['status']=="Completed") ? Text(" ")
                                
                                :
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 50, 66, 79)),
    // backgroundColor: ,
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
          return Color.fromARGB(255, 133, 134, 225).withOpacity(0.54);
          // Defer to the widget's default.
      },
    ),
  ),
  onPressed: () {
        FirebaseFirestore.instance.collection("userData").doc("zXBBDbrOpsQrkJM4ldfrEUY90KI2")
            .collection('orders')
            .doc(data.docs[index].id)
            .update({
              "status":"Completed"
            }).then((result){
              print("order completed");
            }).catchError((onError){
             print("onError");
            });
   },
  child:
   Text("Mark as Completed")
)

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
      ]),
    );
  }
}

