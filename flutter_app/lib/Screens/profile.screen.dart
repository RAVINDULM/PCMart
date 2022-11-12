import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/components/customButton.dart';
import 'package:flutter_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loadingButton = false;
  void signOutPressed() {
    setState(() {
      loadingButton = true;
    });
    Provider.of<ApplicationState>(context, listen: false).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Hi there!",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        CustomButton(text: "Sign Out", onPress: signOutPressed)
      ]),
    );
  }
}
