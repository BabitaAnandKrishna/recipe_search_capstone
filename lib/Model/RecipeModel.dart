class RecipeModel{
  String label;
  String image;
  String source;
  String url;
  double calories;

  RecipeModel({this.url,this.image,this.label,this.source,this.calories});

  factory RecipeModel.fromMap(Map<String,dynamic> parsedJson){
    return RecipeModel(
        url: parsedJson["url"],
        label: parsedJson["label"],
        image: parsedJson["image"],
        source: parsedJson["source"],
        calories: parsedJson["calories"]

    );
  }
}