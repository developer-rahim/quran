class SuraDetailsModel {
  var sura;
  var sura_name;
  var VerseIDAr;
  var text;

  var ayat;

  SuraDetailsModel({
    this.sura,
    this.sura_name,
    this.VerseIDAr,
    this.text,
    this.ayat,
  });

  SuraDetailsModel.fromJson(Map<String, dynamic> json) {
    sura = json['sura'];
    sura_name = json['sura_name'];
    VerseIDAr = json['VerseIDAr'];
    text = json['text'];

    ayat = json['ayat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sura'] = this.sura;
    data['sura_name'] = this.sura_name;
    data['VerseIDAr'] = this.VerseIDAr;
    data['text'] = this.text;

    data['ayat'] = this.ayat;

    return data;
  }
}
