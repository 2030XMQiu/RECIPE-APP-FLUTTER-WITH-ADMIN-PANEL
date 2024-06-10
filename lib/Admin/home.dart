import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:recipe_app/Admin/add_recipe.dart';
import 'package:recipe_app/pages/recipe_detail.dart';
import 'package:recipe_app/services/database.dart';
import 'package:recipe_app/widget/support_widget.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String? image;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  TextEditingController nameController = new TextEditingController();
  TextEditingController langkahController = new TextEditingController();
  TextEditingController resepController = new TextEditingController();
  Stream? MakananStream;

  String? value;
  final List<String> categoryitem = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Dessert',
  ];
  final CollectionReference _makanans =
      FirebaseFirestore.instance.collection('Makanan');

  Future<void> _deleteRecipe(String id) async {
    await _makanans.doc(id).delete();

    // Show a snackbar
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      desc: 'Recipe Deleted',
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> getImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  getonload() async {
    MakananStream = await DataBaseMethod().getMakanan();
    setState(() {});
  }

  bool search = false;
  List categories = [
    "Sarapan",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png"
  ];

  List Categoryname = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Dessert",
  ];
  var queryResultSets = [];
  var tempSearchStore = [];
  TextEditingController searchController = new TextEditingController();
  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSets = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });
    var CapitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSets.isEmpty && value.length == 1) {
      DataBaseMethod().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSets.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSets.forEach((element) {
        if (element['UpdatedName'].startsWith(CapitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  void initState() {
    getonload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xffecefe8),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: 50.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      initiateSearch(value.toUpperCase());
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Recipe",
                        hintStyle: AppWidget.lightTextFieldStyle(),
                        prefixIcon: search
                            ? GestureDetector(
                                onTap: () {
                                  search = false;
                                  tempSearchStore = [];
                                  queryResultSets = [];
                                  setState(() {});
                                  searchController.text = "";
                                },
                                child: Icon(Icons.close))
                            : Icon(
                                Icons.search,
                                color: Colors.black,
                              )),
                  ),
                ),
                SizedBox(height: 20.0),
                search
                    ? ListView(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10),
                        primary: false,
                        shrinkWrap: true,
                        children: tempSearchStore.map((element) {
                          return buildResultCard(element);
                        }).toList(),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "All Recipe",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddRecipe(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 28,
                                    ),
                                    Text(
                                      "Add Recipe",
                                      style: AppWidget.miniBoldTextFieldStyle(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  height: 600.0,
                                  child: StreamBuilder(
                                    stream: MakananStream,
                                    builder: (context, AsyncSnapshot snapshot) {
                                      return snapshot.hasData
                                          ? ListView.builder(
                                              itemCount:
                                                  snapshot.data.docs.length,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot ds =
                                                    snapshot.data!.docs[index];
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20.0),
                                                  child: Material(
                                                    elevation: 5.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 20.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        color: Colors.white,
                                                      ),
                                                      height: 100,
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              ds["Image"],
                                                              height: 50,
                                                              width: 50,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          SizedBox(width: 20.0),
                                                          Text(
                                                            ds["Name"],
                                                            style: AppWidget
                                                                .miniBoldTextFieldStyle(),
                                                          ),
                                                          Spacer(),
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (ds["Image"] != null &&
                                                                  ds["Name"] !=
                                                                      null &&
                                                                  ds["Resep"] !=
                                                                      null &&
                                                                  ds["Langkah"] !=
                                                                      null &&
                                                                  ds["Category"] !=
                                                                      null) {
                                                                image =
                                                                    ds["Image"];
                                                                nameController
                                                                        .text =
                                                                    ds["Name"];
                                                                resepController
                                                                        .text =
                                                                    ds["Resep"];
                                                                langkahController
                                                                        .text =
                                                                    ds["Langkah"];
                                                                value = ds[
                                                                    "Category"];
                                                                editResep(
                                                                    ds["Id"]);
                                                              } else {
                                                                // Handle the case where one of the required fields is null
                                                                print(
                                                                    "One of the required fields is null");
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.green,
                                                              size: 28,
                                                            ),
                                                          ),
                                                          SizedBox(width: 20.0),
                                                          GestureDetector(
                                                            onTap: () {
                                                              AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .warning,
                                                                animType: AnimType
                                                                    .rightSlide,
                                                                title:
                                                                    'Delete Recipe?',
                                                                btnCancelOnPress:
                                                                    () {},
                                                                btnOkOnPress:
                                                                    () {
                                                                  _deleteRecipe(
                                                                      ds["Id"]);
                                                                },
                                                              ).show();
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 28,
                                                            ),
                                                          ),
                                                          SizedBox(width: 20.0),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                          : Container();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editResep(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    SizedBox(width: 8),
                    Text("Edit Recipe"),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Food Picture",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      SizedBox(height: 20.0),
                      selectedImage != null
                          ? GestureDetector(
                              onTap: getImage,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    selectedImage!,
                                    height: 150.0,
                                    width: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: getImage,
                              child: Center(
                                child: Material(
                                  elevation: 4.0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 20),
                      Text(
                        "Food Name",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(151, 158, 158, 158),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Recipe",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(151, 158, 158, 158),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: resepController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "How To Make Food",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(151, 158, 158, 158),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          maxLines: 6,
                          controller: langkahController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(151, 158, 158, 158),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: categoryitem
                                .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    )))
                                .toList(),
                            onChanged: (value) => setState(() {
                              this.value = value;
                            }),
                            dropdownColor: Colors.white,
                            hint: Text("Select Category"),
                            iconSize: 36,
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            ),
                            value: value,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.rightSlide,
                              title: 'Edit Recipe',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                if (selectedImage != null) {
                                  String random = randomAlpha(10);
                                  FirebaseStorage firebaseStorage =
                                      FirebaseStorage.instance;
                                  Reference reference = firebaseStorage
                                      .ref()
                                      .child("MakananImage")
                                      .child("$random.jpg");
                                  UploadTask uploadTask =
                                      reference.putFile(selectedImage!);
                                  String firstletter = nameController.text
                                      .substring(0, 1)
                                      .toUpperCase();
                                  await uploadTask.whenComplete(() async {
                                    String url =
                                        await reference.getDownloadURL();
                                    print(url);

                                    await _makanans.doc(id).update({
                                      'Image': url,
                                      'Name': nameController.text,
                                      'Resep': resepController.text,
                                      'Langkah': langkahController.text,
                                      'Category': value,
                                      'SearchKey': firstletter,
                                      "UpdatedName":
                                          nameController.text.toUpperCase(),
                                    });
                                  });
                                } else {
                                  String firstletter = nameController.text
                                      .substring(0, 1)
                                      .toUpperCase();
                                  await _makanans.doc(id).update({
                                    'Image': image,
                                    'Name': nameController.text,
                                    'Resep': resepController.text,
                                    'Langkah': langkahController.text,
                                    'Category': value,
                                    'SearchKey': firstletter,
                                    "UpdatedName":
                                        nameController.text.toUpperCase(),
                                  });
                                }
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'Successfully Edit Recipe',
                                  btnOkOnPress: () {
                                    Navigator.pop(context);
                                  },
                                ).show();
                              },
                            ).show();
                            // if (selectedImage != null) {
                            //   String random = randomAlpha(10);
                            //   FirebaseStorage firebaseStorage =
                            //       FirebaseStorage.instance;
                            //   Reference reference = firebaseStorage
                            //       .ref()
                            //       .child("MakananImage")
                            //       .child("$random.jpg");
                            //   UploadTask uploadTask =
                            //       reference.putFile(selectedImage!);
                            //   await uploadTask.whenComplete(() async {
                            //     String url = await reference.getDownloadURL();
                            //     print(url);

                            //     await _makanans.doc(id).update({
                            //       'Image': url,
                            //       'Name': nameController.text,
                            //       'Resep': resepController.text,
                            //       'Langkah': langkahController.text,
                            //       'Category': value,
                            //     });
                            //   });
                            // } else {
                            //   await _makanans.doc(id).update({
                            //     'Image': image,
                            //     'Name': nameController.text,
                            //     'Resep': resepController.text,
                            //     'Langkah': langkahController.text,
                            //     'Category': value,
                            //   });
                            // }
                            // Navigator.pop(context);
                          },
                          child: Text(
                            "Edit Recipe",
                            style: TextStyle(fontSize: 22.0),
                          ),
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

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => ResepDetail(
                    resep: data["Resep"],
                    image: data["Image"],
                    name: data["Name"],
                    langkah: data["Langkah"]))));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            height: 100,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    data["Image"],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  data["Name"],
                  style: AppWidget.miniBoldTextFieldStyle(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
