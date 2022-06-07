import 'package:api_test/floating_action/button_action.dart';
import 'package:api_test/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  int? id;
  var name;

  HomePage({required this.id, required this.name});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // At the beginning, we fetch the first 20 posts
  int _page = 1;
  int _limit = 20;
  double _value = 0.0;
  bool _slider = false;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad(id) async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(Uri.parse(
          'https://alquranbd.com/api/tafheem/suraData/${widget.id}/$_page'));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res = await http.get(Uri.parse(
            'https://alquranbd.com/api/tafheem/suraData/${widget.id}/$_page'));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.length > 0) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    AppBartitle();
    _firstLoad(controller.text);
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  AppBartitle() {
    appBarTitle = new Text(widget.name!);
  }

  Widget? appBarTitle;
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: isSearch
            ? Container(
                height: 40,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Enter Ayet No.',
                      filled: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            _firstLoad(controller.text);
                          },
                          icon: Icon(Icons.search)),
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        gapPadding: 5,
                      )),
                ),
              )
            : appBarTitle,
        actions: [
          Container(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                      // _firstLoad(controller.text);
                    });
                  },
                  icon: isSearch ? Icon(Icons.close) : Icon(Icons.search)))
        ],
      ),
      body: _isFirstLoadRunning
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _controller,
                          itemCount: _posts.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            if (controller.text.isEmpty || isSearch==false) {
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: ListTile(
                                  title: Text(
                                    _posts[index]['ayah_no']!,
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                  // title: Text(
                                  //   _posts[index]["ayah_text"],
                                  //   style: TextStyle(fontSize: fontsize),
                                  // ),
                                  subtitle: ListView.builder(
                                    itemCount: _posts[index]['bn']!.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, gobalindex) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(width: double.infinity,
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Directionality( textDirection: TextDirection.rtl,
                                                  child: Text(
                                                    _posts[index]["ayah_text"],
                                                    style:
                                                        TextStyle(fontSize: fontsize),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            _posts[index]['bn'][gobalindex]
                                                ["token_trans"],
                                            style:
                                                TextStyle(fontSize: fontsize),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else if (_posts[index]['ayah_no']!
                                    .contains(controller.text) &&
                                _hasNextPage == true) {
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: ListTile(
                                  leading: Text(
                                    _posts[index]['ayah_no']!,
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                  title: Text(
                                    _posts[index]["ayah_text"],
                                    style: TextStyle(fontSize: fontsize),
                                  ),
                                  subtitle: ListView.builder(
                                    itemCount: _posts[index]['bn']!.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, gobalindex) {
                                      return Text(
                                        _posts[index]['bn'][gobalindex]
                                            ["token_trans"],
                                        style: TextStyle(fontSize: fontsize),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                            return Container(
                                // child: Text('no match'),
                                );
                          }),
                    ),

                    // when the _loadMore function is running
                    if (_isLoadMoreRunning == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    // When nothing else to load
                    if (_hasNextPage == false)
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.yellow[100],
                        child: Center(
                          child: Text('You have fetched all of the content'),
                        ),
                      ),
                  ],
                ),
              ),
              isshow
                  ? Positioned(
                      top: 550,
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
                                    setState(() {
                                      fontsize--;
                                    });
                                  },
                                  icon: Container(
                                      padding: EdgeInsets.only(bottom: 28),
                                      child: Icon(
                                        Icons.minimize,
                                        color: Colors.white,
                                      ))),
                              Text(
                                'Zoom',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
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

  bool isshow = false;
}
