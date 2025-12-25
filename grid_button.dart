// //DONE*
// //THIS IS NEWS GRID BUTTON PAGE
// //AFTER THIS NEWS PRESENTER PAGE WILL OPEN
//Original:

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:marquee/marquee.dart';
// import './news_presenter.dart';

// void main() =>
//     runApp(MaterialApp(debugShowCheckedModeBanner: false, home: GridButton()));

// class GridButton extends StatefulWidget {
//   @override
//   _GridButtonState createState() => _GridButtonState();
// }

// class _GridButtonState extends State<GridButton> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;
//   final double _scrollSpeed = 0.5;
//   int _focusedIndex = -1;

//   final List<Map<String, dynamic>> baseItems = [
//     {'icon': Icons.business, 'title': 'व्यवसाय दर्ता', 'color': Colors.red},
//     {'icon': Icons.school, 'title': 'शैक्षिक सिफारिस', 'color': Colors.orange},
//     {
//       'icon': Icons.family_restroom,
//       'title': 'नाता प्रमाणित',
//       'color': Colors.purple,
//     },
//     {'icon': Icons.home, 'title': 'घर प्रमाणित', 'color': Colors.blue},
//     {'icon': Icons.route, 'title': 'बाटो सिफारिस', 'color': Colors.green},
//     {'icon': Icons.medical_services, 'title': 'औषधि', 'color': Colors.teal},
//     {'icon': Icons.info, 'title': 'व्यक्तिगत विवरण', 'color': Colors.amber},
//     {'icon': Icons.handshake, 'title': 'सम्झौता सिफारिस', 'color': Colors.pink},
//     {'icon': Icons.flag, 'title': 'राष्ट्रियता', 'color': Colors.cyan},
//     {
//       'icon': Icons.child_care,
//       'title': 'सन्तान प्रमाणित',
//       'color': Colors.deepOrange,
//     },
//     {'icon': Icons.volunteer_activism, 'title': 'अंगदान', 'color': Colors.lime},
//     {'icon': Icons.gavel, 'title': 'कोर्ट सिफारिस', 'color': Colors.indigo},
//     {
//       'icon': Icons.location_city,
//       'title': 'संस्थागत सिफारिस',
//       'color': Colors.brown,
//     },
//     {
//       'icon': Icons.traffic,
//       'title': 'यातायात सिफारिस',
//       'color': Colors.lightGreen,
//     },
//     {
//       'icon': Icons.favorite,
//       'title': 'विवाह प्रमाणित',
//       'color': Colors.redAccent,
//     },
//     {
//       'icon': Icons.directions_bus,
//       'title': 'बस सेवा',
//       'color': Colors.deepPurple,
//     },
//     {'icon': Icons.map, 'title': 'नक्शा सिफारिस', 'color': Colors.lightBlue},
//     {'icon': Icons.factory, 'title': 'उद्योग सिफारिस', 'color': Colors.grey},
//     {'icon': Icons.park, 'title': 'वन सेवा', 'color': Colors.greenAccent},
//     {
//       'icon': Icons.school_outlined,
//       'title': 'विद्यालय सिफारिस',
//       'color': Colors.blueAccent,
//     },
//     {
//       'icon': Icons.holiday_village,
//       'title': 'छुट सिफारिस',
//       'color': Colors.orangeAccent,
//     },
//     {'icon': Icons.email, 'title': 'पत्राचार', 'color': Colors.purpleAccent},
//     {
//       'icon': Icons.health_and_safety,
//       'title': 'स्वास्थ्य सिफारिस',
//       'color': Colors.tealAccent,
//     },
//     {
//       'icon': Icons.language,
//       'title': 'भाषा सिफारिस',
//       'color': Colors.cyanAccent,
//     },
//     {
//       'icon': Icons.money,
//       'title': 'आर्थिक सिफारिस',
//       'color': Colors.amberAccent,
//     },
//   ];

//   List<Map<String, dynamic>> get items => baseItems;

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(Duration(milliseconds: 30), (_) {
//       if (_scrollController.hasClients) {
//         final max = _scrollController.position.maxScrollExtent;
//         final curr = _scrollController.offset;
//         _scrollController.jumpTo(curr < max ? curr + _scrollSpeed : 0);
//       }
//     });
//   }

//   Future<void> _playAudio() async {
//     try {
//       await _audioPlayer.play(AssetSource('audio/nepali.mp3'));
//     } catch (e) {
//       print('Audio error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _scrollController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final crossAxisCount =
//         screenWidth > 1000
//             ? 8
//             : screenWidth > 600
//             ? 4
//             : 3;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header Section
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset('assets/images/logonepal.jpg', height: 60),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'भानु नगरपालिका',
//                               style: TextStyle(
//                                 color: Color(0xFFcd0711),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'नगर कार्यपालिकाको कार्यालय',
//                               style: TextStyle(
//                                 color: Color(0xFFcd0711),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'तनहुँ',
//                               style: TextStyle(
//                                 color: Color(0xFF2056ae),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Flexible(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 height: 90,
//                                 padding: EdgeInsets.all(4),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFF1EEEE),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: Color(0xFFDBD8D8),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: FittedBox(
//                                   fit: BoxFit.scaleDown,
//                                   alignment: Alignment.centerLeft,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       _buildInfoRow(
//                                         Icons.phone,
//                                         '०६५-४२६६३०',
//                                         Colors.red,
//                                         12,
//                                       ),
//                                       _buildInfoRow(
//                                         Icons.language,
//                                         'bhanu.gov.np',
//                                         Colors.blue,
//                                         12,
//                                       ),
//                                       _buildInfoRow(
//                                         Icons.email,
//                                         'bhanu@gmail.com',
//                                         Colors.green,
//                                         12,
//                                       ),
//                                       _buildInfoRow(
//                                         Icons.phone,
//                                         '०६५-४२६०३८',
//                                         Colors.amber,
//                                         12,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Opacity(
//                               opacity:
//                                   0.5, // Change this value (0.0 to 1.0) to adjust transparency
//                               child: Image.asset(
//                                 'assets/images/flag1.gif',
//                                 height: 60,
//                                 width: 40,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),

//             // News Marquee
//             Container(
//               width: double.infinity,
//               height: 26,
//               color: Color(0xFF2E64C7),
//               child: Row(
//                 children: [
//                   Material(
//                     color: Color(0xFF233072),
//                     child: Container(
//                       height: 16,
//                       width: 130,
//                       alignment: Alignment.center,
//                       child: Text(
//                         '📢 सूचनाहरु:',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.yellow,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Marquee(
//                       text:
//                           '🔴 Latest Updates: Flutter 4.0 released! | Nepal ranks top in tourism | AI advancements reshape industries',
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       velocity: 38.0,
//                       blankSpace: 20,
//                     ),
//                   ),
//                   Material(
//                     color: Color(0xFFDC688F),
//                     borderRadius: BorderRadius.circular(8),
//                     child: Container(
//                       height: 14,
//                       width: 80,
//                       alignment: Alignment.center,
//                       child: Text(
//                         TimeOfDay.now().format(context),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 8,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 8),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: GridView.builder(
//                   controller: _scrollController,
//                   itemCount: 64,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.9,
//                   ),
//                   itemBuilder: (context, index) {
//                     final item = items[index % items.length];
//                     final bool isFocused = _focusedIndex == index;

//                     return FocusableActionDetector(
//                       autofocus: index == 0,
//                       onShowFocusHighlight:
//                           (focused) => setState(
//                             () => _focusedIndex = focused ? index : -1,
//                           ),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(8),
//                         onTap: () async {
//                           await _playAudio();
//                           await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder:
//                                   (context) => NewsPresenterPage(
//                                     serialNumber: index + 1,
//                                   ),
//                             ),
//                           );
//                           await _audioPlayer.stop();
//                         },
//                         child: AnimatedContainer(
//                           duration: Duration(milliseconds: 150),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: Color(0xFFDBD8D8),
//                               width: 1,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 4,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           padding: const EdgeInsets.all(4),
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   item['icon'],
//                                   size: 30,
//                                   color: item['color'],
//                                 ),
//                                 SizedBox(height: 6),
//                                 Text(
//                                   item['title'],
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//     IconData icon,
//     String text,
//     Color bgColor,
//     double fontSize,
//   ) {
//     return Row(
//       children: [
//         CircleAvatar(
//           backgroundColor: bgColor,
//           radius: 10,
//           child: Icon(icon, size: 12, color: Colors.white),
//         ),
//         SizedBox(width: 4),
//         Text(text, style: TextStyle(fontSize: fontSize, color: Colors.black)),
//       ],
//     );
//   }
// }

//#######################################################################//
//Parallel with wara_badapatra:
//API INTEGRATION:
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:marquee/marquee.dart';
// import 'package:http/http.dart' as http;
// import 'news_presenter.dart';

// void main() =>
//     runApp(MaterialApp(debugShowCheckedModeBanner: false, home: GridButton()));

// class GridButton extends StatefulWidget {
//   @override
//   _GridButtonState createState() => _GridButtonState();
// }

// class _GridButtonState extends State<GridButton> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;
//   final double _scrollSpeed = 0.5;
//   int _focusedIndex = -1;

//   List<Map<String, dynamic>> items = []; // API data will go here

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//     fetchGridItems();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(Duration(milliseconds: 30), (_) {
//       if (_scrollController.hasClients) {
//         final max = _scrollController.position.maxScrollExtent;
//         final curr = _scrollController.offset;
//         _scrollController.jumpTo(curr < max ? curr + _scrollSpeed : 0);
//       }
//     });
//   }

//   Future<void> _playAudio() async {
//     try {
//       await _audioPlayer.play(AssetSource('audio/nepali.mp3'));
//     } catch (e) {
//       print('Audio error: $e');
//     }
//   }

//   Future<void> fetchGridItems() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
//         headers: {'userid': '7', 'org_code': 'Bhanu8'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)['data'] as List;
//         setState(() {
//           items =
//               data
//                   .map(
//                     (e) => {
//                       'title': e['service_typename'] ?? 'No title',
//                       'icon': Icons.business, // static icon for now
//                     },
//                   )
//                   .toList();
//         });
//       } else {
//         print('Failed to fetch grid items');
//       }
//     } catch (e) {
//       print('Error fetching grid items: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _scrollController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final crossAxisCount =
//         screenWidth > 1000
//             ? 8
//             : screenWidth > 600
//             ? 4
//             : 3;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header Section
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset('assets/images/logonepal.jpg', height: 60),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'भानु नगरपालिका',
//                           style: TextStyle(
//                             color: Color(0xFFcd0711),
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'नगर कार्यपालिकाको कार्यालय',
//                           style: TextStyle(
//                             color: Color(0xFFcd0711),
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'तनहुँ',
//                           style: TextStyle(
//                             color: Color(0xFF2056ae),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // News Marquee
//             Container(
//               width: double.infinity,
//               height: 26,
//               color: Color(0xFF2E64C7),
//               child: Row(
//                 children: [
//                   Material(
//                     color: Color(0xFF233072),
//                     child: Container(
//                       height: 16,
//                       width: 130,
//                       alignment: Alignment.center,
//                       child: Text(
//                         '📢 सूचनाहरु:',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.yellow,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Marquee(
//                       text:
//                           '🔴 Latest Updates: Flutter 4.0 released! | Nepal ranks top in tourism | AI advancements reshape industries',
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       velocity: 38.0,
//                       blankSpace: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 8),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: GridView.builder(
//                   controller: _scrollController,
//                   itemCount: items.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.9,
//                   ),
//                   itemBuilder: (context, index) {
//                     final item = items[index];
//                     return InkWell(
//                       borderRadius: BorderRadius.circular(8),
//                       onTap: () async {
//                         await _playAudio();
//                         await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => NewsPresenterPage(
//                                   serviceTypeName: item['title'],
//                                 ),
//                           ),
//                         );
//                         await _audioPlayer.stop();
//                       },
//                       child: AnimatedContainer(
//                         duration: Duration(milliseconds: 150),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             color: Color(0xFFDBD8D8),
//                             width: 1,
//                           ),
//                         ),
//                         padding: const EdgeInsets.all(4),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(item['icon'], size: 30, color: Colors.blue),
//                               SizedBox(height: 6),
//                               Text(
//                                 item['title'],
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//########################################################################//

// //TEST:
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:marquee/marquee.dart';
// import 'package:http/http.dart' as http;
// import '../services/hive_service.dart';
// import '../models/service.dart';
// import 'news_presenter.dart';

// void main() =>
//     runApp(MaterialApp(debugShowCheckedModeBanner: false, home: GridButton()));

// class GridButton extends StatefulWidget {
//   @override
//   _GridButtonState createState() => _GridButtonState();
// }

// class _GridButtonState extends State<GridButton> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;
//   final double _scrollSpeed = 0.5;

//   List<Map<String, dynamic>> items = [];

//   final List<Map<String, dynamic>> baseItems = [
//     {'icon': Icons.business, 'color': Colors.red},
//     {'icon': Icons.school, 'color': Colors.orange},
//     {'icon': Icons.family_restroom, 'color': Colors.purple},
//     {'icon': Icons.home, 'color': Colors.blue},
//     {'icon': Icons.route, 'color': Colors.green},
//     {'icon': Icons.medical_services, 'color': Colors.teal},
//     {'icon': Icons.info, 'color': Colors.amber},
//     {'icon': Icons.handshake, 'color': Colors.pink},
//     {'icon': Icons.flag, 'color': Colors.cyan},
//     {'icon': Icons.child_care, 'color': Colors.deepOrange},
//     {'icon': Icons.volunteer_activism, 'color': Colors.lime},
//     {'icon': Icons.gavel, 'color': Colors.indigo},
//     {'icon': Icons.location_city, 'color': Colors.brown},
//     {'icon': Icons.traffic, 'color': Colors.lightGreen},
//     {'icon': Icons.favorite, 'color': Colors.redAccent},
//     {'icon': Icons.directions_bus, 'color': Colors.deepPurple},
//     {'icon': Icons.map, 'color': Colors.lightBlue},
//     {'icon': Icons.factory, 'color': Colors.grey},
//     {'icon': Icons.park, 'color': Colors.greenAccent},
//     {'icon': Icons.school_outlined, 'color': Colors.blueAccent},
//     {'icon': Icons.holiday_village, 'color': Colors.orangeAccent},
//     {'icon': Icons.email, 'color': Colors.purpleAccent},
//     {'icon': Icons.health_and_safety, 'color': Colors.tealAccent},
//     {'icon': Icons.language, 'color': Colors.cyanAccent},
//     {'icon': Icons.money, 'color': Colors.amberAccent},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//     _loadCachedOrFetchData();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(Duration(milliseconds: 30), (_) {
//       if (_scrollController.hasClients) {
//         final max = _scrollController.position.maxScrollExtent;
//         final curr = _scrollController.offset;
//         _scrollController.jumpTo(curr < max ? curr + _scrollSpeed : 0);
//       }
//     });
//   }

//   Future<void> _playAudio() async {
//     try {
//       await _audioPlayer.play(AssetSource('audio/nepali.mp3'));
//     } catch (e) {
//       print('Audio error: $e');
//     }
//   }

//   /// Load cached data first; fetch from API anyway to refresh if needed
//   Future<void> _loadCachedOrFetchData() async {
//     final cachedServices = HiveService.getServices();
//     if (cachedServices.isNotEmpty) {
//       _updateGridItems(cachedServices);
//     }

//     // Refresh API and update cache if changes exist
//     await _fetchAndCacheGridItems();
//   }

//   void _updateGridItems(List<Service> services) {
//     setState(() {
//       final uniqueTitles =
//           services.map((s) => s.serviceTypeName).toSet().toList();
//       items = List.generate(uniqueTitles.length, (index) {
//         final iconData = baseItems[index % baseItems.length]['icon'];
//         final colorData = baseItems[index % baseItems.length]['color'];
//         return {
//           'title': uniqueTitles[index],
//           'icon': iconData,
//           'color': colorData,
//         };
//       });
//     });
//   }

//   /// Fetch API data and save to Hive only if there are new/changed items
//   Future<void> _fetchAndCacheGridItems() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)['data'] as List;
//         final List<Service> apiServices =
//             data.map((item) {
//               return Service(
//                 code: item['code'] ?? '',
//                 serviceTypeName:
//                     (item['service_typename'] ?? '')
//                         .replaceAll(RegExp(r'\(.*?\)'), '')
//                         .trim(),
//                 serviceRecDetail: item['service_recdetail'] ?? '',
//                 fee: item['fee'] ?? '',
//                 time: item['time'] ?? '',
//                 serviceProvider: item['service_provider'] ?? '',
//                 complainListen: item['complain_listen'] ?? '',
//               );
//             }).toList();

//         // Compare with cached services
//         final cachedServices = HiveService.getServices();
//         bool hasChanges = false;

//         for (var apiService in apiServices) {
//           final match = cachedServices.firstWhere(
//             (s) => s.code == apiService.code,
//             orElse:
//                 () => Service(
//                   code: '',
//                   serviceTypeName: '',
//                   serviceRecDetail: '',
//                   fee: '',
//                   time: '',
//                   serviceProvider: '',
//                   complainListen: '',
//                 ),
//           );

//           if (match.code.isEmpty ||
//               match.toJson().toString() != apiService.toJson().toString()) {
//             hasChanges = true;
//             break;
//           }
//         }

//         // Save only if there are changes
//         if (hasChanges) {
//           await HiveService.saveServices(apiServices);
//         }

//         _updateGridItems(apiServices);
//       } else {
//         print('Failed to fetch grid items');
//       }
//     } catch (e) {
//       print('Error fetching grid items: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _scrollController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final crossAxisCount =
//         screenWidth > 1000
//             ? 8
//             : screenWidth > 600
//             ? 4
//             : 3;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset('assets/images/logonepal.jpg', height: 60),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'भानु नगरपालिका',
//                           style: TextStyle(
//                             color: Color(0xFFcd0711),
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'नगर कार्यपालिकाको कार्यालय',
//                           style: TextStyle(
//                             color: Color(0xFFcd0711),
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'तनहुँ',
//                           style: TextStyle(
//                             color: Color(0xFF2056ae),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Marquee
//             Container(
//               width: double.infinity,
//               height: 26,
//               color: Color(0xFF2E64C7),
//               child: Row(
//                 children: [
//                   Material(
//                     color: Color(0xFF233072),
//                     child: Container(
//                       height: 16,
//                       width: 130,
//                       alignment: Alignment.center,
//                       child: Text(
//                         '📢 सूचनाहरु:',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.yellow,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Marquee(
//                       text:
//                           '🔴 Latest Updates: Flutter 4.0 released! | Nepal ranks top in tourism | AI advancements reshape industries',
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       velocity: 38.0,
//                       blankSpace: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 8),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: GridView.builder(
//                   controller: _scrollController,
//                   itemCount: items.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.9,
//                   ),
//                   itemBuilder: (context, index) {
//                     final item = items[index];
//                     return InkWell(
//                       borderRadius: BorderRadius.circular(8),
//                       onTap: () async {
//                         await _playAudio();
//                         await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => NewsPresenterPage(
//                                   serviceTypeName: item['title'],
//                                 ),
//                           ),
//                         );
//                         await _audioPlayer.stop();
//                       },
//                       child: AnimatedContainer(
//                         duration: Duration(milliseconds: 150),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             color: Color(0xFFDBD8D8),
//                             width: 1,
//                           ),
//                         ),
//                         padding: const EdgeInsets.all(4),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 item['icon'],
//                                 size: 30,
//                                 color: item['color'],
//                               ),
//                               SizedBox(height: 6),
//                               Text(
//                                 item['title'],
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 maxLines: 2, // LIMIT TO 2 LINES
//                                 overflow:
//                                     TextOverflow
//                                         .ellipsis, // SHOW ... IF TOO LONG
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//DEADLINE:
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:marquee/marquee.dart';
// import 'package:http/http.dart' as http;
// import '../services/hive_service.dart';
// import '../models/service.dart';
// import 'news_presenter.dart';

// class GridButton extends StatefulWidget {
//   const GridButton({super.key});

//   @override
//   _GridButtonState createState() => _GridButtonState();
// }

// class _GridButtonState extends State<GridButton> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;
//   final double _scrollSpeed = 0.5;

//   List<Map<String, dynamic>> items = [];

//   final List<Map<String, dynamic>> baseItems = [
//     {'icon': Icons.business, 'color': Colors.red},
//     {'icon': Icons.school, 'color': Colors.orange},
//     {'icon': Icons.family_restroom, 'color': Colors.purple},
//     {'icon': Icons.home, 'color': Colors.blue},
//     {'icon': Icons.route, 'color': Colors.green},
//     {'icon': Icons.medical_services, 'color': Colors.teal},
//     {'icon': Icons.info, 'color': Colors.amber},
//     {'icon': Icons.handshake, 'color': Colors.pink},
//     {'icon': Icons.flag, 'color': Colors.cyan},
//     {'icon': Icons.child_care, 'color': Colors.deepOrange},
//     {'icon': Icons.volunteer_activism, 'color': Colors.lime},
//     {'icon': Icons.gavel, 'color': Colors.indigo},
//     {'icon': Icons.location_city, 'color': Colors.brown},
//     {'icon': Icons.traffic, 'color': Colors.lightGreen},
//     {'icon': Icons.favorite, 'color': Colors.redAccent},
//     {'icon': Icons.directions_bus, 'color': Colors.deepPurple},
//     {'icon': Icons.map, 'color': Colors.lightBlue},
//     {'icon': Icons.factory, 'color': Colors.grey},
//     {'icon': Icons.park, 'color': Colors.greenAccent},
//     {'icon': Icons.school_outlined, 'color': Colors.blueAccent},
//     {'icon': Icons.holiday_village, 'color': Colors.orangeAccent},
//     {'icon': Icons.email, 'color': Colors.purpleAccent},
//     {'icon': Icons.health_and_safety, 'color': Colors.tealAccent},
//     {'icon': Icons.language, 'color': Colors.cyanAccent},
//     {'icon': Icons.money, 'color': Colors.amberAccent},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//     _loadCachedOrFetchData();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
//       if (_scrollController.hasClients) {
//         final max = _scrollController.position.maxScrollExtent;
//         final curr = _scrollController.offset;
//         _scrollController.jumpTo(curr < max ? curr + _scrollSpeed : 0);
//       }
//     });
//   }

//   Future<void> _playAudio() async {
//     try {
//       await _audioPlayer.play(AssetSource('audio/nepali.mp3'));
//     } catch (e) {
//       debugPrint('Audio error: $e');
//     }
//   }

//   Future<void> _loadCachedOrFetchData() async {
//     final cachedServices = HiveService.getServices();
//     if (cachedServices.isNotEmpty) {
//       _updateGridItems(cachedServices);
//     }
//     await _fetchAndCacheGridItems();
//   }

//   void _updateGridItems(List<Service> services) {
//     setState(() {
//       final uniqueTitles =
//           services.map((s) => s.serviceTypeName).toSet().toList();
//       items = List.generate(uniqueTitles.length, (index) {
//         final iconData = baseItems[index % baseItems.length]['icon'];
//         final colorData = baseItems[index % baseItems.length]['color'];
//         return {
//           'title': uniqueTitles[index],
//           'icon': iconData,
//           'color': colorData,
//         };
//       });
//     });
//   }

//   Future<void> _fetchAndCacheGridItems() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)['data'] as List;
//         final List<Service> apiServices =
//             data.map((item) {
//               return Service(
//                 code: item['code'] ?? '',
//                 serviceTypeName:
//                     (item['service_typename'] ?? '')
//                         .replaceAll(RegExp(r'\(.*?\)'), '')
//                         .trim(),
//                 serviceRecDetail: item['service_recdetail'] ?? '',
//                 fee: item['fee'] ?? '',
//                 time: item['time'] ?? '',
//                 serviceProvider: item['service_provider'] ?? '',
//                 complainListen: item['complain_listen'] ?? '',
//               );
//             }).toList();

//         await HiveService.saveServices(apiServices);
//         _updateGridItems(apiServices);
//       }
//     } catch (e) {
//       debugPrint('Error fetching grid items: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _scrollController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final crossAxisCount =
//         screenWidth > 1000
//             ? 8
//             : screenWidth > 600
//             ? 4
//             : 3;

//     return Column(
//       children: [
//         // Header
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset('assets/images/logonepal.jpg', height: 60),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: const [
//                     Text(
//                       'भानु नगरपालिका',
//                       style: TextStyle(
//                         color: Color(0xFFcd0711),
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'नगर कार्यपालिकाको कार्यालय',
//                       style: TextStyle(
//                         color: Color(0xFFcd0711),
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'तनहुँ',
//                       style: TextStyle(color: Color(0xFF2056ae), fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Marquee
//         Container(
//           width: double.infinity,
//           height: 26,
//           color: const Color(0xFF2E64C7),
//           child: Row(
//             children: [
//               Material(
//                 color: const Color(0xFF233072),
//                 child: Container(
//                   height: 16,
//                   width: 130,
//                   alignment: Alignment.center,
//                   child: const Text(
//                     '📢 सूचनाहरु:',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.yellow,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Marquee(
//                   text:
//                       '🔴 नयाँ योजना सुरु भयो | बजेट पारित गरियो | सेवा सुधारका लागि नयाँ निर्देशन जारी',
//                   style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   velocity: 38.0,
//                   blankSpace: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 8),

//         // Grid section
//         GridView.builder(
//           controller: _scrollController,
//           itemCount: items.length,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 0.9,
//           ),
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return InkWell(
//               borderRadius: BorderRadius.circular(8),
//               onTap: () async {
//                 await _playAudio();
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder:
//                         (context) =>
//                             NewsPresenterPage(serviceTypeName: item['title']),
//                   ),
//                 );
//                 await _audioPlayer.stop();
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 150),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: const Color(0xFFDBD8D8), width: 1),
//                 ),
//                 padding: const EdgeInsets.all(4),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(item['icon'], size: 30, color: item['color']),
//                       const SizedBox(height: 6),
//                       Text(
//                         item['title'],
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

//testing:
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:marquee/marquee.dart';
import 'package:http/http.dart' as http;
import '../services/hive_service.dart';
import '../models/service.dart';
import 'news_presenter.dart';

class GridButton extends StatefulWidget {
  const GridButton({super.key});

  @override
  _GridButtonState createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  final double _scrollSpeed = 0.5;

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> items = [];

  final List<Map<String, dynamic>> baseItems = [
    {'icon': Icons.business, 'color': Colors.red},
    {'icon': Icons.school, 'color': Colors.orange},
    {'icon': Icons.family_restroom, 'color': Colors.purple},
    {'icon': Icons.home, 'color': Colors.blue},
    {'icon': Icons.route, 'color': Colors.green},
    {'icon': Icons.medical_services, 'color': Colors.teal},
    {'icon': Icons.info, 'color': Colors.amber},
    {'icon': Icons.handshake, 'color': Colors.pink},
    {'icon': Icons.flag, 'color': Colors.cyan},
    {'icon': Icons.child_care, 'color': Colors.deepOrange},
    {'icon': Icons.volunteer_activism, 'color': Colors.lime},
    {'icon': Icons.gavel, 'color': Colors.indigo},
    {'icon': Icons.location_city, 'color': Colors.brown},
    {'icon': Icons.traffic, 'color': Colors.lightGreen},
    {'icon': Icons.favorite, 'color': Colors.redAccent},
    {'icon': Icons.directions_bus, 'color': Colors.deepPurple},
    {'icon': Icons.map, 'color': Colors.lightBlue},
    {'icon': Icons.factory, 'color': Colors.grey},
    {'icon': Icons.park, 'color': Colors.greenAccent},
    {'icon': Icons.school_outlined, 'color': Colors.blueAccent},
    {'icon': Icons.holiday_village, 'color': Colors.orangeAccent},
    {'icon': Icons.email, 'color': Colors.purpleAccent},
    {'icon': Icons.health_and_safety, 'color': Colors.tealAccent},
    {'icon': Icons.language, 'color': Colors.cyanAccent},
    {'icon': Icons.money, 'color': Colors.amberAccent},
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _loadCachedOrFetchData();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (_scrollController.hasClients) {
        final max = _scrollController.position.maxScrollExtent;
        final curr = _scrollController.offset;
        _scrollController.jumpTo(curr < max ? curr + _scrollSpeed : 0);
      }
    });
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.play(AssetSource('audio/nepali.mp3'));
    } catch (e) {
      debugPrint('Audio error: $e');
    }
  }

  Future<void> _loadCachedOrFetchData() async {
    final cachedServices = HiveService.getServices();
    if (cachedServices.isNotEmpty) {
      _updateGridItems(cachedServices);
    }
    await _fetchAndCacheGridItems();
  }

  void _updateGridItems(List<Service> services) {
    setState(() {
      final uniqueTitles =
          services.map((s) => s.serviceTypeName).toSet().toList();
      items = List.generate(uniqueTitles.length, (index) {
        final iconData = baseItems[index % baseItems.length]['icon'];
        final colorData = baseItems[index % baseItems.length]['color'];
        return {
          'title': uniqueTitles[index],
          'icon': iconData,
          'color': colorData,
        };
      });
    });
  }

  Future<void> _fetchAndCacheGridItems() async {
    try {
      final response = await http.post(
        Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        final List<Service> apiServices =
            data.map((item) {
              return Service(
                code: item['code'] ?? '',
                serviceTypeName:
                    (item['service_typename'] ?? '')
                        .replaceAll(RegExp(r'\(.*?\)'), '')
                        .trim(),
                serviceRecDetail: item['service_recdetail'] ?? '',
                fee: item['fee'] ?? '',
                time: item['time'] ?? '',
                serviceProvider: item['service_provider'] ?? '',
                complainListen: item['complain_listen'] ?? '',
              );
            }).toList();

        await HiveService.saveServices(apiServices);
        _updateGridItems(apiServices);
      }
    } catch (e) {
      debugPrint('Error fetching grid items: $e');
    }
  }

  void _performSearch() {
    final input = _searchController.text.trim();
    if (input.isEmpty) return;

    final index = int.tryParse(input);
    if (index != null && index > 0 && index <= items.length) {
      final selectedItem = items[index - 1]; // grid numbers start from 1
      _playAudio().then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    NewsPresenterPage(serviceTypeName: selectedItem['title']),
          ),
        ).then((_) => _audioPlayer.stop());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया मान्य नम्बर टाइप गर्नुहोस्')),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    _autoScrollTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        screenWidth > 1000
            ? 8
            : screenWidth > 600
            ? 4
            : 3;

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logonepal.jpg', height: 60),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'भानु नगरपालिका',
                      style: TextStyle(
                        color: Color(0xFFcd0711),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'नगर कार्यपालिकाको कार्यालय',
                      style: TextStyle(
                        color: Color(0xFFcd0711),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'तनहुँ',
                      style: TextStyle(color: Color(0xFF2056ae), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Marquee
        Container(
          width: double.infinity,
          height: 26,
          color: const Color(0xFF2E64C7),
          child: Row(
            children: [
              Material(
                color: const Color(0xFF233072),
                child: Container(
                  height: 16,
                  width: 130,
                  alignment: Alignment.center,
                  child: const Text(
                    '📢 सूचनाहरु:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Marquee(
                  text:
                      '🔴 नयाँ योजना सुरु भयो | बजेट पारित गरियो | सेवा सुधारका लागि नयाँ निर्देशन जारी',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  velocity: 38.0,
                  blankSpace: 20,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _performSearch(),
              decoration: InputDecoration(
                hintText: "Code नम्बर टाइप गर्नुहोस् र खोज्नुहोस्",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: _performSearch,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Grid section
        GridView.builder(
          controller: _scrollController,
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                await _playAudio();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            NewsPresenterPage(serviceTypeName: item['title']),
                  ),
                );
                await _audioPlayer.stop();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFDBD8D8), width: 1),
                ),
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'], size: 30, color: item['color']),
                      const SizedBox(height: 6),
                      Text(
                        item['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
