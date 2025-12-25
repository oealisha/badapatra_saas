// import 'package:bada_patra_task/team_page.dart';
// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final ScrollController _tableController = ScrollController();
//   int? _searchedId;
//   bool _autoScroll = true;
//   bool _showPopup = false;
//   Map<String, String>? _selectedService;

//   final List<Map<String, String>> _services = List.generate(50, (index) {
//     return {
//       'ID No': '${index + 1}',
//       'Service Type': 'Service ${index + 1}',
//       'Service Requirement': 'Requirement ${index + 1}',
//       'Price': '${(index + 1) * 100} NPR',
//       'Time': '${(index + 1) * 2} days',
//       'Service Branch': 'Branch ${index % 5 + 1}',
//       'Comment Section': 'No remarks',
//     };
//   });

//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     if (index == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => TeamPage()),
//       );
//     } else {
//       setState(() => _selectedIndex = index);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _startAutoScroll();
//     });
//   }

//   void _startAutoScroll() {
//     Future.delayed(Duration(milliseconds: 1000), () {
//       if (_autoScroll && _tableController.hasClients && !_showPopup) {
//         final newPosition = _tableController.position.pixels - 50;
//         if (newPosition > _tableController.position.minScrollExtent) {
//           _tableController.animateTo(
//             newPosition,
//             duration: Duration(milliseconds: 1000),
//             curve: Curves.linear,
//           );
//         } else {
//           _tableController.animateTo(
//             _tableController.position.maxScrollExtent,
//             duration: Duration(milliseconds: 1000),
//             curve: Curves.linear,
//           );
//         }
//         _startAutoScroll();
//       }
//     });
//   }

//   void _showRowPopup(int id) {
//     final service = _services.firstWhere((s) => s['ID No'] == id.toString());
//     setState(() {
//       _selectedService = service;
//       _showPopup = true;
//       _autoScroll = false;
//     });

//     Future.delayed(Duration(seconds: 5), () {
//       if (mounted) {
//         setState(() {
//           _showPopup = false;
//           _autoScroll = true;
//           _startAutoScroll();
//         });
//       }
//     });
//   }

//   Widget _buildHeaderCell(String text) {
//     return Expanded(
//       child: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(8),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDataCell(String text) {
//     return Expanded(
//       child: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(8),
//         child: Text(text, style: TextStyle(fontSize: 14)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tableWidth = MediaQuery.of(context).size.width * 0.7;
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // ✅ HEADER WITH INITIAL UI HEIGHT
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(220), // original header UI height
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           title: Column(
//             children: [
//               // 🔵 News Marquee
//               Container(
//                 width: double.infinity,
//                 height: 26,
//                 color: Color(0xFF2E64C7),
//                 child: Row(
//                   children: [
//                     Material(
//                       color: Color(0xFF233072),
//                       child: Container(
//                         height: 16,
//                         width: 130,
//                         alignment: Alignment.center,
//                         child: Text(
//                           '📢 सूचनाहरु:',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.yellow,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Marquee(
//                         text:
//                             '🔴 Latest Updates: Flutter 4.0 released! | Nepal ranks top in tourism | AI advancements reshape industries',
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         velocity: 38.0,
//                         blankSpace: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // ✅ Header Section (Original Height)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Logo
//                         Image.asset('assets/images/logonepal.jpg', height: 60),
//                         SizedBox(width: 8),

//                         // Municipality Info
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'भानु नगरपालिका',
//                                 style: TextStyle(
//                                   color: Color(0xFFcd0711),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'नगर कार्यपालिकाको कार्यालय',
//                                 style: TextStyle(
//                                   color: Color(0xFFcd0711),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'तनहुँ',
//                                 style: TextStyle(
//                                   color: Color(0xFF2056ae),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 8),

//                         // Contact Box + Flag
//                         Flexible(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: 90,
//                                   padding: EdgeInsets.all(4),
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFF1EEEE),
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: Color(0xFFDBD8D8),
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     alignment: Alignment.centerLeft,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         _contactRow(
//                                           Icons.phone,
//                                           '०६५-४२६६३०',
//                                           bg: Colors.red,
//                                         ),
//                                         _contactRow(
//                                           Icons.language,
//                                           'bhanu.gov.np',
//                                           bg: Colors.blue,
//                                         ),
//                                         _contactRow(
//                                           Icons.email,
//                                           'bhanu@gmail.com',
//                                           bg: Colors.green,
//                                         ),
//                                         _contactRow(
//                                           Icons.phone,
//                                           '०६५-४२६०३८',
//                                           bg: Colors.amber,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 6),
//                               Opacity(
//                                 opacity: 0.5,
//                                 child: Image.asset(
//                                   'assets/images/flag1.gif',
//                                   height: 60,
//                                   width: 40,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       // ✅ BODY (Table + Search + Right Side)
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 7,
//             child: Column(
//               children: [
//                 // Search Bar
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: SizedBox(
//                       width: tableWidth,
//                       height: 35,
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: InputDecoration(
//                           labelText: 'Search by Service ID',
//                           border: OutlineInputBorder(),
//                           suffixIcon: IconButton(
//                             icon: Icon(Icons.search),
//                             onPressed: () {
//                               setState(() {
//                                 _searchedId = int.tryParse(
//                                   _searchController.text,
//                                 );
//                                 if (_searchedId != null) {
//                                   _showRowPopup(_searchedId!);
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Table
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Container(
//                         width: tableWidth,
//                         height: 60,
//                         color: Color(0xFFDD2518),
//                         child: Row(
//                           children: [
//                             _buildHeaderCell('ID No'),
//                             _buildHeaderCell('Service Type'),
//                             _buildHeaderCell('Service Requirement'),
//                             _buildHeaderCell('Price'),
//                             _buildHeaderCell('Time'),
//                             _buildHeaderCell('Service Branch'),
//                             _buildHeaderCell('Comment Section'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                           controller: _tableController,
//                           itemCount: _services.length,
//                           itemBuilder: (context, index) {
//                             final service = _services[index];
//                             return Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.white),
//                                 color: Colors.white,
//                               ),
//                               child: Row(
//                                 children: [
//                                   _buildDataCell(service['ID No']!),
//                                   _buildDataCell(service['Service Type']!),
//                                   _buildDataCell(
//                                     service['Service Requirement']!,
//                                   ),
//                                   _buildDataCell(service['Price']!),
//                                   _buildDataCell(service['Time']!),
//                                   _buildDataCell(service['Service Branch']!),
//                                   _buildDataCell(service['Comment Section']!),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Right Side Widget
//           Expanded(
//             flex: 3,
//             child: Container(
//               color: Color(0xFFF9F9F9),
//               child: Center(
//                 child: Text(
//                   "📢 Right Side Widgets (Announcements, Links...)",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),

//       // ✅ Footer News Bar + Bottom Nav
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 30,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.red, Colors.deepOrange],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 90,
//                   color: Colors.black,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "🔴 खबर",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Marquee(
//                     text:
//                         "📢 Breaking News: Digital Bada Patra Launched | E-Governance improving services",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     velocity: 45.0,
//                     blankSpace: 20.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           BottomNavigationBar(
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home, color: Colors.redAccent),
//                 label: 'Home 🏠',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.people, color: Colors.redAccent),
//                 label: 'Team 👥',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.contact_phone, color: Colors.redAccent),
//                 label: 'Contact 📞',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.redAccent,
//             onTap: _onItemTapped,
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Contact Row Widget
//   Widget _contactRow(
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
//           SizedBox(width: 6),
//           Text(text, style: TextStyle(color: color, fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
