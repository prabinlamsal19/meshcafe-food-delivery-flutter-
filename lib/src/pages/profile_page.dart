import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/small_button.dart';
//path_provider and path for storing image permanently
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File image;
  Future PickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      // SaveImage(imageTemporary);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  // void SaveImage(path) {
  //   SharedPreferences saveimage = SharedPreferences.getInstance();
  //   saveimage.setString("imagepath", path)
  // }

  Future PickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future saveImagePermanently(String imagePath) async {
    Directory dir = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${dir.path}/$name');
    return File(imagePath).copy(image.path);
  }

  bool turnOnNotification = false;
  bool turnOnLocation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(blurRadius: 3.0, offset: Offset(0, 1.0))
                      ],
                      image: DecorationImage(
                        image: image == null
                            ? AssetImage("assets/supper_1.jpeg")
                            : FileImage(image),
                        fit: BoxFit.cover,
                      )),
                  // child: Image.asset("turkey.png"),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Prabin Lamsal",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "9846825271",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          return showModalBottomSheet(
                              elevation: 2.0,
                              context: context,
                              builder: (context) => Wrap(children: [
                                    Column(
                                      children: [
                                        ListTile(
                                            leading: Icon(Icons.camera_alt),
                                            title: Text("Camera"),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pop(ImageSource.camera);
                                              PickCamera();
                                            }), //////////////////////////////////////////////////////////////
                                        ListTile(
                                            leading: Icon(Icons.image),
                                            title: Text("Gallery"),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pop(ImageSource.gallery);
                                              PickImage();
                                            })
                                      ],
                                    ),
                                  ]));
                        },
                        child: SmallButton(value: "Edit")),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      title: Text("Location"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.visibility,
                        color: Colors.blue,
                      ),
                      title: Text("Change Password"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.shopping_cart,
                        color: Colors.blue,
                      ),
                      title: Text("Shipping"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.payment,
                        color: Colors.blue,
                      ),
                      title: Text("Payment"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Notifications",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("App Notifications",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      contentPadding: EdgeInsets.all(0),
                      trailing: Switch(
                        value: turnOnNotification,
                        onChanged: (bool value) {
                          setState(() {
                            turnOnNotification = value;
                          });
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      trailing: Switch(
                        value: turnOnLocation,
                        onChanged: (bool value) {
                          setState(() {
                            turnOnLocation = value;
                          });
                        },
                      ),
                      title: Text("Location Tracking"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Other",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Language"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      title: Text("Currency"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
