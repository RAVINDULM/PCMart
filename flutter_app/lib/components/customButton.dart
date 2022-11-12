import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/components/loader.dart';
import 'package:flutter_app/utils/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  final bool loading;

  const CustomButton(
      {Key? key,
      required this.text,
      this.loading = false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CustomTheme.blue,
        boxShadow: CustomTheme.buttonShadow
      ),
      child: MaterialButton(
        onPressed: loading? null : onPress,
        child: loading ? CustomLoader() : Text(text,style: Theme.of(context).textTheme.titleSmall,),
        
        ),
    );
  }
}
