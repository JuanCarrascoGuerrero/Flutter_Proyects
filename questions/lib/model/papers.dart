class Papers {
  String? paperId;
  String? paper;
  String? file;
  String? yearId;

  Papers({this.paperId, this.paper, this.file, this.yearId});

  Papers.fromJson(Map<String, dynamic> json) {
    paperId = json["paper_id"];
    paper = json["paper"];
    file = json["file"];
    yearId = json["year_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["paper_id"] = paperId;
    _data["paper"] = paper;
    _data["file"] = file;
    _data["year_id"] = yearId;
    return _data;
  }

static List<Papers> listOfJsons(dynamic response) {
  if (response is List) {
    return response.where((e) => e is Map<String, dynamic>) // Filter out unexpected types
        .map((e) => Papers.fromJson(e))
        .toList();
  } else {
    throw Exception("Unexpected response format: Expected List<Map<String, dynamic>>, got ${response.runtimeType}");
  }
}
}
