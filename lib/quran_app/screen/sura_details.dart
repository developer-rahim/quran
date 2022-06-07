import 'dart:convert';

import 'package:api_test/main.dart';
import 'package:api_test/quran_app/database/db_model.dart';
import 'package:api_test/quran_app/database/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bookmark.dart';

class SuraDetails extends StatefulWidget {
  String? suraname;
  int? suraNo;

  SuraDetails({
    this.suraname,
    this.suraNo,
  });

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  List suraArList = [];
  List suraBnList = [];
  Future<void> suraAr(VerseIDAr) async {
    // final String response = await rootBundle.loadString('assets/ayats_ar.json');
    // final data = await json.decode(response);
    // setState(() {
    //   // _items = data;
    // });
    final String response = await rootBundle.loadString('assets/ayats_ar.json');
    final data = await json.decode(response);
    //print(data);

    setState(() {
      suraArList = data;
    });
  }

  Future<void> suraBn() async {
    // final String response = await rootBundle.loadString('assets/ayats_ar.json');
    // final data = await json.decode(response);
    // setState(() {
    //   // _items = data;
    // });
    final String response = await rootBundle.loadString('assets/ayats_bn.json');
    final data = await json.decode(response);
    print(data);

    setState(() {
      suraBnList = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suraAr(controller.text);
    suraBn();

    print(suraBn());
  }

  bool isSearch = false;
  bool isshow = false;
  var textbn;
  var textar;
  var verseIDar;
  var suraNo;
  var suraNama;
  var uniqId;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: isSearch
            ? Container(
                height: 40,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Enter Ayet No.',
                      hintStyle: TextStyle(fontSize: 15),
                      filled: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            suraAr(controller.text);
                          },
                          icon: Icon(Icons.search)),
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        gapPadding: 5,
                      )),
                ),
              )
            : Text(widget.suraname!),
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
        Column(
          children: [
            suraArList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: suraArList.length,
                      itemBuilder: (context, index) {
                        if (widget.suraNo.toString() ==
                            (suraArList[index]["sura"])) {
                          if (controller.text.isEmpty) {
                            return GestureDetector(
                              onLongPress: () {
                                _showText(context);
                                textar = suraArList[index]["ayat"];
                                textbn = suraBnList[index]["text"];
                                verseIDar = suraArList[index]["VerseIDAr"];
                                suraNo = suraArList[index]["sura"];
                                suraNama = widget.suraname!;
                                 uniqId=suraArList[index]['id'];
                                print(textar);
                                print(textbn);
                                print(uniqId);
                              },
                              child: Card(
                                margin: const EdgeInsets.all(10),
                                child: ListTile(
                                  //  leading: Text(suraArList[index]["sura_no"]),
                                  title: Text(suraArList[index]["VerseIDAr"],
                                      style: TextStyle(
                                          fontSize: fontsize,
                                          color: Colors.black)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Text(
                                                    suraArList[index]["ayat"],
                                                    style: TextStyle(
                                                        fontSize: fontsize,
                                                        color: Colors.black))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              suraBnList[index]["text"],
                                              style: TextStyle(
                                                  fontSize: fontsize,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //     SizedBox(
                                      //       width: 15,
                                      //     ),
                                      //     Text('পারা - ${suraArList[index]["para"]}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (suraArList[index]["VerseIDAr"]
                                  .contains(controller.text) ||
                              isSearch == false) {
                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                //  leading: Text(suraArList[index]["sura_no"]),
                                title: Text(suraArList[index]["VerseIDAr"],
                                    style: TextStyle(
                                        fontSize: fontsize,
                                        color: Colors.black)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                  suraArList[index]["ayat"],
                                                  style: TextStyle(
                                                      fontSize: fontsize,
                                                      color: Colors.black))),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            suraBnList[index]["text"],
                                            style: TextStyle(
                                                fontSize: fontsize,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //     SizedBox(
                                    //       width: 15,
                                    //     ),
                                    //     Text('পারা - ${suraArList[index]["para"]}'),
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        return Container();
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
        isshow
            ? Positioned(
                top: 500,
                right: 5,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (fontsize == 12.0) {
                              } else {
                                setState(() {
                                  fontsize--;
                                });
                              }
                            },
                            icon: Container(
                                padding: EdgeInsets.only(bottom: 28),
                                child: Icon(
                                  Icons.minimize,
                                  color: Colors.white,
                                ))),
                        Text(
                          fontsize.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Container(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  fontsize++;
                                });
                              },
                              icon: Container(
                                  child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ))),
                        )
                      ],
                    )),
              )
            : Container()
      ]),
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
    );
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(
        ClipboardData(text: "'${verseIDar}' \n '${textar}' \n '${textbn}'"));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  _showText(BuildContext context) {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 225,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'আয়ত টি...',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: GestureDetector(
                      onTap: () {
                        _copyToClipboard();
                      },
                      child: Card(
                          shadowColor: Colors.black,
                          elevation: 10,
                          child: Container(
                              width: 200,
                              padding: EdgeInsets.all(10),
                              child: Center(child: Text('কপি করুন')))),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await DBHelper().saveToAddressList(AddAddressModel(
                          sura: uniqId,
                          sura_name: suraNama.toString(),
                          VerseIDAr: verseIDar,
                          text: textbn,
                          ayat: textar

                          // city:verseIDar ,
                          // houseNo: suraNama.toString(),
                          // mobileNo: suraNo,
                          // fname: textar,
                          // lname: textbn

                          // city: valueChoose,
                          // fname: firstNameCtlr.text,
                          // lname: lastNameCtlr.text,
                          // houseNo: houseNoCtlr.text,
                          // mobileNo: mobileNoCtlr.text

                          ));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('বুকমার্ক এ সংরক্ষন করা হয়েছে'),
                      ));
                      // print('Indert data');

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => ShowData()));
                    },
                    child: Card(
                        shadowColor: Colors.black,
                        elevation: 10,
                        child: Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text('বুকমার্ক এ সংরক্ষন করুন'),
                            ))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                      shadowColor: Colors.black,
                      elevation: 10,
                      child: Container(
                          width: 200,
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text('সর্বশেষ পাঠ নির্বাচন করুন '),
                          ))),
                ],
              ),
            ),
            actions: <Widget>[
              Card(
                shadowColor: Colors.black,
                elevation: 20,
                child: new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text("OK"),
                    )),
              )
            ],
          );
        });
  }
}
