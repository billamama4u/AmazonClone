import 'package:amazone_clone/common/widgets/custombutton.dart';
import 'package:amazone_clone/common/widgets/customtextfielder.dart';
import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth { signup, signin }

class Authscreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<Authscreen> {
  Auth _auth = Auth.signup;
  final _signInKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<FormState>();
  final AuthService authservice = AuthService();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _namecontroller.dispose();
  }

  void signUpUser() async {
    authservice.signUpuser(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        name: _namecontroller.text);
  }

  void signInUser() {
    authservice.signinuser(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundCOlor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _namecontroller, hintText: "Name"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: _emailcontroller, hintText: "Email"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: _passwordcontroller,
                              hintText: "Password"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: "Sign Up",
                              onTap: () {
                                if (_signUpKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              })
                        ],
                      )),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundCOlor,
                title: const Text(
                  "Sign-In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signInKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _emailcontroller, hintText: "Email"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            controller: _passwordcontroller,
                            hintText: "Password"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            text: "Sign In",
                            onTap: () {
                              if (_signInKey.currentState!.validate()) {
                                signInUser();
                              }
                            })
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
