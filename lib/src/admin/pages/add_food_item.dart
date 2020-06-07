import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/models/food_model.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/scoped-model/main_model.dart';
import 'package:foodfreelancing/src/services/FoodItems.dart';
import 'package:foodfreelancing/src/widgets/button.dart';
import 'package:foodfreelancing/src/widgets/show_dailog.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'dart:async';
import 'package:foodfreelancing/src/services/database.dart';
// import 'package:foodfreelancing/src/services/FoodItems.dart';
import 'package:foodfreelancing/src/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:foodfreelancing/src/shared/loading.dart';

class AddFoodItem extends StatefulWidget {
  final Food food;

  AddFoodItem({this.food});

  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  var userinfo;
  var id;
  // bool check = false;
  // bool check1 = true;
  Future getUser(String uid) async {
    userinfo = await foodItem.foodItems
        .document(id)
        .collection("FoodList")
        .document(title)
        .get()
        .then((value) {
      print(value.data['image']);
      return value.data;
    });

    setState(() {
      // print(userinfo['image']);
      // check = true;
    });
  }

  bool loading = false;

  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService();
  final FoodItems foodItem = FoodItems();
  String temporaryPath =
      "https://firebasestorage.googleapis.com/v0/b/foodfreelancing.appspot.com/o/Foodpictures%2Fdownload.png?alt=media&token=05879b8b-1ca9-4a88-9dd1-6e0685f5e231";
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
    setState(() {
      loading = true;
    });
    print('File Uploading');
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Foodpictures/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) async {
      // await foodItem.updateFoodPicture(id, fileURL, title);
      setState(() {
        print(fileURL);
        print(fileURL);
        print(fileURL);
        _uploadedFileURL = fileURL;
        temporaryPath = fileURL;
        print(_uploadedFileURL);
        loading = false;
        print("shahahah");
      });
    });
  }

  String title;
  String category;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    id = user.uid;
    print("Add Food Item Uid: " + user.uid);

    return loading
        ? Loading()
        : SafeArea(
            child: WillPopScope(
              onWillPop: () {
                Navigator.of(context).pop(false);
                return Future.value(false);
              },
              child: Scaffold(
                key: _scaffoldStateKey,
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  title: Text(
                    widget.food != null ? "Update Food Item" : "Add Food Item",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: _foodItemFormKey,
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            onPressed: getImage,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              width: MediaQuery.of(context).size.width,
                              height: 170.0,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0),

                                image: DecorationImage(
                                  image: NetworkImage(temporaryPath),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          _buildTextFormField("Food Title"),
                          _buildTextFormField("Category"),
                          _buildTextFormField("Description", maxLine: 5),
                          _buildTextFormField("Price"),
                          // _buildTextFormField("Discount"),
                          SizedBox(
                            height: 70.0,
                          ),
                          ScopedModelDescendant(
                            builder: (BuildContext context, Widget child,
                                MainModel model) {
                              return GestureDetector(
                                  onTap: () {
                                    print("Food title : " + title);
                                    print("Food category : " + category);
                                    print("Food description : " + description);
                                    print("Food price : " + price.toString());
                                    print("Food Dicount : " +
                                        discount.toString());
                                    onSubmit(model.addFood, model.updateFood);
                                    if (model.isLoading) {
                                      // show loading progess indicator
                                      showLoadingIndicator(
                                          context,
                                          widget.food != null
                                              ? "Updating food..."
                                              : "Adding food...");
                                    }
                                  },
                                  child: FlatButton(
                                    onPressed: () async {
                                      print("Food title : " + title);
                                      print("Food category : " + category);
                                      print(
                                          "Food description : " + description);
                                      print("Food price : " + price.toString());
                                      print("Food Dicount : " +
                                          discount.toString());
                                      FoodItems(uid: user.uid).addFoodItems(
                                          title,
                                          category,
                                          description,
                                          price,
                                          temporaryPath);
                                      Navigator.of(context).pop();
                                    },
                                    child: Button(
                                        btnText: widget.food != null
                                            ? "Update Food Item"
                                            : "Add Food Item"),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void onSubmit(Function addFood, Function updateFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      if (widget.food != null) {
        // I want to update the food item
        Map<String, dynamic> updatedFoodItem = {
          "title": title,
          "category": category,
          "description": description,
          "price": double.parse(price),
          "discount": discount != null ? double.parse(discount) : 0.0,
        };
        final bool response = await updateFood(updatedFoodItem, widget.food.id);
        if (response) {
          Navigator.of(context).pop(); // to remove the alert Dialog
          Navigator.of(context).pop(response); // to the previous page
        } else if (!response) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(
              "Failed to update food item",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      } else if (widget.food == null) {
        // I wnat to add new Item
        final Food food = Food(
          name: title,
          category: category,
          description: description,
          price: double.parse(price),
          discount: double.parse(discount),
        );
        bool value = await addFood(food);
        if (value) {
          Navigator.of(context).pop();
          SnackBar snackBar =
              SnackBar(content: Text("Food item successfully added."));
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        } else if (!value) {
          Navigator.of(context).pop();
          SnackBar snackBar =
              SnackBar(content: Text("Failed to add food item"));
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      initialValue: widget.food != null && hint == "Food Title"
          ? widget.food.name
          : widget.food != null && hint == "Description"
              ? widget.food.description
              : widget.food != null && hint == "Category"
                  ? widget.food.category
                  : widget.food != null && hint == "Price"
                      ? widget.food.price.toString()
                      : widget.food != null && hint == "Discount"
                          ? widget.food.discount.toString()
                          : "",
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" ? TextInputType.number : TextInputType.text,
      validator: (String value) {
        // String error
        if (value.isEmpty && hint == "Food Title") {
          return "The food title is required";
        }
        if (value.isEmpty && hint == "Description") {
          return "The description is required";
        }

        if (value.isEmpty && hint == "Category") {
          return "The category is required";
        }

        if (value.isEmpty && hint == "Price") {
          return "The price is required";
        }
        // return "";
      },
      onChanged: (String value) {
        // print(value);
        if (hint == "Food Title") {
          title = value;
          print("Food title : " + title);
        }
        if (hint == "Category") {
          category = value;
          print("Food category : " + category);
        }
        if (hint == "Description") {
          description = value;
          print("Food Description : " + description);
        }
        if (hint == "Price") {
          price = value;
          print("Food Price : " + price);
        }
        // if (hint == "Discount") {
        //   discount = value;
        //   print("Food Discount : " + discount);
        // }
      },
    );
  }

  // Widget _buildCategoryTextFormField() {
  // return TextFormField();
  // }
}
