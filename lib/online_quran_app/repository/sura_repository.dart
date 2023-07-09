import 'package:api_test/online_quran_app/model/sura_list_model.dart';
import 'package:http/http.dart' as http;
class SuraRepository{
  Future <List<SuraListModel>> getSuraList()async{

     Uri url = Uri.parse("https://alquranbd.com/api/tafheem/sura/list");
     final response=await http.get(url);
     print(response.body);

     return suraListModelFromJson(response.body);
    
  }
}

