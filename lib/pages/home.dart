import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:recipe_app/pages/all_recipe.dart';
import 'package:recipe_app/pages/category_recipe.dart';
import 'package:recipe_app/pages/profile.dart';
import 'package:recipe_app/pages/recipe_detail.dart';
import 'package:recipe_app/services/database.dart';
import 'package:recipe_app/services/shared_pref.dart';
import 'package:recipe_app/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? MakananStream;
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

  String? name, image;
  getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    getonload();
    ontheload();
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
        body: name == null
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 50.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hey, " + name!,
                                style: AppWidget.boldTextFieldStyle(),
                              ),
                              Text(
                                "Let's cook now",
                                style: AppWidget.lightTextFieldStyle(),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Profile())));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                image!,
                                height: 50.0,
                                width: 50.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
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
                      SizedBox(
                        height: 20.0,
                      ),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Categories",
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllRecipe()));
                                      },
                                      child: Container(
                                          height: 80,
                                          padding: EdgeInsets.all(20),
                                          margin: EdgeInsets.only(right: 20.0),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 136, 0),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "All",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 80,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: categories.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: ((context, index) {
                                            return CategoryTile(
                                              image: categories[index],
                                              name: Categoryname[index],
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "All Foods",
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ],
                                ),
                                new Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        height: 360.0,
                                        child: StreamBuilder(
                                            stream: MakananStream,
                                            builder: (context,
                                                AsyncSnapshot snapshot) {
                                              return snapshot.hasData
                                                  ? GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio:
                                                                  0.8,
                                                              mainAxisSpacing:
                                                                  0,
                                                              crossAxisSpacing:
                                                                  25.0),
                                                      itemCount: snapshot
                                                          .data.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        DocumentSnapshot ds =
                                                            snapshot.data
                                                                .docs[index];
                                                        return Container(
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            children: [
                                                              Container(
                                                                height: 180,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5.0,
                                                                        vertical:
                                                                            5.0),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ResepDetail(
                                                                                resep: ds["Resep"],
                                                                                image: ds["Image"],
                                                                                name: ds["Name"],
                                                                                langkah: ds["Langkah"])));
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            10.0,
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child: Image
                                                                            .network(
                                                                          ds["Image"],
                                                                          height:
                                                                              120,
                                                                          width:
                                                                              150,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5.0,
                                                                      ),
                                                                      Text(
                                                                        ds["Name"],
                                                                        style: AppWidget
                                                                            .miniBoldTextFieldStyle(),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      })
                                                  : Container();
                                            }),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

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

class CategoryTile extends StatelessWidget {
  String image, name;
  CategoryTile({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryRecipe(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
            ]),
      ),
    );
  }
}
