import 'dart:convert';

import 'package:api_test/detailsScreen.dart';
import 'package:api_test/sura_page.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'Screens/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home()));
}

/////////////////...........HomePage.dart.........//////////////

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   getdata() async {
//     try {
//       var url = 'https://alquranbd.com/api/tafheem/sura/list';
//       http.Response response = await http.get(Uri.parse(url));
//       var data = jsonDecode(response.body);
//       print(data);
//       return data;
//     } catch (err) {
//       print(err.toString());
//     }
//   }

//   var mylist = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     getsdata();
//   }

//   getsdata() async {
//     var _mylist = await getdata();
//     setState(() {
//       mylist = _mylist;
//       // print(mylist);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           padding: EdgeInsets.all(0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ListView.builder(
//                     itemCount: mylist.length,
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: ((context, index) {
//                       // var getData = mylist[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (BuildContext) => DetailsScreen(
//                                         id: mylist[index]['id'],
//                                       )));
//                         },
//                         child: Container(
//                           color:
//                               index.isEven ? Colors.grey : Colors.purpleAccent,
//                           child: ListTile(
//                             title: Text(mylist[index]['id']),
//                             subtitle: Text(mylist[index]['name']),
//                           ),
//                         ),
//                       );
//                     }))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
