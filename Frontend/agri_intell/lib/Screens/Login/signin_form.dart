import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irregation/Screens/pages.dart';
import 'package:irregation/controller/LoginController.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../Signup/signup_screen.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Form(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(60.0),
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 24, 78, 26),
                    fontFamily: 'Bahnschrift SemiBold',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: controller.username,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (email) {},
                decoration: const InputDecoration(
                  hintText: "email adress",
                  // border: OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.alternate_email),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: controller.password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () =>
                    {if (!controller.loading.value) controller.send()},
                child: controller.loading.value
                    ? CircularProgressIndicator()
                    : Text(
                        "Sign in".toUpperCase(),
                      ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
