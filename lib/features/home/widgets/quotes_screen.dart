// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../home_screen.dart';
//
// class QuotesScreen extends StatefulWidget {
//   const QuotesScreen({super.key});
//
//   @override
//   State<QuotesScreen> createState() => _QuotesScreenState();
// }
//
// class _QuotesScreenState extends State<QuotesScreen> {
//   int colorEffectIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return  GestureDetector(
//       onDoubleTap: () {
//         setState(() {
//           colorEffectIndex =
//               (colorEffectIndex + 1) % colorsAndEffects.length;
//         });
//       },
//       // child:
//       // Container(
//       //   decoration: const BoxDecoration(
//       //       gradient: RadialGradient(
//       //           center: Alignment.bottomCenter,
//       //           radius: 1.5,
//       //           colors: [
//       //         Color.fromARGB(255, 13, 35, 61),
//       //         Colors.black,
//       //       ])),
//       //   child: Metaballs(
//       //     effect: colorsAndEffects[colorEffectIndex].effect,
//       //     glowRadius: 1,
//       //     glowIntensity: 0.6,
//       //     maxBallRadius: 50,
//       //     minBallRadius: 20,
//       //     metaballs: 40,
//       //     color: Colors.grey,
//       //     gradient: LinearGradient(
//       //         colors: colorsAndEffects[colorEffectIndex].colors,
//       //         begin: Alignment.bottomRight,
//       //         end: Alignment.topLeft),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height - 50,
//               color: Colors.black,
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: ExpandingCards(
//                   height: 400,
//                   items: items,
//                 ),
//               ),
//             ),
//             Center(
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: ExpandingCards(
//                   height: 400,
//                   items: items,
//                 ),
//               ),
//             ),
//             Center(
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: ExpandingCards(
//                   height: 400,
//                   items: items,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // ),
//       // ),
//     ),
//   }
// }
