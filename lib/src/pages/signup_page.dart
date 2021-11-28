import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meshcafe_app/src/homescreen.dart';
import 'package:meshcafe_app/src/models/user_model.dart';
import 'package:meshcafe_app/src/pages/homepage.dart';
import 'package:meshcafe_app/src/pages/profile_page.dart';
import 'package:meshcafe_app/src/pages/signin_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

bool _toggleVisibility = true;
bool _toggleVisibility2 = true;

//editing controllers
final TextEditingController usernameController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();
final TextEditingController confirmpasswordController =
    new TextEditingController();
final TextEditingController emailController = new TextEditingController();
final TextEditingController phonenumberController = new TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget _buildEmailTextField() {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Email is required for signup.";
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Username is required for signup.";
        }
        return null;
      },
      controller: usernameController,
      decoration: InputDecoration(
          hintText: "Your Username",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          )),
    );
  }

  Widget _buildPhonenumberTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Phone number is required for signup.";
        }
        return null;
      },
      controller: phonenumberController,
      decoration: InputDecoration(
          hintText: "Phone Number",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          )),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required for signup.";
        }
        return null;
      },
      controller: passwordController,
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Password confirmation is required for signup.";
        }
        return null;
      },
      controller: confirmpasswordController,
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

  GlobalKey<FormState> _signupformKey = GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Form(
                key: _signupformKey,
                // elevation: 5,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _buildUsernameTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          _buildEmailTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          _buildPhonenumberTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          _buildPasswordTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          _buildConfirmPasswordTextField(),
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
                                child: GestureDetector(
                                  onTap: () {
                                    signUp(emailController.text,
                                        passwordController.text);
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
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
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignInPage()));
                                },
                                child: Text(
                                  "Sign in",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//signup function
  void signUp(String email, String password) async {
    if (_signupformKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }

  postDetailsToFirestore() async {
//calling our firestore
//calling our user model
//sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser!;
    UserModel userModel = UserModel();
    //writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.phonenumber = phonenumberController.text;
    userModel.username = usernameController.text;

    //firestore
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully.");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
        (route) => false);
  }
}


//   Food(
//       {this.id,
//       this.name,
//       this.imagePath,
//       this.description,
//       this.category,
//       this.price,
//       this.discount,
//       this.ratings});
// }