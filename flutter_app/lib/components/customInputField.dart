import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/utils/theme.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final IconData icon;
  final TextEditingController textEditingController;
  final bool password;

  const CustomInputField(
      {Key? key,
      required this.label,
      required this.placeholder,
      required this.icon,
      this.password = false, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 8),
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: 56,
            child: TextField(
              controller: textEditingController,
              obscureText:password,
              enableSuggestions: !password,
              autocorrect: !password,
              decoration: InputDecoration(
                prefixIcon: Padding(padding:const EdgeInsetsDirectional.only(start: 22, end: 20),
                child: Icon(icon, color: Colors.black, size: 24,),),
                border: const OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 1, color: Colors.black)
                ),
                filled: true,
                hintStyle: TextStyle(color: CustomTheme.grey),
                hintText: placeholder,
                fillColor: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
