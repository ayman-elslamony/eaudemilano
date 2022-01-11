class AllCategories {
  List<Categorie> categories;

  AllCategories({this.categories});

  AllCategories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <Categorie>[];
      json['data'].forEach((v) {
        categories
        .add(Categorie.fromJson(v));
      });
    }
  }
}

class Categorie{
  int id;
  String title;

  Categorie({this.id, this.title});

  Categorie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

}