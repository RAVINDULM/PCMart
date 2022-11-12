import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/utils/theme.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 123,
    margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
    decoration: CustomTheme.GetcardDecoration(),
    child: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
              height: double.infinity,
              child:Image.network('https://picsum.photos/250?image=9'),
              )),
            Expanded(
              flex: 6,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text("title", style: Theme.of(context).textTheme.headlineSmall,),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text("Qty : 1", style: Theme.of(context).textTheme.bodySmall,),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text("\$ Price", style: Theme.of(context).textTheme.headlineSmall,),
                    ),
                  ],
                ),
                )),
                Expanded(child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
          icon: const Icon(Icons.close_sharp,size: 40,),
          onPressed: () { },
        ),
                  ],
                ),           
                ),
          ],
        ),
      ),
    ),);
  }
}
