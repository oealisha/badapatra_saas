// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class NepaliTTSNewsPage extends StatefulWidget {
//   final String title;
//   final String description;

//   const NepaliTTSNewsPage({
//     required this.title,
//     required this.description,
//     super.key,
//   });

//   @override
//   State<NepaliTTSNewsPage> createState() => _NepaliTTSNewsPageState();
// }

// class _NepaliTTSNewsPageState extends State<NepaliTTSNewsPage> {
//   late FlutterTts flutterTts;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     flutterTts = FlutterTts();
//     _initTtsAndPlay();
//   }

//   Future<void> _initTtsAndPlay() async {
//     try {
//       await flutterTts.setLanguage('ne-NP');
//       await flutterTts.setSpeechRate(0.5);

//       await flutterTts.speak(widget.description);
//       setState(() {
//         isPlaying = true;
//       });

//       flutterTts.setCompletionHandler(() {
//         setState(() {
//           isPlaying = false;
//         });
//       });

//       flutterTts.setErrorHandler((msg) {
//         print('TTS error: $msg');
//         setState(() {
//           isPlaying = false;
//         });
//       });
//     } catch (e) {
//       print('Error initializing TTS: $e');
//     }
//   }

//   @override
//   void dispose() {
//     flutterTts.stop();
//     super.dispose();
//   }

//   Future<void> _toggleSpeak() async {
//     if (isPlaying) {
//       await flutterTts.stop();
//       setState(() => isPlaying = false);
//     } else {
//       await flutterTts.speak(widget.description);
//       setState(() => isPlaying = true);
//     }
//   }

//   Widget buildTable() {
//     // Split description by line to simulate row data
//     final lines = widget.description.split('\n');

//     return Table(
//       border: TableBorder.all(color: Colors.blue.shade100),
//       columnWidths: const {0: FixedColumnWidth(60), 1: FlexColumnWidth()},
//       children: [
//         TableRow(
//           decoration: const BoxDecoration(color: Color(0xFFE51C23)),
//           children: const [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "क्र.स",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "सेवाको विवरण",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         for (int i = 0; i < lines.length; i++)
//           TableRow(
//             decoration: BoxDecoration(
//               color: i % 2 == 0 ? Colors.pink[50] : Colors.pink[100],
//             ),
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   '${i + 1}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(lines[i]),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 5,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             flutterTts.stop();
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           widget.title,
//           style: const TextStyle(color: Colors.black),
//           overflow: TextOverflow.ellipsis,
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isPlaying ? Icons.stop : Icons.volume_up,
//               color: Colors.black,
//             ),
//             onPressed: _toggleSpeak,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: buildTable(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bada_patra_task/l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nepali TTS News',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ne'), // Nepali
      ],
      home: const NepaliTTSNewsPage(
        title: "सेवाको किसिम", // Example title
        description: "यो सेवा विवरण हो", // Example description
      ),
    );
  }
}

class NepaliTTSNewsPage extends StatefulWidget {
  final String title;
  final String description;

  const NepaliTTSNewsPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _NepaliTTSNewsPageState createState() => _NepaliTTSNewsPageState();
}

class _NepaliTTSNewsPageState extends State<NepaliTTSNewsPage> {
  @override
  Widget build(BuildContext context) {
    // Using null-aware operator just in case (should not be null if setup correctly)
    final t = AppLocalizations.of(context);

    if (t == null) {
      return const Scaffold(
        body: Center(child: Text('Localization data not available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            border: TableBorder.all(color: Colors.red.shade100),
            columnWidths: const {
              0: FixedColumnWidth(40), // क्र.सं.
              1: FixedColumnWidth(150), // सेवाको किसिम
              2: FixedColumnWidth(400), // सेवा विवरण
              3: FixedColumnWidth(60), // शुल्क
              4: FixedColumnWidth(100), // समय
              5: FixedColumnWidth(100), // शाखा
              6: FixedColumnWidth(100), // गुनासो
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Table Header
              TableRow(
                decoration: BoxDecoration(color: Colors.red.shade800),
                children: [
                  _headerCell(t.idNo),
                  _headerCell(t.serviceType),
                  _headerCell(t.serviceRequirement),
                  _headerCell(t.price),
                  _headerCell(t.time),
                  _headerCell(t.serviceBranch),
                  _headerCell(t.commentSection),
                ],
              ),
              // Table Row Data
              TableRow(
                decoration: BoxDecoration(color: Colors.pink.shade50),
                children: [
                  _dataCell("१"),
                  _dataCell(widget.title),
                  _dataCell(widget.description),
                  _dataCell("२५०/-"),
                  _dataCell("सोही दिन तुरुन्तै"),
                  _dataCell("वडा कार्यालय"),
                  _dataCell("-"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCell(String text) => Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
    ),
  );

  Widget _dataCell(String text) => Padding(
    padding: const EdgeInsets.all(8),
    child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
  );
}
