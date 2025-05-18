import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:questions/model/filesapi.dart';
import 'package:questions/model/papers.dart';

class Filesapicontrol extends GetxController {
  RxString category = "".obs;
  List<FilesApi>? model;
  RxList<FilesApi> getModel = <FilesApi>[].obs;
  RxList<String> getAno = <String>[].obs;
  RxList<String> getFile = <String>[].obs;
  List<Papers>? papers;
  RxList<Papers> getPapers = <Papers>[].obs;
  RxList<String> getPapersids = <String>[].obs;
  RxList<String> getPaperFiles = <String>[].obs;

  void getApi() async {
    var response = await http.get(
      Uri.parse(
        category.value == "dropdown"
            ? 'https://mapi.trycatchtech.com/v3/twelfth_question_papers/question_papers_list?year_id=1&subject=Biology'
            : 'https://mapi.trycatchtech.com/v3/twelfth_question_papers/year_list?category=' +
                category.toString(),
      ),
    );
    if (response.statusCode == 200) {
      if (category.value == 'dropdown') {
        papers = Papers.listOfJsons(jsonDecode(response.body));
        getPapersids.assignAll(papers!.map((e) => e.paper!).toList());
        getPaperFiles.assignAll(papers!.map((e) => e.file!).toList());
      } else {
        model = FilesApi.listOfJsons(jsonDecode(response.body));
        getModel.assignAll(model!);
        getAno.assignAll(model!.map((e) => e.year!).toList());
        if (category.value == "mains") {
          getFile.assignAll(model!.map((e) => e.file!).toList());
        }
        update();
      }
    }
  }

  @override
  void onInit() {
    ever(category, (_) => getApi());
    getApi();
    super.onInit();
  }
}
