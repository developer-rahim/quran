import 'package:api_test/model/ayat_model.dart';
import 'package:api_test/model/sura_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
class SuraService{
  Future <List<SuraListModel>> getSuraList()async{

     Uri url = Uri.parse("https://alquranbd.com/api/tafheem/sura/list");
     final response=await http.get(url);
     print(response.body);

     return suraListModelFromJson(response.body);
    
  }
}

