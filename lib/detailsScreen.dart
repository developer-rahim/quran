import 'dart:io';

import 'package:api_test/model/ayat_model.dart';
import 'package:api_test/service/ayat_service.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  int? id;
  String? name;

  DetailsScreen({
    required this.id,
    required this.name
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<AyatListModel> ayatList = [];
  int? gobalindex = 0;
  int page = 1;
  bool isLoding = true;

  fatchAyatList() async {
    ayatList = await AyatService().getAyatService(widget.id!, page);
    setState(() {
      isLoding = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fatchAyatList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan,
          title: Text(widget.name!),
          centerTitle: true,
        ),
        body: Column(
          children: [SizedBox(height: 20,),
            ListView.builder(
                itemCount: ayatList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // var getAyatdata=ayatList[index];
                 SizedBox(height: 20,);
                  return Card(
                   
                    elevation: 5,color: Colors.white,
                    child: ListTile(
                        title: Text(ayatList[index].ayahNo!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(width: double.infinity,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Directionality(textDirection: TextDirection.rtl,
                                    child: Text(ayatList[index].ayahText! ,style: TextStyle(color: Colors.black),)),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ayatList[index].bn!.length,
                              itemBuilder: (context, gobalindex) {
                                return Text(
                                    ayatList[index].bn![gobalindex].tokenTrans!,style: TextStyle(color: Colors.black),);
                              },
                            )
                          ],
                        )),
                  );

                  // title: Text(ayatList[index].ayahText!),
                  //
                }),
          ],
        ),
      ),
    );
  }
}
