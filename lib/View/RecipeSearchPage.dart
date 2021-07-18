import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_search_capstone/Constant/UriConstant.dart';
import 'package:recipe_search_capstone/Model/RecipeModel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'WebViewPage.dart';


class RecipeSearch extends StatefulWidget {
  @override
  _RecipeSearchState createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  List<RecipeModel> recipies = new List();

  String ingridients;
  bool _loading = false;
  String query = "";
  TextEditingController textIngredientController = new TextEditingController();
  TextEditingController textExcludedController = new TextEditingController();
  TextEditingController textNumberRecipeController = new TextEditingController();
  TextEditingController textMinCalorieController = new TextEditingController();
  TextEditingController textMaxCalorieController = new TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  fetchRecipesData(String url, String query, int number_recipe,String excludedIngredients,int minCalorie, int maxCalorie) async{
    setState(() {
      _loading = true;
    });
    recipies = new List();
    var response = await http.get(Uri.parse(url));
    print(" $response this is response");
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    print("this is json Data $jsonData");
    jsonData["hits"].forEach((element) {
      print(element.toString());
      RecipeModel recipeModel = new RecipeModel();
      recipeModel =
          RecipeModel.fromMap(element['recipe']);
      recipies.add(recipeModel);
      print(recipeModel.url);
    });
    setState(() {
      _loading = false;
    });
    print("${recipies.length} data-----------");
  }

  ClearData(){
    textExcludedController.text="";
    textIngredientController.text="";
    textMinCalorieController.text="";
    textMaxCalorieController.text="";
    textNumberRecipeController.text="";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xffBABD8D),
                      const Color(0xff5E8C61)
                    ],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: !kIsWeb ? Platform.isAndroid? 50: 30 : 30, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Recipe",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff78290f),
                            fontFamily: 'Overpass'),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff003049),
                            fontFamily: 'Overpass'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cooking on your mind?",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass'),
                  ),
                  Text(
                    "Enter ingredients available with you and we will find a recipe you will love.",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff78290f),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Overpass'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Color(0xffd4a373),
                    elevation: 2,
                    child: Container(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key:_formkey ,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction ,
                                  controller: textIngredientController,
                                  validator: (value) => value.isEmpty ? '* Please Enter Ingredients' : null,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Overpass'),
                                  decoration: InputDecoration(
                                    hintText: "Enter Ingridients",
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.8),
                                        fontFamily: 'Overpass'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child:
                                TextFormField(
                                  controller: textExcludedController,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Overpass'),
                                  decoration: InputDecoration(
                                    hintText: "Enter excluded Ingredients",
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.8),
                                        fontFamily: 'Overpass'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction ,
                                        validator: (value) => value.isEmpty ? '* Please Enter Number of data display' : null,
                                        controller: textNumberRecipeController,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Overpass'),
                                        decoration: InputDecoration(
                                          hintText: "Display Recipe ",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white.withOpacity(0.8),
                                              fontFamily: 'Overpass'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction ,
                                        validator: (value) => value.isEmpty ? '* Please enter min calorie' : null,
                                        controller: textMinCalorieController,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Overpass'),
                                        decoration: InputDecoration(
                                          hintText: "Min Calorie",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white.withOpacity(0.8),
                                              fontFamily: 'Overpass'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction ,
                                        validator: (value) => value.isEmpty ? '* Please enter max calorie' : null,
                                        controller: textMaxCalorieController,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Overpass'),
                                        decoration: InputDecoration(
                                          hintText: "Max Calorie",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white.withOpacity(0.8),
                                              fontFamily: 'Overpass'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                  onTap: () async {

                                    if (textIngredientController.text.isEmpty || textNumberRecipeController.text.isEmpty || textMinCalorieController.text.isEmpty || textMaxCalorieController.text.isEmpty   ){
                                      if (_formkey.currentState.validate()) {

                                      }
                                    }
                                    else {
                                      String url;

                                      if (textIngredientController.text.isNotEmpty && textNumberRecipeController.text.isNotEmpty && textMinCalorieController.text.isNotEmpty && textMaxCalorieController.text.isNotEmpty && textExcludedController.text.isNotEmpty) {
                                        url = "https://api.edamam.com/search?q=${textIngredientController.text}&app_id=${UriConstants.applicationID}&app_key=${UriConstants.applicationKey}&from=0&to=${int.parse(textNumberRecipeController.text)}&excluded=${textExcludedController.text}&calories=${int.parse(textMinCalorieController.text)}-${int.parse(textMaxCalorieController.text)}&health=alcohol-free";
                                        fetchRecipesData(url,textIngredientController.text,int.parse(textNumberRecipeController.text) , textExcludedController.text,int.parse(textMinCalorieController.text),int.parse(textMaxCalorieController.text));
                                        // ClearData();
                                      }

                                      else if (textIngredientController.text.isNotEmpty  && textNumberRecipeController.text.isNotEmpty && textMinCalorieController.text.isNotEmpty && textMaxCalorieController.text.isNotEmpty && textExcludedController.text.isEmpty) {
                                        url = "https://api.edamam.com/search?q=${textIngredientController.text}&app_id=${UriConstants.applicationID}&app_key=${UriConstants.applicationKey}&from=0&to=${int.parse(textNumberRecipeController.text)}&calories=${int.parse(textMinCalorieController.text)}-${int.parse(textMaxCalorieController.text)}&health=alcohol-free";
                                        fetchRecipesData(url,textIngredientController.text,int.parse(textNumberRecipeController.text) , textExcludedController.text,int.parse(textMinCalorieController.text),int.parse(textMaxCalorieController.text));
                                        // ClearData();
                                      }
                                      setState(() {
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff5E8C61),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("Get Result",style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Overpass'
                                        ),),
                                        Icon(
                                            Icons.search,
                                            size: 18,
                                            color: Colors.white
                                        ),

                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _loading?Center(child: CircularProgressIndicator()): Container(
                    child:GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 32.0, maxCrossAxisExtent: 200.0),
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        children: List.generate(recipies.length, (index) {
                          return GridTile(
                              child: RecipieTile(
                                title: recipies[index].label,
                                imgUrl: recipies[index].image,
                                source: recipies[index].source,
                                url: recipies[index].url,
                                calorie: recipies[index].calories,
                                // calorie: recipies[index].calories,
                              ));
                        })),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecipieTile extends StatefulWidget {
  final String title, source, imgUrl, url;
  final double calorie;

  RecipieTile({this.title, this.source, this.imgUrl, this.url,this.calorie});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                        postUrl: widget.url,
                      )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.source,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
