import 'package:flutter/material.dart';
import 'package:meshcafe_app/src/pages/signin_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

bool _toggleVisibility = true;
bool _toggleVisibility2 = true;

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          )),
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Your Username",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          )),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
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

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      obscureText: _toggleVisibility2,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _toggleVisibility2 = !_toggleVisibility2;
              });
            },
            icon: _toggleVisibility2
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility)),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
            ),
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildEmailTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildUsernameTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildPasswordTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildConfirmPasswordTextField()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blueAccent,
                ),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )),
            Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Text(
                    "SignIn",
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
    );
  }
}
