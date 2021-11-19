import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meshcafe_app/src/pages/order_page.dart';
import 'package:meshcafe_app/src/pages/signup_page.dart';
import 'package:meshcafe_app/src/widgets/button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

bool _toggleVisibility = true;

class _SignInPageState extends State<SignInPage> {
  //initializing firebase instance
  final _auth = FirebaseAuth.instance;
  //editing controllers
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Widget _buildEmailTextField() {
    return TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter your email address";
        }
        // //reg expression for email validation
        // if (RegExp(
        //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        //     .hasMatch(value)) {
        //   return "Please enter valid email";
        // }
        return null;
      },
      onSaved: (value) {
        emailController.text = value;
      },
      decoration: InputDecoration(
          hintText: "Your email or username",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          )),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');

        if (value.isEmpty) {
          return "Password is required for login.";
        }
        // if (regex.hasMatch(value)) {
        //   return "Password must be minimum 6 characters.";
        // }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value;
      },
      obscureText: _toggleVisibility,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _toggleVisibility = !_toggleVisibility;
              });
            },
            icon: _toggleVisibility
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility)),
      ),
    );
  }

  @override
  GlobalKey<FormState> _formKey = GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: Text(
                    "Sign In",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            _buildEmailTextField(),
                            SizedBox(
                              height: 20,
                            ),
                            _buildPasswordTextField()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      signIn(emailController.text, passwordController.text);
                    },
                    child: Button("Sign In")),
                Divider(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SignUpPage()));
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // login function

  void signIn(String email, String password) async {
    if (_formKey.currentState.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OrderPage()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }
}
