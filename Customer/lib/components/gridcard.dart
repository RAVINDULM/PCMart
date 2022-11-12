import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/utils/theme.dart';

class GridCard extends StatelessWidget {
  final int index;
  final void Function() onPress;
  const GridCard({Key? key, required this.index, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index % 2 == 0
          ? EdgeInsets.only(left: 22)
          : EdgeInsets.only(right: 22),
      decoration: CustomTheme.GetcardDecoration(),
      child: GestureDetector(
        onTap: onPress,
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(35),
          child: Column(children: [
            Expanded(
              flex: 7,
              child: SizedBox(
              width: double.infinity,
              child: Image.network('https://picsum.photos/250?image=9'),
              )
              ),  
              Expanded(
              flex: 3,
              child: Center(
                child: Column(children: [
                  Padding(padding: EdgeInsets.symmetric(vertical:6),child: Text("title", style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  
                  ),
                  Text("Price", style: Theme.of(context).textTheme.headlineSmall,)
                ],
                ),
              )
              )
          ]),
          ),
      ),
    );
  }
}
