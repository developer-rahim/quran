import 'package:api_test/model/sura_list_model.dart';
import 'package:api_test/service/sura_service.dart';
import 'package:flutter/material.dart';

import '../detailsScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SuraListModel> suraList = [];
  bool initialSura = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSuraList();
  }

  fetchSuraList() async {
    suraList = await SuraService().getSuraList();
    initialSura = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(backgroundColor: Colors.cyan,
        title: Text("Bangla Quran"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Icon(Icons.search),
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.more_vert)),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: ListView.builder(
              itemCount: suraList.length,
              itemBuilder: (context, index) {
                var getsuralist = suraList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  name: suraList[index].name,
                                  id: int.parse(suraList[index].id!),
                                )));
                  },
                  child: Card(
                    
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(top: 20),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                           ),
                        child: Text(
                          getsuralist.id!,
                          textAlign: TextAlign.center,
                          style: TextStyle(  color:Colors.black ),
                        ),
                      ),
                      title: Text(
                        getsuralist.name!.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
