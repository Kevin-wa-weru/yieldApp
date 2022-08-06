import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yieldapp/main.dart';
import 'package:yieldapp/register.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final paswordController = TextEditingController();
  bool obsecurepassword = true;
  late String token = '';
  bool showSpinner = false;

  Future loginUser(email, username, password) async {
    var apiurl = "https://yieldsapp.azurewebsites.net/api/auth/mobile-login";

    // Map maplogindetails = {
    //   "email": email,
    //   "userName": username,
    //   "password": password,
    //   "rememberMe": true,
    //   "verificationCode": ""
    // };

    Map maplogindetails = {
      "email": "uyieldapp",
      "userName": "uyieldapp",
      "password": "Qwerty-1",
      "rememberMe": true,
      "verificationCode": ""
    };

    http.Response response = await http
        .post(Uri.parse(apiurl), body: jsonEncode(maplogindetails), headers: {
      "Content-Type": "application/json",
    });

    print(response.body);

    if (response.body.isNotEmpty) {
      var data = json.decode(response.body);

      token = data['token']['accessToken'];
      return token;
    } else {
      return token;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset('assets/leaf.svg',
                      color: Colors.green, height: 10, fit: BoxFit.fitHeight),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Yields App',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          const Center(
            child: Text(
              'Log In',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: const TextStyle(fontWeight: FontWeight.w500),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    filled: true,
                    hintText: 'UserName',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                onChanged: (value) {
                  setState(() {});
                },
                controller: userNameController,
              ),
            ),
          ),
          SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: const TextStyle(fontWeight: FontWeight.w500),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    filled: true,
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                onChanged: (value) {
                  setState(() {});
                },
                controller: emailController,
              ),
            ),
          ),
          SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: const TextStyle(fontWeight: FontWeight.w500),
                keyboardType: TextInputType.name,
                obscureText: obsecurepassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    filled: true,
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                onChanged: (value) {
                  setState(() {});
                },
                controller: paswordController,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (emailController.text.isEmpty ||
                  paswordController.text.isEmpty ||
                  userNameController.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Complete the form",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              // else if (Misc.validateEmail(emailController.text) != null) {
              //   Fluttertoast.showToast(
              //       msg: "Email provided is not valid",
              //       toastLength: Toast.LENGTH_LONG,
              //       gravity: ToastGravity.BOTTOM,
              //       backgroundColor: Colors.green,
              //       textColor: Colors.white,
              //       fontSize: 16.0);
              // }
              else {
                setState(() {
                  showSpinner = true;
                });
                String response = await loginUser(
                    emailController.text.trim(),
                    paswordController.text.trim(),
                    userNameController.text.trim());

                setState(() {
                  showSpinner = false;
                });
                if (response.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "There was a problem. Check credentials",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: "Successfull login",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapAnimation()),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: 400,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: showSpinner == false
                      ? const Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      : const SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Register()),
              );
            },
            child: const Center(
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'AvenirNext',
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
