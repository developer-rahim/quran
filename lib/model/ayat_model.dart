// To parse this JSON data, do
//
//     final ayatListModel = ayatListModelFromJson(jsonString);

import 'dart:convert';

List<AyatListModel> ayatListModelFromJson(String str) => List<AyatListModel>.from(json.decode(str).map((x) => AyatListModel.fromJson(x)));

String ayatListModelToJson(List<AyatListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AyatListModel {
    AyatListModel({
        this.id,
        this.surahId,
        this.ayahNo,
        this.ayahText,
        this.bn,
    });

    String? id;
    String ?surahId;
    String ?ayahNo;
    String? ayahText;
    List<Bn>? bn;

    factory AyatListModel.fromJson(Map<String, dynamic> json) => AyatListModel(
        id: json["id"],
        surahId: json["surah_id"],
        ayahNo: json["ayah_no"],
        ayahText: json["ayah_text"],
        bn: List<Bn>.from(json["bn"].map((x) => Bn.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "surah_id": surahId,
        "ayah_no": ayahNo,
        "ayah_text": ayahText,
        "bn": List<dynamic>.from(bn!.map((x) => x.toJson())),
    };
}

class Bn {
    Bn({
        this.hasTafsir,
        this.ayahId,
        this.tokenNo,
        this.tokenTrans,
        this.tokenExplNo,
    });

    HasTafsir? hasTafsir;
    String? ayahId;
    String? tokenNo;
    String? tokenTrans;
    String ?tokenExplNo;

    factory Bn.fromJson(Map<String, dynamic> json) => Bn(
        hasTafsir: hasTafsirValues.map[json["hasTafsir"]],
        ayahId: json["ayah_id"],
        tokenNo: json["token_no"],
        tokenTrans: json["token_trans"],
        tokenExplNo: json["token_expl_no"] == null ? null : json["token_expl_no"],
    );

    Map<String, dynamic> toJson() => {
        "hasTafsir": hasTafsirValues.reverse[hasTafsir],
        "ayah_id": ayahId,
        "token_no": tokenNo,
        "token_trans": tokenTrans,
        "token_expl_no": tokenExplNo == null ? null : tokenExplNo,
    };
}

enum HasTafsir { YES }

final hasTafsirValues = EnumValues({
    "yes": HasTafsir.YES
});

class EnumValues<T> {
   late Map<String, T> map;
  late  Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
