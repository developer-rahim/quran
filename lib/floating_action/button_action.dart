// import 'package:api_test/main.dart';
// import 'package:flutter/material.dart';

// class ButtonAction extends StatefulWidget {
//   int position = 250;
//   ButtonAction({this.position = 250});

//   @override
//   State<ButtonAction> createState() => _ButtonActionState();
// }

// class _ButtonActionState extends State<ButtonAction> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Positioned(
//         top: widget.position.toDouble(),
//         right: 0,
//         child: GestureDetector(
//           onTap: () {},
//           child: Container(
//             height: 100,
//             width: 100,
//             decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(0))),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 0, top: 0),
//               child: Center(
//                   child: Container(
//                 child: Column(
//                   children: [
//                     Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: Text('Fontsize' ,style: TextStyle(fontSize: 18,color: Colors.black,),)),
//                         Row(children: [
//                           IconButton(onPressed: (){
//                             setState(() {
//                               fontsize--;
//                               print(' fontsize:${fontsize}');
//                             });
//                           }, icon: Icon(Icons.add))
//                         ],)
//                   ],
//                 ),
//               )

//                   //  RichText(
//                   //   text: TextSpan(
//                   //     // text: 'Chat  ',
//                   //     // style: TextStyle(
//                   //     //     fontSize: 16,
//                   //     //     fontWeight: FontWeight.w600,
//                   //     //     color: Colors.black),
//                   //     children: [
//                   //       WidgetSpan(
//                   //         child: RotatedBox(
//                   //             quarterTurns: -2,
//                   //             child: Text(
//                   //               '  Font',
//                   //               style: TextStyle(
//                   //                   fontSize: 16,
//                   //                   fontWeight: FontWeight.w600,
//                   //                   color: Colors.white),
//                   //             )

//                   //             //  Icon(
//                   //             //   Icons.message,
//                   //             //   color: Colors.green,
//                   //             //   size: 20,
//                   //             // )
//                   //             ),
//                   //       ),
//                   //       WidgetSpan(
//                   //         child: RotatedBox(
//                   //             quarterTurns: 1,
//                   //             child:
//                   //             Container(width: 23,
//                   //               height: 23,padding: EdgeInsets.only(right: 00),
//                   //               // color: Colors.amber,
//                   //               child: Image.asset('assets/live_chat.png'))

//                   //             ),
//                   //       ),
//                   //   ],
//                   // ),
//                   ),
//             ),
//           ),
//         ),
//       ),
//     ]);
//   }
// }
