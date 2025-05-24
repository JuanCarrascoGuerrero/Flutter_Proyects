class AnimalsModel {
    int? id;
    String? name;
    List<int>? color;
    String? category;
    String? image;
    bool? favourite;

    AnimalsModel({this.id, this.name, this.color, this.category, this.image, this.favourite});

    AnimalsModel.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        color = json["color"] == null ? null : List<int>.from(json["color"]);
        category = json["category"];
        image = json["image"];
        favourite = json["favourite"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        if(color != null) {
            _data["color"] = color;
        }
        _data["category"] = category;
        _data["image"] = image;
        _data["favourite"] = favourite;
        return _data;
    }

    static List<AnimalsModel> listOfJsons(List response){
      return response.map((e)=>AnimalsModel.fromJson(e)).toList();
    }
}