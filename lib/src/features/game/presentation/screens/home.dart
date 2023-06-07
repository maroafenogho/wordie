import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/common/constants.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        leading: Container(),
      ),
      body: Container(),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
            color: WordieConstants.mainColor,
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: BottomNavigationBar(
            // type: BottomNavigationBarType.shifting,
            backgroundColor: WordieConstants.mainColor,
            items: [
              BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: '', icon: Icon(Icons.home))
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Note',
        backgroundColor: WordieConstants.mainColor,
        foregroundColor: WordieConstants.backgroundColor,
        splashColor: WordieConstants.backgroundColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     super.key,
//   });

//   // final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   int _counter = 0;
//   late Timer _timerA;
//   late Timer _timerB;
//   Effect effect = const ScaleEffect(duration: Duration(milliseconds: 100));
//   late AnimationController controller;
//   final answerController = TextEditingController();
//   final myDuration = Duration(minutes: 10);
//   final durationB = Duration(minutes: 10);
//   // final time = DateFormat.Hms(Duration(minutes: 5).toString());
//   String strDigits(int n) => n.toString().padLeft(2, '0');

//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: TextStyle(
//         fontSize: 20,
//         color: Color.fromRGBO(30, 60, 87, 1),
//         fontWeight: FontWeight.w600),
//     decoration: BoxDecoration(
//       border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );
//   final focussedPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: TextStyle(
//         fontSize: 20,
//         color: Color.fromRGBO(30, 60, 87, 1),
//         fontWeight: FontWeight.w600),
//     decoration: BoxDecoration(
//       border: Border.all(color: Color.fromRGBO(71, 166, 243, 1)),
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );
//   void _incrementCounter() {
//     setState(() {
//       // effect = ElevationEffect(delay: Duration(seconds: 5));
//       // effect = ScaleEffect(
//       //   duration: Duration(seconds: 5),
//       // );

//       controller.forward(from: 0);
//       _counter++;
//     });
//   }

//   @override
//   void initState() {
//     print(myDuration.inHours);
//     controller = AnimationController(vsync: this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       //   title: Text(widget.title),
//       // ),
//       body: Consumer(
//         builder: (BuildContext context, WidgetRef ref, Widget? child) {
//           // final refWords = ref.watch(currentWord);
//           final activeWord = ref.watch(words)[ref.watch(currentIndex)]['word'];
//           final activeWordHint =
//               ref.watch(words)[ref.watch(currentIndex)]['hint'];
//           // ref.read(currentWord.notifier).state =
//           //     words[math.Random().nextInt(1)];
//           return Container(
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(begin: Alignment.topCenter, colors: [
//               Colors.black26,
//               Colors.white12,
//             ])),
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Expanded(
//                     child: Container(
//                   decoration:
//                       BoxDecoration(border: Border.all(color: Colors.black)),
//                   alignment: Alignment.center,
//                   child: Text(
//                     '${strDigits(myDuration.inMinutes.remainder(60))}:${strDigits(myDuration.inSeconds.remainder(60))}',
//                     style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
//                   ),
//                 )),
//                 const Divider(
//                   color: Colors.black,
//                 ),
//                 Expanded(
//                     child: Container(
//                   decoration:
//                       BoxDecoration(border: Border.all(color: Colors.black)),
//                   alignment: Alignment.center,
//                   child: Text(
//                     '5:00',
//                     style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
//                   ),
//                 )),
//                 // 'thgg'.shuffle();
//                 // Text(
//                 //   activeWord!.shuffledWord.join().toString().toUpperCase(),
//                 //   textAlign: TextAlign.center,
//                 //   style: TextStyle(letterSpacing: 10, fontSize: 45),
//                 // ),
//                 // Pinput(
//                 //   length: activeWord.length,
//                 //   autofocus: true,
//                 //   defaultPinTheme: defaultPinTheme,
//                 //   focusedPinTheme: focussedPinTheme,
//                 //   controller: answerController,
//                 //   keyboardType: TextInputType.text,
//                 //   showCursor: false,
//                 //   onCompleted: (text) {
//                 //     if (text.toLowerCase() == activeWord.toLowerCase()) {
//                 //       log(ref.watch(currentIndex).toString());

//                 //       ref.read(currentIndex.notifier).state =
//                 //           math.Random().nextInt(ref.watch(words).length - 1);
//                 //       log(ref.watch(currentIndex).toString());
//                 //       ScaffoldMessenger.of(context)
//                 //           .showSnackBar(SnackBar(content: Text('correct')));
//                 //       answerController.clear();
//                 //     }
//                 //   },
//                 // ),
//                 // 40.0.vSpace,
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   children: [
//                 //     InkWell(
//                 //       onTap: () {
//                 //         showDialog(
//                 //           context: context,
//                 //           builder: (context) => AlertDialog(
//                 //             title: Text('HINT'),
//                 //             content: Text(activeWordHint!),
//                 //           ),
//                 //         );
//                 //       },
//                 //       child: Container(
//                 //         height: 50,
//                 //         width: 50,
//                 //         alignment: Alignment.center,
//                 //         decoration: BoxDecoration(
//                 //             borderRadius: BorderRadius.circular(15),
//                 //             border: Border.all(
//                 //               color: Colors.black54,
//                 //               width: 2,
//                 //             )),
//                 //         child: Icon(
//                 //           Icons.lightbulb,
//                 //           color: Colors.yellow[700],
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // )
//               ],
//             ),
//           );
//         },
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
