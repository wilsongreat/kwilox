import 'package:animate_do/animate_do.dart';
import 'package:brayon_news_network_app/app/auth/signup_page.dart';
import 'package:brayon_news_network_app/app/pages/home_page.dart';
import 'package:brayon_news_network_app/app/widgets/my_button.dart';
import 'package:brayon_news_network_app/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final snapshot = Provider.of<NewsServices>(context);

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: FadeInDown(
            duration: Duration(milliseconds: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 7,
                ),
                Text(
                  'Welcome back!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Sign in to your account to get access',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Container(
                      height: size.height / 1.6,
                      child: Column(
                        children: [
                          InputField(
                            validator: (value) {
                              // if (value.isEmpty ||
                              //     !value.contains('@') ||
                              //     !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2-4}')
                              //         .hasMatch(value)) {
                              //   return 'Please enter a valid email address';
                              // }
                              // return null;
                            },
                            inputController: snapshot.emailController,
                            isPassword: false,
                            hasSuffixIcon: false,
                            hintText: 'Email Address',
                            prefixIcon: Image.asset(
                              'assets/Icon_email.png',
                              color: Color(0xFF333333).withOpacity(0.8),
                            ),
                            onSaved: (value) {
                              // _userPassword = value;
                            },
                            keyBoardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            inputController: snapshot.passwordController,
                            hasSuffixIcon: true,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            hintText: 'Password',
                            prefixIcon: Image.asset(
                              'assets/Icon_password.png',
                            ),
                            onSaved: (value) {
                              // _userPassword = value;
                            },
                            keyBoardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          MyButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await snapshot.loginUser(context);
                                if (snapshot.loginresponse.statusCode == 202) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomePage()));
                                }
                              },
                              child: _isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Center(
                                      child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                socialLinks('assets/google.png', 30),
                                socialLinks('assets/apple.png', 20),
                                socialLinks('assets/facebook.png', 20),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have an account? ',
                                    style: TextStyle(
                                        wordSpacing: 3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final isValidForm =
                                          _formKey.currentState!.validate();
                                      // if (isValidForm) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage()),
                                          (route) => false);
                                      // }
                                    },
                                    child: Text(
                                      'Sign up ',
                                      style: TextStyle(
                                          color: Color(0xFF3D16D6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}

Widget socialLinks(String imageUrl, double? imgHeight) {
  return Container(
    margin: EdgeInsets.only(right: 10.0),
    height: 50.0,
    width: 50.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle, color: Color(0xFF333333).withOpacity(0.08)),
    child: Image.asset(
      imageUrl,
      height: imgHeight ?? 10.0,
    ),
  );
}
