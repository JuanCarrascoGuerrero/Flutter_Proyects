

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:questions/model/filesapi.dart';

class Filesapicontrol extends GetxController {

    List<FilesApi>? model;
    RxList<FilesApi> getModel = <FilesApi>[].obs;
    RxList<String> getAno = <String>[].obs;
    RxList<String> getFile = <String>[].obs;

    void getApi() async {

      var response = await http.get(
        Uri.parse('https://mapi.trycatchtech.com/v3/twelfth_question_papers/year_list?category=mains'));
      if(response.statusCode==200){
        model = FilesApi.listOfJsons(jsonDecode(response.body));
        getModel.assignAll(model!);
        getAno.assignAll(model!.map((e) => e.year!).toList());
        getFile.assignAll(model!.map((e)=>e.file!).toList());
        update();
      }

    }

@override
  void onInit() {
    getApi();
    super.onInit();
  }

}