import 'dart:io';

import 'package:api_test/model/ayat_model.dart';
import 'package:api_test/service/ayat_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailsScreen extends StatefulWidget {
  int? id;
  String? name;

  DetailsScreen({required this.id, required this.name});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<AyatListModel> ayatList = [];
  int? gobalindex = 0;
  int page = 1;
  bool isLoding = true;
  var _isInitial = true;
  ScrollController _xcrollController = ScrollController();
  bool _showLoadingContainer = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    isLoding = true;
    setState(() {
      page++;
      fatchAyatList();
    });

    print(page);
    // if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    isLoding = true;
    setState(() {
      page--;
      fatchAyatList();
    });

    _refreshController.refreshCompleted();
  }

  fatchAyatList() async {
    var data = await AyatService().getAyatService(widget.id!, page);

    setState(() {
      ayatList = data;
      isLoding = false;

      _showLoadingContainer = true;
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
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(widget.name!),
          centerTitle: true,
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                isLoding == false
                    ? ListView.builder(
                        itemCount: ayatList.length,
                        shrinkWrap: true,
                        controller: _xcrollController,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // var getAyatdata=ayatList[index];
                          SizedBox(
                            height: 20,
                          );
                          return Card(
                            elevation: 5,
                            color: Colors.white,
                            child: ListTile(
                                title: Text(ayatList[index].ayahNo!),
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
                                                ayatList[index].ayahText!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: ayatList[index].bn!.length,
                                      itemBuilder: (context, gobalindex) {
                                        return Text(
                                          ayatList[index]
                                              .bn![gobalindex]
                                              .tokenTrans!,
                                          style: TextStyle(color: Colors.black),
                                        );
                                      },
                                    )
                                  ],
                                )),
                          );

                          // title: Text(ayatList[index].ayahText!),
                          //
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                // Row(
                //   children: [
                //     ElevatedButton(
                //         onPressed: () {
                //           newMethod;
                //           print(newMethod());
                //         },
                //         child: Text('Next')),
                //     ElevatedButton(
                //         onPressed: () {
                //           newMethod2;
                //           print(newMethod2());
                //         },
                //         child: Text('Previous')),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  newMethod() {
    setState(() {
      page++;
    });
    fatchAyatList();
  }

  newMethod2() {
    setState(() {
      page--;
    });
    fatchAyatList();
  }
}
