import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_screen_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      isLoading = false;
    });
    if (res != 'Sucess') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LayoutScreen(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
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
              onTap: () {
                loginUser();
              },
              child: Container(
                width: double.infinity,
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: isLoading == true
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
              ),
            ),
            Flexible(flex: 2, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SignupScreen()));
                    },
                    child: const Text(
                      'Sign Up.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
