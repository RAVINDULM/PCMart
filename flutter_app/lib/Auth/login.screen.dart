import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/components/customButton.dart';
import 'package:flutter_app/components/customInputField.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/app_state.dart';
import 'package:flutter_app/utils/login.dart';
import 'package:flutter_app/utils/theme.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool loadingButton = false;

  Map<String, String> data = {};

  _LoginState() {
    data = LoginData.signin;
  }

  loginError(FirebaseAuthException e) {
    if (e.message != '') {
      setState(() {
        loadingButton = false;
      });
    }
  }

  void loginButtonPressed() {
    setState(() {
      loadingButton = true;
    });

    ApplicationState applicationState =
        Provider.of<ApplicationState>(context, listen: false);
    if (mapEquals(data, LoginData.signup)) {
      print(_emailcontroller.text);
       print(_passwordcontroller.text);
      applicationState.SignUp(
          _emailcontroller.text, _passwordcontroller.text, loginError);
    } else {
      applicationState.SignIn(
          _emailcontroller.text, _passwordcontroller.text, loginError);
    }
  }

  void SwitchLogin() {
    setState(() {
      if (mapEquals(data, LoginData.signup)) {
        data = LoginData.signin;
      } else {
        data = LoginData.signup;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(data['heading'] as String,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),
                  Text(
                    data['subheading'] as String,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            model(data, _emailcontroller, _passwordcontroller),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: SwitchLogin,
                    child: Text(
                      data['footer'] as String,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  model(Map<String, String> data, TextEditingController emailController,
      TextEditingController passwordController) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 56),
      decoration: CustomTheme.GetcardDecoration(),
      child: Column(
        children: [
          CustomInputField(
              label: "Email address",
              placeholder: "email@adress.com",
              icon: Icons.email_outlined,
              textEditingController: _emailcontroller),
          CustomInputField(
              label: "Password",
              placeholder: "password",
              icon: Icons.lock_open_outlined,
              password: true,
              textEditingController: _passwordcontroller),
          CustomButton(
            text: data["label"] as String,
            loading: loadingButton,
            onPress: loginButtonPressed,
          )
        ],
      ),
    );
  }
}
