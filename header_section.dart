// //badapatra header only code:

// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';

// class HeaderSection extends StatelessWidget {
//   const HeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(220), // same height as before
//       child: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Column(
//           children: [
//             // 🔵 News Marquee
//             Container(
//               width: double.infinity,
//               height: 26,
//               color: const Color(0xFF2E64C7),
//               child: Row(
//                 children: [
//                   Material(
//                     color: const Color(0xFF233072),
//                     child: Container(
//                       height: 16,
//                       width: 130,
//                       alignment: Alignment.center,
//                       child: const Text(
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
//                       style: const TextStyle(
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

//             // ✅ Header Section (Original Height)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Logo
//                       Image.asset('assets/images/logonepal.jpg', height: 60),
//                       const SizedBox(width: 8),

//                       // Municipality Info
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
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
//                       const SizedBox(width: 8),

//                       // Contact Box + Flag
//                       Flexible(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 height: 90,
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFF1EEEE),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: const Color(0xFFDBD8D8),
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
//                                       _contactRow(
//                                         Icons.phone,
//                                         '०६५-४२६६३०',
//                                         bg: Colors.red,
//                                       ),
//                                       _contactRow(
//                                         Icons.language,
//                                         'bhanu.gov.np',
//                                         bg: Colors.blue,
//                                       ),
//                                       _contactRow(
//                                         Icons.email,
//                                         'bhanu@gmail.com',
//                                         bg: Colors.green,
//                                       ),
//                                       _contactRow(
//                                         Icons.phone,
//                                         '०६५-४२६०३८',
//                                         bg: Colors.amber,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Opacity(
//                               opacity: 0.5,
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
//           ],
//         ),
//       ),
//     );
//   }

//   // ✅ Contact Row Widget (kept private here)
//   static Widget _contactRow(
//     IconData icon,
//     String text, {
//     Color bg = Colors.grey,
//     Color color = Colors.black,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: bg,
//             child: Icon(icon, color: Colors.white, size: 20),
//             radius: 18,
//           ),
//           const SizedBox(width: 6),
//           Text(text, style: TextStyle(color: color, fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }

//TEST FINAL:

// import 'package:flutter/material.dart';

// class HeaderSection extends StatelessWidget {
//   const HeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final topPadding = MediaQuery.of(context).padding.top;

//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       padding: EdgeInsets.only(top: topPadding, left: 8, right: 8, bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Logo
//           Image.asset('assets/images/logonepal.jpg', height: 60),
//           const SizedBox(width: 8),

//           // Municipality Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: const [
//                 Text(
//                   'भानु नगरपालिका',
//                   style: TextStyle(
//                     color: Color(0xFFcd0711),
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'नगर कार्यपालिकाको कार्यालय',
//                   style: TextStyle(
//                     color: Color(0xFFcd0711),
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'तनहुँ',
//                   style: TextStyle(color: Color(0xFF2056ae), fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),

//           // Contact Box + Flag
//           Flexible(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 90,
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF1EEEE),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: const Color(0xFFDBD8D8),
//                         width: 1,
//                       ),
//                     ),
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       alignment: Alignment.centerLeft,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _contactRow(
//                             Icons.phone,
//                             '०६५-४२६६३०',
//                             bg: Colors.red,
//                           ),
//                           _contactRow(
//                             Icons.language,
//                             'bhanu.gov.np',
//                             bg: Colors.blue,
//                           ),
//                           _contactRow(
//                             Icons.email,
//                             'bhanu@gmail.com',
//                             bg: Colors.green,
//                           ),
//                           _contactRow(
//                             Icons.phone,
//                             '०६५-४२६०३८',
//                             bg: Colors.amber,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Opacity(
//                   opacity: 0.5,
//                   child: Image.asset(
//                     'assets/images/flag1.gif',
//                     height: 60,
//                     width: 40,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _contactRow(
//     IconData icon,
//     String text, {
//     Color bg = Colors.grey,
//     Color color = Colors.black,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: bg,
//             child: Icon(icon, color: Colors.white, size: 20),
//             radius: 18,
//           ),
//           const SizedBox(width: 6),
//           Text(text, style: TextStyle(color: color, fontSize: 16)),
//         ],
//       ),
//     );
//   }

//BEFORE API

// import 'package:flutter/material.dart';

// class HeaderSection extends StatelessWidget {
//   const HeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Adjust sizing dynamically
//     final double logoHeight = isPortrait ? 45 : 35;
//     final double flagHeight = isPortrait ? 45 : 40;
//     final double contactBoxHeight = isPortrait ? 70 : 60;
//     final double fontSizeMain = isPortrait ? 15 : 14;
//     final double fontSizeSub = isPortrait ? 11 : 10;

//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       padding: EdgeInsets.only(
//         top: 0, // ✅ remove top margin completely
//         left: screenWidth < 600 ? 8 : 16,
//         right: screenWidth < 600 ? 8 : 16,
//         bottom: 4,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Smaller, responsive logo
//           Image.asset('assets/images/logonepal.jpg', height: logoHeight),
//           const SizedBox(width: 6),

//           // Municipality Info (centered, compact)
//           Expanded(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'भानु नगरपालिका',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: const Color(0xFFcd0711),
//                         fontSize: fontSizeMain,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'नगर कार्यपालिकाको कार्यालय',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: const Color(0xFFcd0711),
//                         fontSize: fontSizeSub,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'तनहुँ',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: const Color(0xFF2056ae),
//                         fontSize: fontSizeSub,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           const SizedBox(width: 6),

//           // Contact Box + Flag (compact + balanced)
//           Flexible(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: contactBoxHeight,
//                     padding: const EdgeInsets.all(3),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF1EEEE),
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: const Color(0xFFDBD8D8),
//                         width: 1,
//                       ),
//                     ),
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       alignment: Alignment.centerLeft,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           _contactRow(
//                             Icons.phone,
//                             '०६५-४२६६३०',
//                             bg: Colors.red,
//                           ),
//                           _contactRow(
//                             Icons.language,
//                             'bhanu.gov.np',
//                             bg: Colors.blue,
//                           ),
//                           _contactRow(
//                             Icons.email,
//                             'bhanu@gmail.com',
//                             bg: Colors.green,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Opacity(
//                   opacity: 0.6,
//                   child: Image.asset(
//                     'assets/images/flag1.gif',
//                     height: flagHeight,
//                     width: flagHeight * 0.7,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _contactRow(
//     IconData icon,
//     String text, {
//     Color bg = Colors.grey,
//     Color color = Colors.black,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 2.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: bg,
//             radius: 13,
//             child: Icon(icon, color: Colors.white, size: 13),
//           ),
//           const SizedBox(width: 4),
//           Text(text, style: TextStyle(color: color, fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }

//OLD VERSION:
//WITH TEMPERATURE API:

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HeaderSection extends StatefulWidget {
//   const HeaderSection({super.key});

//   @override
//   _HeaderSectionState createState() => _HeaderSectionState();
// }

// class _HeaderSectionState extends State<HeaderSection> {
//   late Future<double?> weatherFuture;

//   @override
//   void initState() {
//     super.initState();
//     weatherFuture = fetchWeather();
//   }

//   Future<double?> fetchWeather() async {
//     const url = 'http://digitalbadapatra.com/api/v1/get_weather_info';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {'orgid': '22', 'userid': '7'},
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         // assuming API returns {"temperature": 25.5, ...}
//         return data['temperature']?.toDouble();
//       } else {
//         debugPrint('Weather API error: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Weather fetch exception: $e');
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Adjust sizing dynamically
//     final double logoHeight = isPortrait ? 45 : 35;
//     final double flagHeight = isPortrait ? 45 : 40;
//     final double contactBoxHeight = isPortrait ? 70 : 60;
//     final double fontSizeMain = isPortrait ? 15 : 14;
//     final double fontSizeSub = isPortrait ? 11 : 10;

//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       padding: EdgeInsets.only(
//         top: 0,
//         left: screenWidth < 600 ? 8 : 16,
//         right: screenWidth < 600 ? 8 : 16,
//         bottom: 4,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Logo
//           Image.asset('assets/images/logonepal.jpg', height: logoHeight),
//           const SizedBox(width: 6),

//           // Municipality Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'भानु नगरपालिका',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: const Color(0xFFcd0711),
//                     fontSize: fontSizeMain,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'नगर कार्यपालिकाको कार्यालय',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: const Color(0xFFcd0711),
//                     fontSize: fontSizeSub,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'तनहुँ',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: const Color(0xFF2056ae),
//                     fontSize: fontSizeSub,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 6),

//           // Weather + Contact Box + Flag
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Weather Card
//               FutureBuilder<double?>(
//                 future: weatherFuture,
//                 builder: (context, snapshot) {
//                   final isLoading =
//                       snapshot.connectionState == ConnectionState.waiting;
//                   final temperature = snapshot.data;
//                   return Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.blue.shade200, Colors.blue.shade50],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 4,
//                           offset: const Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           temperature != null
//                               ? (temperature > 30
//                                   ? Icons.wb_sunny
//                                   : Icons.cloud)
//                               : Icons.cloud_queue,
//                           size: 20,
//                           color: Colors.orangeAccent,
//                         ),
//                         const SizedBox(width: 4),
//                         isLoading
//                             ? const SizedBox(
//                               width: 40,
//                               child: Center(
//                                 child: SizedBox(
//                                   width: 12,
//                                   height: 12,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                   ),
//                                 ),
//                               ),
//                             )
//                             : Text(
//                               temperature != null
//                                   ? '${temperature.toStringAsFixed(1)}°C'
//                                   : '--°C',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(width: 10),

//               // Contact Box + Flag
//               SizedBox(
//                 height: contactBoxHeight,
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF1EEEE),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: const Color(0xFFDBD8D8),
//                           width: 1,
//                         ),
//                       ),
//                       child: FittedBox(
//                         fit: BoxFit.scaleDown,
//                         alignment: Alignment.centerLeft,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             _contactRow(
//                               Icons.phone,
//                               '०६५-४२६६३०',
//                               bg: Colors.red,
//                             ),
//                             _contactRow(
//                               Icons.language,
//                               'bhanu.gov.np',
//                               bg: Colors.blue,
//                             ),
//                             _contactRow(
//                               Icons.email,
//                               'bhanu@gmail.com',
//                               bg: Colors.green,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Opacity(
//                       opacity: 0.6,
//                       child: Image.asset(
//                         'assets/images/flag1.gif',
//                         height: flagHeight,
//                         width: flagHeight * 0.7,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _contactRow(
//     IconData icon,
//     String text, {
//     Color bg = Colors.grey,
//     Color color = Colors.black,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 2.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: bg,
//             radius: 13,
//             child: Icon(icon, color: Colors.white, size: 13),
//           ),
//           const SizedBox(width: 4),
//           Text(text, style: TextStyle(color: color, fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }

//###########################################################################//
//NEW VERSION:

// import 'dart:async';
// import 'package:flutter/material.dart';

// class HeaderSection extends StatelessWidget {
//   final Map<String, dynamic> orgInfo;

//   const HeaderSection({Key? key, required this.orgInfo}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final screenWidth = MediaQuery.of(context).size.width;

//     final double logoHeight = isPortrait ? 45 : 35;
//     final double flagHeight = isPortrait ? 45 : 40;
//     final double contactBoxHeight = isPortrait ? 70 : 60;
//     final double fontSizeMain = isPortrait ? 15 : 14;
//     final double fontSizeSub = isPortrait ? 11 : 10;

//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       padding: EdgeInsets.only(
//         top: 0,
//         left: screenWidth < 600 ? 8 : 16,
//         right: screenWidth < 600 ? 8 : 16,
//         bottom: 4,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Static Logo
//           Image.asset('assets/images/logonepal.jpg', height: logoHeight),
//           const SizedBox(width: 6),

//           // Municipality / Org Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   orgInfo['orgname'] ?? '',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: const Color(0xFFcd0711),
//                     fontSize: fontSizeMain,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   orgInfo['orgname_np'] ?? '',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: const Color(0xFFcd0711),
//                     fontSize: fontSizeSub,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   orgInfo['orgaddress1'] ?? '',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: const Color(0xFF2056ae),
//                     fontSize: fontSizeSub,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 6),

//           // Contact Box + Static Flag
//           SizedBox(
//             height: contactBoxHeight,
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF1EEEE),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: const Color(0xFFDBD8D8),
//                       width: 1,
//                     ),
//                   ),
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         _contactRow(
//                           Icons.phone,
//                           orgInfo['contact'] ?? '',
//                           bg: Colors.red,
//                         ),
//                         _contactRow(
//                           Icons.language,
//                           orgInfo['website'] ?? '',
//                           bg: Colors.blue,
//                         ),
//                         _contactRow(
//                           Icons.email,
//                           orgInfo['email'] ?? '',
//                           bg: Colors.green,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Opacity(
//                   opacity: 0.6,
//                   child: Image.asset(
//                     'assets/images/flag1.gif',
//                     height: flagHeight,
//                     width: flagHeight * 0.7,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _contactRow(
//     IconData icon,
//     String text, {
//     Color bg = Colors.grey,
//     Color color = Colors.black,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 2.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: bg,
//             radius: 13,
//             child: Icon(icon, color: Colors.white, size: 13),
//           ),
//           const SizedBox(width: 4),
//           Text(text, style: TextStyle(color: color, fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }

// new above edited:

import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final Map<String, dynamic> orgInfo;

  const HeaderSection({Key? key, required this.orgInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;

    final double logoHeight = isPortrait ? 45 : 35;
    final double flagHeight = isPortrait ? 45 : 40;
    final double contactBoxHeight = isPortrait ? 70 : 60;
    final double fontSizeMain = isPortrait ? 15 : 14;
    final double fontSizeSub = isPortrait ? 11 : 10;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 0,
        left: screenWidth < 600 ? 8 : 16,
        right: screenWidth < 600 ? 8 : 16,
        bottom: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Static Logo
          Image.asset('assets/images/logonepal.jpg', height: logoHeight),
          const SizedBox(width: 6),

          // Municipality / Org Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  orgInfo['orgname'] ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFcd0711),
                    fontSize: fontSizeMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  orgInfo['orgname_np'] ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFcd0711),
                    fontSize: fontSizeSub,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  orgInfo['orgaddress1'] ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF2056ae),
                    fontSize: fontSizeSub,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),

          // Contact Box + Static Flag
          SizedBox(
            height: contactBoxHeight,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EEEE),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFDBD8D8),
                      width: 1,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _contactRow(
                          Icons.phone,
                          orgInfo['contact'] ?? '',
                          bg: Colors.red,
                        ),
                        _contactRow(
                          Icons.language,
                          orgInfo['website'] ?? '',
                          bg: Colors.blue,
                        ),
                        _contactRow(
                          Icons.email,
                          orgInfo['email'] ?? '',
                          bg: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    'assets/images/flag1.gif',
                    height: flagHeight,
                    width: flagHeight * 0.7,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _contactRow(
    IconData icon,
    String text, {
    Color bg = Colors.grey,
    Color color = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: bg,
            radius: 13,
            child: Icon(icon, color: Colors.white, size: 13),
          ),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
