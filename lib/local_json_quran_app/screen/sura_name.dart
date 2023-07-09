import 'dart:convert';

import 'package:api_test/local_json_quran_app/screen/bookmark.dart';
import 'package:api_test/local_json_quran_app/screen/sura_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalSuraPage extends StatefulWidget {
  const LocalSuraPage({Key? key}) : super(key: key);

  @override
  _LocalSuraPageState createState() => _LocalSuraPageState();
}

class _LocalSuraPageState extends State<LocalSuraPage> {
  // List _itemss = [];
  List _SuraName = [];

  // Fetch content from the json file
  // Future<void> readJson() async {
  //   // final String response = await rootBundle.loadString('assets/ayats_ar.json');
  //   // final data = await json.decode(response);
  //   // setState(() {
  //   //   // _items = data;
  //   // });
  // final String responses = await rootBundle.loadString('assets/ayats_bn.json');
  //   final datas = await json.decode(responses);
  //   print(datas);
  //   setState(() {
  //     _itemss = datas;
  //   });

  // }
  Future<void> suraName(name) async {
    // final String response = await rootBundle.loadString('assets/ayats_ar.json');
    // final data = await json.decode(response);
    // setState(() {
    //   // _items = data;
    // });
    final String response = await rootBundle.loadString('assets/sura.json');
    final data = await json.decode(response);
    print(data);
    setState(() {
      _SuraName = data;
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    suraName(controller.text);
  }

  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  bool isshow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            setState(() {
              isshow = !isshow;
            });
          },
          icon: isshow
              ? Container(
                  padding: EdgeInsets.only(bottom: 0), child: Icon(Icons.close))
              : Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: isSearch
            ? Container(
                height: 40,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Enter Sura No. Or Sura Name',
                      hintStyle: TextStyle(fontSize: 15),
                      filled: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            suraName(controller.text);
                          },
                          icon: Icon(Icons.search)),
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        gapPadding: 5,
                      )),
                ),
              )
            : Text('বাংলা কুরআন'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              },
              icon: isSearch ? Icon(Icons.close) : Icon(Icons.search))
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              // ElevatedButton(
              //   child: const Text('Load Data'),
              //   onPressed: readJson,
              // ),

              // Display the data loaded from sample.json
              Expanded(
                child: ListView.builder(
                  itemCount: _SuraName.length,
                  itemBuilder: (context, index) {
                    if (controller.text.isEmpty) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocalSuraDetails(
                                        suraname: _SuraName[index]["sura_name"],
                                        suraNo: int.parse(
                                            _SuraName[index]["sura_no"]),
                                      )));
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Text(_SuraName[index]["sura_no"]),
                            title: Text(_SuraName[index]["sura_name"]),
                            subtitle: Row(
                              children: [
                                Text(
                                    'আয়ত - ${_SuraName[index]["total_ayat"]} টি'),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('পারা - ${_SuraName[index]["para"]}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (_SuraName[index]["sura_name"]
                            .contains(controller.text) ||
                        _SuraName[index]["sura_no"].contains(controller.text) ||
                        isSearch == false) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocalSuraDetails(
                                        suraname: _SuraName[index]["sura_name"],
                                        suraNo: int.parse(
                                            _SuraName[index]["sura_no"]),
                                      )));
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Text(_SuraName[index]["sura_no"]),
                            title: Text(_SuraName[index]["sura_name"]),
                            subtitle: Row(
                              children: [
                                Text(
                                    'আয়ত - ${_SuraName[index]["total_ayat"]} টি'),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('পারা - ${_SuraName[index]["para"]}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
        isshow
            ? Positioned(
                top: 490,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShowData()));
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      width: 160,
                      child: Center(child: Text('বুকমার্ক দেখুন'))),
                ),
              )
            : Container(),
        isshow
            ? Positioned(
                top: 540,
                right: 5,
                child: GestureDetector(
                  // onTap: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => ShowData()));
                  // },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      width: 160,
                      child: Center(child: Text('সর্বশেষ পাঠ দেখুন'))),
                ),
              )
            : Container()
      ]),
    );
  }
}
