import 'package:animate_do/animate_do.dart';
import 'package:brayon_news_network_app/app/auth/signin_page.dart';
import 'package:brayon_news_network_app/app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import '../widgets/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final snapshot = Provider.of<NewsServices>(context);

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      resizeToAvoidBottomInset: true,
      body: FadeInDown(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height / 18,
                  ),
                  Center(
                    child: Text(
                      'Create a new account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      'Fill all forms to continue',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          InputField(
                            validator: (value) {},
                            inputController: snapshot.firstNameController,
                            isPassword: false,
                            hasSuffixIcon: false,
                            hintText: 'First Name',
                            prefixIcon: Image.asset(
                              'assets/person_icon.png',
                              color: Color(0xFF333333).withOpacity(0.8),
                            ),
                            onSaved: (value) {
                              // _userFirstName = value;
                            },
                            keyBoardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InputField(
                            validator: (value) {},
                            inputController: snapshot.lastNameController,
                            isPassword: false,
                            hasSuffixIcon: false,
                            hintText: 'Last Name',
                            prefixIcon: Image.asset(
                              'assets/person_icon.png',
                              color: Color(0xFF333333).withOpacity(0.8),
                            ),
                            onSaved: (value) {
                              // _userLastName = value;
                            },
                            keyBoardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InputField(
                            validator: (value) {},
                            inputController: snapshot.registerEmailController,
                            isPassword: false,
                            keyBoardType: TextInputType.emailAddress,
                            hasSuffixIcon: false,
                            hintText: 'Email Address',
                            prefixIcon: Image.asset(
                              'assets/Icon_email.png',
                              color: Color(0xFF333333).withOpacity(0.8),
                            ),
                            onSaved: (value) {
                              // _userEmail = value;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InputField(
                            validator: (value) {},
                            inputController:
                                snapshot.registerPasswordController,
                            keyBoardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            isPassword: true,
                            hasSuffixIcon: true,
                            hintText: 'Password',
                            prefixIcon: Image.asset('assets/Icon_password.png'),
                            onSaved: (value) {
                              // _userPassword = value;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          MyButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                snapshot.signUpUser();
                                if (snapshot.registerResponse.statusCode == 201)
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignInPage()));
                              },
                              child: _isLoading
                                  ? Center(
                                      child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: CircularProgressIndicator(),
                                    ))
                                  : Center(
                                      child: Text(
                                      'Sign Up',
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
                                  const Text('Already have an account? ',
                                      style: TextStyle(
                                          wordSpacing: 3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInPage()),
                                          (route) => false);
                                    },
                                    child: const Text(
                                      'Sign in ',
                                      style: TextStyle(
                                          color: Color(0xFF3D16D6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
      height: imgHeight ?? 20.0,
    ),
  );
}
