import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      width: double.infinity,
                      child: Column(
              children: [
                Flexible(flex: 2, child: Container()),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: Colors.white,
                  height: 64,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'Enter your email'),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    controller: _passwordController,
                    textInputType: TextInputType.text,
                    hintText: 'Enter your password',
                    isPass: true,
                    ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: blueColor),
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('Login'),
                    ),
                  ),
                ),
                Flexible(flex: 2, child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Sign Up.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
                      ),
                    ),
            ],
          )),
    );
  }
}
