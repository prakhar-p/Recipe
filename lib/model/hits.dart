import 'package:receipe/model/recipe_model.dart';

class Hits {
  RecipeModel recipeModel;

  Hits({required this.recipeModel});

  factory Hits.fromMap(Map<String, dynamic> parsedJson) {
    return Hits(recipeModel: RecipeModel.fromMap(parsedJson["recipe"]));
  }
}