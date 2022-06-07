import 'package:api_test/quran_app/database/db_model.dart';
import 'package:api_test/quran_app/database/dbhelper.dart';
import 'package:api_test/quran_app/screen/sura_details.dart';

import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List<AddAddressModel> addresses = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddresse();
  }

  getAddresse() async {
    var ad = await DBHelper().getAddresses();
    setState(() {
      addresses = ad;
    });
    print(addresses);
    return ad;
  }
deletedata()async{

}
var delete;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text("বুকমার্ক "),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListView.builder(
              itemCount: addresses.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: ListTile(
                    title: Text(addresses[index].sura_name!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('আয়ত - ${addresses[index].VerseIDAr.toString()}'),
                        Text(addresses[index].ayat),
                        Text(addresses[index].text)
                      ],
                    ),
                  ),
                );
              }),
        ),
      )),
    );
  }
}
