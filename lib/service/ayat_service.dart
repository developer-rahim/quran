import 'package:http/http.dart' as http;

import '../model/ayat_model.dart';

class AyatService {
  Future<List<AyatListModel>> getAyatService(int id, int page) async {
    Uri url = Uri.parse('https://alquranbd.com/api/tafheem/suraData/$id/$page');
    http.Response response = await http.get(url);
    print(response.body);
    return ayatListModelFromJson(response.body);
  }
}
