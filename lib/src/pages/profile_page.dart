import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/services/auth.dart';
import 'package:foodfreelancing/src/widgets/custom_list_tile.dart';
import 'package:foodfreelancing/src/widgets/small_button.dart';
import "package:foodfreelancing/src/models/user.dart";
import 'package:foodfreelancing/src/services/database.dart';
import 'package:foodfreelancing/src/services/auth.dart';
import 'package:foodfreelancing/src/pages/buyer_request_page.dart';
import 'package:provider/provider.dart';
import 'package:foodfreelancing/src/shared/loading.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import './change_password.dart';
import './edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userinfo;
  var id;
  bool check = false;
  bool check1 = true;
  Future getUser(String uid) async {
    userinfo = await _database.getSellerInfo(uid);
    setState(() {
      check = true;
    });
  }

  bool turnOnNotification = false;
  bool turnOnLocation = false;
  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService();
  File _image;
  final picker = ImagePicker();
  String _uploadedFileURL;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      uploadFile();
      print('File selected');
    });
  }

  Future uploadFile() async {
    print('File Uploading');
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profilepictures/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) async {
      await _database.updateProfilePicture(id, fileURL);
      setState(() {
        _uploadedFileURL = fileURL;
        print(_uploadedFileURL);
        print("shahahah");
        check = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    id = user.uid;
    // print("ahah");
    // print(userinfo);
    if (!check) {
      print(1);
      getUser(user.uid);
      return Loading();
    } else {
      print(3);
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 32.0,
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
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3.0,
                              offset: Offset(0, 4.0),
                              color: Colors.black38),
                        ],
                        image: DecorationImage(
                          image: NetworkImage("${userinfo['img']}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text(
                            "${userinfo['username']}",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          // Neeedd to ask shahzaib
                          // if(userinfo['verified'])
                            Icon(Icons.check_circle, color: Colors.blue),
                        ]),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${userinfo['phoneNo']}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "${userinfo['rating']}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Icon(Icons.star, color: Colors.yellow),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile()))
                                .then((value) {
                              setState(() {
                                check = false;
                              });
                            });
                          },
                          child: CustomListTile(
                            icon: Icons.edit,
                            text: "Edit Profile",
                          ),
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddBuyerRequest())).then((value) {
                              setState(() {
                                check = false;
                              });
                            });
                          },
                          child: CustomListTile(
                            icon: Icons.visibility,
                            text: "Change Password",
                          ),
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        FlatButton(
                          onPressed: getImage,
                          child: CustomListTile(
                            icon: Icons.add_a_photo,
                            text: "Choose Image",
                          ),
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        FlatButton(
                          onPressed: () async {
                            await _auth.signOut();
                          },
                          child: CustomListTile(
                            icon: Icons.person,
                            text: "Sign out",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
