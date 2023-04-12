import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/firebase_helper.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  bool iseye = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green,
      body: Form(
        key: signUpFormKey,
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              width: 300,
              height: 200,
              child: Image.asset("assets/images/ic_food_express.png"),
            ),
            SizedBox(height: 50,),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 320,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.center,
                  width: 280,
                  height: 65,
                  child: TextFormField(
                    controller: emailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter email first....";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      email = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.email_outlined),
                      iconColor: Colors.white,
                      labelText: "Email",
                      labelStyle: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 320,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.center,
                  width: 280,
                  height: 65,
                  child: TextFormField(
                    obscureText: iseye,
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter email first....";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      password = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.password),
                      iconColor: Colors.white,
                      labelText: "Password",
                      labelStyle: TextStyle(fontWeight: FontWeight.w400),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            iseye = !iseye;
                          });
                        },
                        icon: Icon(
                          iseye
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF2CB6B),
                minimumSize: Size(320, 50),
              ),
              onPressed: ()
              async {
                if (signUpFormKey.currentState!.validate()) {
                  signUpFormKey.currentState!.save();
                }

                Map<String, dynamic> res = await FirebaseAuthHelper
                    .firebaseAuthHelper
                    .singUp(email: email!, password: password!);

                if (res['user'] != null) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                          "Login successful...",
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating),
                  );
                  Navigator.of(context).pushNamed('/');
                } else if (res['error'] != null) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(res['error']),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ), // SnackBar
                  );
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                          "Sign Up failed...",
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating),
                  );
                }
                setState(() {
                  emailController.clear();
                  passwordController.clear();

                  email = null;
                  password = null;
                });
              },
              child: Text(
                "Sing-Up",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Color(0xff76614A),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                  ),
                  onPressed: () async {
                    Map<String, dynamic> res = await FirebaseAuthHelper
                        .firebaseAuthHelper
                        .singWithGoogle();

                    if (res['user'] != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              "Login successful...",
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating),
                      );
                      Navigator.of(context).pushReplacementNamed('/homapage');
                    } else if (res['error'] != null) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(res['error']),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ), // SnackBar
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              "Login failed...",
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating),
                      );
                    }
                    setState(() {
                      emailController.clear();
                      passwordController.clear();

                      email = null;
                      password =null;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                            "assets/images/google-icon-logo.png"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                  ),
                  onPressed: () async {
                    User? user = await FirebaseAuthHelper
                        .firebaseAuthHelper
                        .signInAnonymously();

                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              "Login successful...",
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating),
                      );
                      Navigator.of(context).pushReplacementNamed('/homapage');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              "Login failed...",
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Anonymous",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(height: 100,),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                      setState(() {
                        emailController.clear();
                        passwordController.clear();

                        email = null;
                        password = null;
                      });
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff76614A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}