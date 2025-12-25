// import 'package:flutter/material.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/footer.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'grid_button.dart';
// import 'news_presenter.dart';
// import 'wara_badapatra_table.dart';
// import 'login_page.dart';
// import 'main.dart';
// import 'team_page.dart';

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/footer.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'wara_badapatra_table.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   _FinalHomePageState createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";
//   int _selectedIndex = 0;

//   void _onFooterTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tableWidth = screenWidth * 0.7; // Left side
//     final sidebarWidth = screenWidth * 0.3; // Right side

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // 1️⃣ Header
//           const HeaderSection(),

//           // 2️⃣ Blue horizontal line
//           Container(height: 3, color: Colors.blue),

//           // 3️⃣ Search bar
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 40,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _searchController,
//                       keyboardType: TextInputType.number,
//                       onSubmitted: (_) => _performSearch(),
//                       decoration: InputDecoration(
//                         hintText:
//                             "सेवाहरु खोज्नको लागि (*) चिन्ह होस् र नम्बर टाइप गर्नुहोस्",
//                         border: const OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           icon: const Icon(Icons.search),
//                           onPressed: _performSearch,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // 4️⃣ Main content (Table on LEFT, Sidebar on RIGHT)
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // LEFT: Table (70%)
//                 SizedBox(
//                   width: tableWidth,
//                   child: WaraBadapatraTable(searchCode: _searchCode),
//                 ),

//                 // RIGHT: Sidebar (30%)
//                 SizedBox(width: sidebarWidth, child: const SidebarWidget()),
//               ],
//             ),
//           ),

//           // 5️⃣ Bottom news bar
//           const BottomNewsBar(),
//         ],
//       ),

//       // 6️⃣ Footer navigation bar
//       bottomNavigationBar: FooterNavBar(
//         selectedIndex: _selectedIndex,
//         onTap: _onFooterTap,
//       ),
//     );
//   }
// }

//###################################################################//
//landscape mode:

// import 'package:flutter/material.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/footer.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart'; // NEW: top news bar
// import 'wara_badapatra_table.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   _FinalHomePageState createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";
//   int _selectedIndex = 0;

//   void _onFooterTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tableWidth = screenWidth * 0.7; // LEFT: Table
//     final sidebarWidth = screenWidth * 0.3; // RIGHT: Sidebar

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // 1️⃣ Header
//               const HeaderSection(),

//               // 2️⃣ Top News Bar (with blue horizontal line inside)
//               const TopNewsBar(),

//               // 3️⃣ Search bar
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   height: 40,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _searchController,
//                           keyboardType: TextInputType.number,
//                           onSubmitted: (_) => _performSearch(),
//                           decoration: InputDecoration(
//                             hintText:
//                                 "सेवाहरु खोज्नको लागि (*) चिन्ह होस् र नम्बर टाइप गर्नुहोस्",
//                             border: const OutlineInputBorder(),
//                             suffixIcon: IconButton(
//                               icon: const Icon(Icons.search),
//                               onPressed: _performSearch,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // 4️⃣ Main content: LEFT Table, RIGHT Sidebar
//               SizedBox(
//                 height:
//                     MediaQuery.of(context).size.height *
//                     0.6, // adjust as needed
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // LEFT: Table (70%)
//                     SizedBox(
//                       width: tableWidth,
//                       child: WaraBadapatraTable(searchCode: _searchCode),
//                     ),

//                     // RIGHT: Sidebar (30%)
//                     SizedBox(width: sidebarWidth, child: const SidebarWidget()),
//                   ],
//                 ),
//               ),

//               // 5️⃣ Bottom news bar
//               const BottomNewsBar(),

//               // 6️⃣ Footer navigation
//               FooterNavBar(selectedIndex: _selectedIndex, onTap: _onFooterTap),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//#####################################################################//

//potrait
// import 'package:flutter/material.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/footer.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";
//   int _selectedIndex = 0;

//   void _onFooterTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           children: [
//             // 1️⃣ Header Section
//             const HeaderSection(),

//             // 2️⃣ Top News Bar
//             const TopNewsBar(),

//             // 3️⃣ Search Bar (compact, blue)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: SizedBox(
//                 height: 40, // compact height
//                 child: TextField(
//                   controller: _searchController,
//                   keyboardType: TextInputType.number,
//                   onSubmitted: (_) => _performSearch(),
//                   decoration: InputDecoration(
//                     hintText:
//                         "सेवाहरु खोज्न को लागि (*) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//                     hintStyle: const TextStyle(color: Colors.blue),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(color: Colors.blue),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 2,
//                       ),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: const Icon(
//                         Icons.search,
//                         size: 20,
//                         color: Colors.blue,
//                       ),
//                       onPressed: _performSearch,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // 4️⃣ Wara Badapatra Table + Sidebar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // 🧾 Table
//                   WaraBadapatraTable(searchCode: _searchCode),

//                   const SizedBox(height: 20),

//                   // 🧱 Sidebar below table
//                   const SidebarWidget(),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 5️⃣ Bottom News Bar
//             const BottomNewsBar(),

//             // 6️⃣ Footer Navigation
//             FooterNavBar(selectedIndex: _selectedIndex, onTap: _onFooterTap),
//           ],
//         ),
//       ),
//     );
//   }
// }

//FINAL LANDSCAPE :

// import 'package:flutter/material.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import './team_page.dart';
// import './grid_button.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           children: [
//             // 1️⃣ Header Section
//             const HeaderSection(),

//             // 2️⃣ Top News Bar
//             const TopNewsBar(),

//             // 3️⃣ Search Bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: SizedBox(
//                 height: 40,
//                 child: TextField(
//                   controller: _searchController,
//                   keyboardType: TextInputType.number,
//                   onSubmitted: (_) => _performSearch(),
//                   decoration: InputDecoration(
//                     hintText:
//                         "सेवाहरु खोज्न को लागि ( * ) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//                     hintStyle: const TextStyle(color: Colors.blue),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(color: Colors.blue),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                         width: 2,
//                       ),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: const Icon(
//                         Icons.search,
//                         size: 20,
//                         color: Colors.blue,
//                       ),
//                       onPressed: _performSearch,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // 4️⃣ Wara Badapatra Table + Sidebar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   WaraBadapatraTable(searchCode: _searchCode),
//                   const SizedBox(height: 20),
//                   const SidebarWidget(),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 👥 Team Page Section (embed without scrollable)
//             TeamPage(scrollable: false),

//             const SizedBox(height: 20),

//             // 🟩 Grid Button Page Section (shrinkWrap handled inside GridButton)
//             const GridButton(),

//             const SizedBox(height: 20),

//             // 📰 Bottom News Bar
//             const BottomNewsBar(),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //DEADLINE:
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import './team_page.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";

//   @override
//   void initState() {
//     super.initState();
//     // 🔒 Force landscape orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }

//   @override
//   void dispose() {
//     // ✅ Restore portrait when leaving
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // 🔹 Header + Top News
//             const HeaderSection(),
//             const TopNewsBar(),

//             // 🔍 Search bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 7,
//                     child: SizedBox(
//                       height: 40,
//                       child: TextField(
//                         controller: _searchController,
//                         keyboardType: TextInputType.number,
//                         onSubmitted: (_) => _performSearch(),
//                         decoration: InputDecoration(
//                           hintText:
//                               "सेवाहरु खोज्न को लागि ( * ) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//                           hintStyle: const TextStyle(color: Colors.blue),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                             borderSide: const BorderSide(color: Colors.blue),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                             borderSide: const BorderSide(
//                               color: Colors.blue,
//                               width: 2,
//                             ),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: const Icon(
//                               Icons.search,
//                               size: 20,
//                               color: Colors.blue,
//                             ),
//                             onPressed: _performSearch,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Expanded(flex: 3, child: SizedBox.shrink()),
//                 ],
//               ),
//             ),

//             // 🔹 Scrollable content (includes bottom news bar)
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: Column(
//                     children: [
//                       // 🧭 Main Row (Left table + Right panel)
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // LEFT - WaraBadapatra Table
//                           Expanded(
//                             flex: 7,
//                             child: Container(
//                               color: Colors.white,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.vertical,
//                                 child: WaraBadapatraTable(
//                                   searchCode: _searchCode,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(width: 12),

//                           // RIGHT - Sidebar + Team hierarchy
//                           Expanded(
//                             flex: 3,
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: const [
//                                   SidebarWidget(),
//                                   SizedBox(height: 12),
//                                   TeamPage(scrollable: true),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 25),

//                       // 🔹 Bottom News Bar (appears after scrolling)
//                       const BottomNewsBar(),

//                       const SizedBox(height: 25),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//#####################################################################//

//LANDSCAPE MODE:

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import './team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";
//   Service? _selectedService;

//   @override
//   void initState() {
//     super.initState();
//     // Force landscape orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }

//   @override
//   void dispose() {
//     // Restore portrait orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   /// Called when a code is tapped in the table
//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);

//     // Auto hide after 5 seconds
//     Timer(const Duration(seconds: 5), () {
//       setState(() => _selectedService = null);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Main scrollable content
//             SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const HeaderSection(),
//                     const TopNewsBar(),
//                     _buildSearchBar(),
//                     _buildMainRow(),
//                     const SizedBox(height: 25),
//                     const BottomNewsBar(),
//                     const SizedBox(height: 25),
//                   ],
//                 ),
//               ),
//             ),

//             // Full-screen overlay when a service is selected
//             if (_selectedService != null)
//               Positioned.fill(
//                 child: Material(
//                   color: Colors.black87.withOpacity(0.9),
//                   child: SafeArea(
//                     child: Center(
//                       child: SingleChildScrollView(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'कोड: ${_selectedService!.code}',
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'विवरण: ${_selectedService!.serviceRecDetail}',
//                               ),
//                               const SizedBox(height: 12),
//                               Text('शुल्क: ${_selectedService!.fee}'),
//                               const SizedBox(height: 12),
//                               Text('समय: ${_selectedService!.time}'),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Search bar widget
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 8, // Adjusted for 80% table width
//             child: SizedBox(
//               height: 40,
//               child: TextField(
//                 controller: _searchController,
//                 keyboardType: TextInputType.number,
//                 onSubmitted: (_) => _performSearch(),
//                 decoration: InputDecoration(
//                   hintText:
//                       "सेवाहरु खोज्न को लागि ( * ) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//                   hintStyle: const TextStyle(color: Colors.blue),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: const BorderSide(color: Colors.blue),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: const BorderSide(color: Colors.blue, width: 2),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: const Icon(
//                       Icons.search,
//                       size: 20,
//                       color: Colors.blue,
//                     ),
//                     onPressed: _performSearch,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             flex: 2, // 20% width placeholder
//             child: const SizedBox.shrink(),
//           ),
//         ],
//       ),
//     );
//   }

//   // Main row containing table + sidebar
//   Widget _buildMainRow() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // LEFT - WaraBadapatra Table (80%)
//         Expanded(
//           flex: 8,
//           child: Container(
//             color: Colors.white,
//             child: WaraBadapatraTable(
//               searchCode: _searchCode,
//               onCodeTap: _showFullScreen,
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         // RIGHT - Sidebar + Team hierarchy (20%)
//         Expanded(
//           flex: 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: const [
//               SidebarWidget(),
//               SizedBox(height: 12),
//               TeamPage(scrollable: false),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

//#########################################################################//
// //LANDSCAPE MODE DONE:
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import './team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";
//   Service? _selectedService;

//   @override
//   void initState() {
//     super.initState();
//     // Force landscape orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }

//   @override
//   void dispose() {
//     // Restore portrait orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   /// Called when a code is tapped in the table
//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);

//     // Auto hide after 5 seconds
//     Timer(const Duration(seconds: 5), () {
//       setState(() => _selectedService = null);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Main scrollable content
//             SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const HeaderSection(),
//                     const TopNewsBar(),
//                     _buildSearchBar(), // ✅ aligned search bar
//                     _buildMainRow(),
//                     const SizedBox(height: 25),
//                     const BottomNewsBar(),
//                     const SizedBox(height: 25),
//                   ],
//                 ),
//               ),
//             ),

//             // Full-screen overlay when a service is selected
//             if (_selectedService != null)
//               Positioned.fill(
//                 child: Material(
//                   color: Colors.black87.withOpacity(0.9),
//                   child: SafeArea(
//                     child: Center(
//                       child: SingleChildScrollView(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'कोड: ${_selectedService!.code}',
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'विवरण: ${_selectedService!.serviceRecDetail}',
//                               ),
//                               const SizedBox(height: 12),
//                               Text('शुल्क: ${_selectedService!.fee}'),
//                               const SizedBox(height: 12),
//                               Text('समय: ${_selectedService!.time}'),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔍 Search Bar perfectly aligned with table
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           // LEFT - Search bar (same width as table)
//           Expanded(
//             flex: 8, // same ratio as table
//             child: SizedBox(
//               height: 40,
//               child: TextField(
//                 controller: _searchController,
//                 keyboardType: TextInputType.number,
//                 onSubmitted: (_) => _performSearch(),
//                 decoration: InputDecoration(
//                   hintText:
//                       "सेवाहरु खोज्न को लागि ( * ) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//                   hintStyle: const TextStyle(color: Colors.blue),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: const BorderSide(color: Colors.blue),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: const BorderSide(color: Colors.blue, width: 2),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: const Icon(
//                       Icons.search,
//                       size: 20,
//                       color: Colors.blue,
//                     ),
//                     onPressed: _performSearch,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           // RIGHT - Empty space same as sidebar width
//           const Expanded(flex: 2, child: SizedBox()),
//         ],
//       ),
//     );
//   }

//   // Main row containing table + sidebar
//   Widget _buildMainRow() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // LEFT - WaraBadapatra Table (80%)
//         Expanded(
//           flex: 8,
//           child: Container(
//             color: Colors.white,
//             child: WaraBadapatraTable(
//               searchCode: _searchCode,
//               onCodeTap: _showFullScreen,
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         // RIGHT - Sidebar + Team hierarchy (20%)
//         Expanded(
//           flex: 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: const [
//               SidebarWidget(),
//               SizedBox(height: 12),
//               TeamPage(scrollable: false),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

//############################################################################//

//PORTRAIT MODE:
// import 'package:flutter/material.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/footer.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";
//   int _selectedIndex = 0;

//   void _onFooterTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: ScrollConfiguration(
//           behavior: const ScrollBehavior().copyWith(
//             overscroll: false,
//             physics: const BouncingScrollPhysics(),
//           ),
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // 1️⃣ Header Section
//                 const HeaderSection(),

//                 // 2️⃣ Top News Bar
//                 const TopNewsBar(),

//                 // 3️⃣ Search Bar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(25),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 6,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: TextField(
//                       controller: _searchController,
//                       keyboardType: TextInputType.number,
//                       onSubmitted: (_) => _performSearch(),
//                       decoration: InputDecoration(
//                         hintText:
//                             "सेवा खोज्न * थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//                         hintStyle: const TextStyle(
//                           color: Colors.blue,
//                           fontSize: 13,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         border: InputBorder.none,
//                         suffixIcon: IconButton(
//                           icon: const Icon(
//                             Icons.search,
//                             size: 22,
//                             color: Colors.blue,
//                           ),
//                           onPressed: _performSearch,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // 4️⃣ Wara Badapatra Table + Sidebar + Team Hierarchy
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // 🧾 Table
//                       AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 300),
//                         child: WaraBadapatraTable(
//                           key: ValueKey(_searchCode),
//                           searchCode: _searchCode,
//                         ),
//                       ),

//                       const SizedBox(height: 24),

//                       // 🧱 Sidebar below table
//                       const SidebarWidget(),

//                       const SizedBox(height: 24),

//                       // 👥 Team Hierarchy
//                       const TeamPage(),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // 5️⃣ Bottom News Bar
//                 const BottomNewsBar(),

//                 const SizedBox(height: 20),

//                 // 6️⃣ Footer Navigation (optional)
//                 // FooterNavBar(selectedIndex: _selectedIndex, onTap: _onFooterTap),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//##################################################################################//
//BOTH:
//DONE TILL BOTH LANDSCAPE AND PORTRAIT MODE:

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/footer.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchCode = "";
//   Service? _selectedService;

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);

//     // Auto hide after 5 seconds
//     Timer(const Duration(seconds: 5), () {
//       setState(() => _selectedService = null);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: OrientationBuilder(
//           builder: (context, orientation) {
//             if (orientation == Orientation.portrait) {
//               // PORTRAIT LAYOUT
//               return ScrollConfiguration(
//                 behavior: const ScrollBehavior().copyWith(
//                   overscroll: false,
//                   physics: const BouncingScrollPhysics(),
//                 ),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const HeaderSection(),
//                       const TopNewsBar(),
//                       _buildSearchBar(),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             AnimatedSwitcher(
//                               duration: const Duration(milliseconds: 300),
//                               child: WaraBadapatraTable(
//                                 key: ValueKey(_searchCode),
//                                 searchCode: _searchCode,
//                                 onCodeTap: _showFullScreen,
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             const SidebarWidget(),
//                             const SizedBox(height: 24),
//                             const TeamPage(),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const BottomNewsBar(),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               // LANDSCAPE LAYOUT
//               return Stack(
//                 children: [
//                   SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const HeaderSection(),
//                           const TopNewsBar(),
//                           _buildSearchBar(),
//                           const SizedBox(height: 12),
//                           _buildMainRow(), // table + sidebar
//                           const SizedBox(height: 25),
//                           const BottomNewsBar(),
//                           const SizedBox(height: 25),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (_selectedService != null)
//                     Positioned.fill(
//                       child: Material(
//                         color: Colors.black87.withOpacity(0.9),
//                         child: SafeArea(
//                           child: Center(
//                             child: SingleChildScrollView(
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width * 0.9,
//                                 padding: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'कोड: ${_selectedService!.code}',
//                                       style: const TextStyle(
//                                         fontSize: 22,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Text(
//                                       'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Text(
//                                       'विवरण: ${_selectedService!.serviceRecDetail}',
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Text('शुल्क: ${_selectedService!.fee}'),
//                                     const SizedBox(height: 12),
//                                     Text('समय: ${_selectedService!.time}'),
//                                     const SizedBox(height: 12),
//                                     Text(
//                                       'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Text(
//                                       'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   // Search bar used in both layouts
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(25),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: TextField(
//           controller: _searchController,
//           keyboardType: TextInputType.number,
//           onSubmitted: (_) => _performSearch(),
//           decoration: InputDecoration(
//             hintText: "सेवा खोज्न * थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//             hintStyle: const TextStyle(color: Colors.blue, fontSize: 13),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 10,
//             ),
//             border: InputBorder.none,
//             suffixIcon: IconButton(
//               icon: const Icon(Icons.search, size: 22, color: Colors.blue),
//               onPressed: _performSearch,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Landscape main row (table + sidebar) – FIXED HORIZONTAL ALIGNMENT
//   Widget _buildMainRow() {
//     return IntrinsicHeight(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Left Table
//           Expanded(
//             flex: 8,
//             child: Container(
//               color: Colors.white,
//               child: WaraBadapatraTable(
//                 searchCode: _searchCode,
//                 onCodeTap: _showFullScreen,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           // Right Sidebar + Team
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: const [
//                 SidebarWidget(),
//                 SizedBox(height: 12),
//                 TeamPage(scrollable: false),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//#################################################################################//

//working:

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Required for RawKeyboardListener

// import 'components/bottom_news_bar.dart';
// import 'components/footer.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';

// import 'team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode(); // For RawKeyboardListener
//   String _searchCode = "";
//   Service? _selectedService;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   void _performSearch() {
//     setState(() {
//       _searchCode = _searchController.text.trim();
//     });
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 5), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleKeyPress(RawKeyEvent event) {
//     if (event is! RawKeyDownEvent) return;

//     final logicalKey = event.logicalKey;
//     if (logicalKey.keyLabel == '*') {
//       if (_selectedService != null) {
//         setState(() => _selectedService = null); // Close overlay
//       } else {
//         FocusScope.of(context).requestFocus(_searchFocusNode);
//       }
//     }
//   }

//   void _handleStarInput() {
//     if (_selectedService != null) {
//       setState(() => _selectedService = null); // Close overlay
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: _handleKeyPress,
//         child: OrientationBuilder(
//           builder: (context, orientation) {
//             return orientation == Orientation.portrait
//                 ? _buildPortrait()
//                 : _buildLandscape();
//           },
//         ),
//       ),
//     );
//   }

//   // -------------------- Portrait Mode --------------------
//   Widget _buildPortrait() {
//     return ScrollConfiguration(
//       behavior: const ScrollBehavior().copyWith(overscroll: false),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(
//           parent: AlwaysScrollableScrollPhysics(),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const HeaderSection(),
//             const TopNewsBar(),
//             _buildSearchBar(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 300),
//                     child: ScrollConfiguration(
//                       behavior: const ScrollBehavior().copyWith(
//                         overscroll: false,
//                       ),
//                       child: WaraBadapatraTable(
//                         key: ValueKey(_searchCode),
//                         searchCode: _searchCode,
//                         onCodeTap: _showFullScreen,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   const SidebarWidget(),
//                   const SizedBox(height: 24),
//                   const TeamPage(),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const BottomNewsBar(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // -------------------- Landscape Mode --------------------
//   Widget _buildLandscape() {
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 8,
//             ), // reduced padding
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const HeaderSection(),
//                 const TopNewsBar(),
//                 _buildSearchBar(),
//                 const SizedBox(height: 12),
//                 _buildMainRow(),
//                 const SizedBox(height: 25),
//                 const BottomNewsBar(),
//                 const SizedBox(height: 25),
//               ],
//             ),
//           ),
//         ),
//         if (_selectedService != null)
//           Positioned.fill(
//             child: Material(
//               color: Colors.black87.withOpacity(0.9),
//               child: SafeArea(
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'कोड: ${_selectedService!.code}',
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                           ),
//                           const SizedBox(height: 12),
//                           Text('विवरण: ${_selectedService!.serviceRecDetail}'),
//                           const SizedBox(height: 12),
//                           Text('शुल्क: ${_selectedService!.fee}'),
//                           const SizedBox(height: 12),
//                           Text('समय: ${_selectedService!.time}'),
//                           const SizedBox(height: 12),
//                           Text(
//                             'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   // -------------------- Search Bar --------------------
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(25),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: TextField(
//           focusNode: _searchFocusNode,
//           controller: _searchController,
//           keyboardType: TextInputType.text,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp(r'[0-9*]')),
//           ],
//           onChanged: (value) {
//             if (value.contains('*')) {
//               _handleStarInput();
//               _searchController.text = _searchController.text.replaceAll(
//                 '*',
//                 '',
//               );
//               _searchController.selection = TextSelection.fromPosition(
//                 TextPosition(offset: _searchController.text.length),
//               );
//             }
//           },
//           onSubmitted: (_) => _performSearch(),
//           decoration: InputDecoration(
//             hintText:
//                 "सेवाहरु खोज्न को लागि (*) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//             hintStyle: const TextStyle(color: Colors.blue, fontSize: 13),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 10,
//             ),
//             border: InputBorder.none,
//             suffixIcon: IconButton(
//               icon: const Icon(Icons.search, size: 22, color: Colors.blue),
//               onPressed: _performSearch,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // -------------------- Landscape Main Row --------------------
//   Widget _buildMainRow() {
//     return IntrinsicHeight(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             flex: 8,
//             child: Container(
//               color: Colors.white,
//               child: ScrollConfiguration(
//                 behavior: const ScrollBehavior().copyWith(overscroll: false),
//                 child: WaraBadapatraTable(
//                   searchCode: _searchCode,
//                   onCodeTap: _showFullScreen,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 6), // reduced gap
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: const [
//                 SidebarWidget(),
//                 SizedBox(height: 12),
//                 TeamPage(scrollable: false),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//dont change

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import 'components/search_bar.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   void _performSearch() {
//     setState(() => _searchCode = _searchController.text.trim());
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 5), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleKeyPress(RawKeyEvent event) {
//     if (event is! RawKeyDownEvent) return;
//     if (event.logicalKey.keyLabel == '*') {
//       if (_selectedService != null) {
//         setState(() => _selectedService = null);
//       } else {
//         FocusScope.of(context).requestFocus(_searchFocusNode);
//       }
//     }
//   }

//   void _handleStarInput() {
//     if (_selectedService != null) {
//       setState(() => _selectedService = null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: _handleKeyPress,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final screenWidth = constraints.maxWidth;

//             // Use width thresholds for responsiveness
//             final isTablet = screenWidth >= 600 && screenWidth < 1200;
//             final isDesktop = screenWidth >= 1200;

//             if (isTablet || isDesktop) {
//               return _buildLandscape();
//             } else {
//               return _buildPortrait();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   // ---------------- Portrait Layout ----------------
//   Widget _buildPortrait() {
//     return ScrollConfiguration(
//       behavior: const ScrollBehavior().copyWith(overscroll: false),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const HeaderSection(),
//             const TopNewsBar(),
//             const SizedBox(height: 4),

//             // --- Search Bar ---
//             CustomSearchBar(
//               controller: _searchController,
//               focusNode: _searchFocusNode,
//               onSearch: _performSearch,
//               onChanged: (value) {
//                 if (value.contains('*')) {
//                   _handleStarInput();
//                   _searchController.text = _searchController.text.replaceAll(
//                     '*',
//                     '',
//                   );
//                   _searchController.selection = TextSelection.fromPosition(
//                     TextPosition(offset: _searchController.text.length),
//                   );
//                 }
//               },
//             ),
//             const SizedBox(height: 4),

//             // --- Table ---
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: WaraBadapatraTable(
//                 key: ValueKey(_searchCode),
//                 searchCode: _searchCode,
//                 onCodeTap: _showFullScreen,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // --- Sidebar (aligned with search bar) ---
//             const Padding(
//               padding: EdgeInsets.only(left: 16),
//               child: SidebarWidget(),
//             ),
//             const SizedBox(height: 24),
//             const TeamPage(),
//             const SizedBox(height: 20),
//             const BottomNewsBar(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- Landscape Layout ----------------
//   Widget _buildLandscape() {
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Stack(
//       children: [
//         SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const HeaderSection(),
//                 const TopNewsBar(),
//                 const SizedBox(height: 4),

//                 // --- Search Bar (full width aligned with table) ---
//                 SizedBox(
//                   width: screenWidth - 24,
//                   child: CustomSearchBar(
//                     controller: _searchController,
//                     focusNode: _searchFocusNode,
//                     onSearch: _performSearch,
//                     onChanged: (value) {
//                       if (value.contains('*')) {
//                         _handleStarInput();
//                         _searchController.text = _searchController.text
//                             .replaceAll('*', '');
//                         _searchController
//                             .selection = TextSelection.fromPosition(
//                           TextPosition(offset: _searchController.text.length),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 6),

//                 // --- Table + Sidebar side by side ---
//                 _buildMainRow(),

//                 const SizedBox(height: 25),
//                 const BottomNewsBar(),
//                 const SizedBox(height: 25),
//               ],
//             ),
//           ),
//         ),

//         // ---------------- Fullscreen Overlay ----------------
//         if (_selectedService != null)
//           Positioned.fill(
//             child: Material(
//               color: Colors.black87.withOpacity(0.9),
//               child: SafeArea(
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'कोड: ${_selectedService!.code}',
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                           ),
//                           const SizedBox(height: 12),
//                           Text('विवरण: ${_selectedService!.serviceRecDetail}'),
//                           const SizedBox(height: 12),
//                           Text('शुल्क: ${_selectedService!.fee}'),
//                           const SizedBox(height: 12),
//                           Text('समय: ${_selectedService!.time}'),
//                           const SizedBox(height: 12),
//                           Text(
//                             'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   // ---------------- Main Row (Table + Sidebar) ----------------
//   Widget _buildMainRow() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double totalWidth = constraints.maxWidth;
//         final double tableWidth = totalWidth * 0.85;
//         final double sidebarWidth = totalWidth * 0.15;

//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // --- Table (85%) ---
//             SizedBox(
//               width: tableWidth,
//               child: Container(
//                 color: Colors.white,
//                 child: WaraBadapatraTable(
//                   searchCode: _searchCode,
//                   onCodeTap: _showFullScreen,
//                 ),
//               ),
//             ),

//             const SizedBox(width: 8),

//             // --- Sidebar (15%) ---
//             SizedBox(
//               width: sidebarWidth - 8, // minus gap
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   SidebarWidget(),
//                   SizedBox(height: 12),
//                   TeamPage(scrollable: false),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

//##################################################################################//

//working

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import 'components/search_bar.dart';

// class FinalHomePage extends StatefulWidget {
//   const FinalHomePage({super.key});

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   void _performSearch() {
//     setState(() => _searchCode = _searchController.text.trim());
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 5), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleKeyPress(RawKeyEvent event) {
//     if (event is! RawKeyDownEvent) return;
//     if (event.logicalKey.keyLabel == '*') {
//       if (_selectedService != null) {
//         setState(() => _selectedService = null);
//       } else {
//         FocusScope.of(context).requestFocus(_searchFocusNode);
//       }
//     }
//   }

//   void _handleStarInput() {
//     if (_selectedService != null) {
//       setState(() => _selectedService = null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: _handleKeyPress,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final screenWidth = constraints.maxWidth;
//             final isTablet = screenWidth >= 600 && screenWidth < 1200;
//             final isDesktop = screenWidth >= 1200;

//             if (isTablet || isDesktop) {
//               return _buildLandscape();
//             } else {
//               return _buildPortrait();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   // ---------------- Portrait Layout ----------------
//   Widget _buildPortrait() {
//     return ScrollConfiguration(
//       behavior: const ScrollBehavior().copyWith(overscroll: false),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const HeaderSection(),
//             const TopNewsBar(),
//             const SizedBox(height: 4),

//             // --- Search Bar ---
//             CustomSearchBar(
//               controller: _searchController,
//               focusNode: _searchFocusNode,
//               onSearch: _performSearch,
//               onChanged: (value) {
//                 if (value.contains('*')) {
//                   _handleStarInput();
//                   _searchController.text = _searchController.text.replaceAll(
//                     '*',
//                     '',
//                   );
//                   _searchController.selection = TextSelection.fromPosition(
//                     TextPosition(offset: _searchController.text.length),
//                   );
//                 }
//               },
//             ),
//             const SizedBox(height: 4),

//             // --- Table ---
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: WaraBadapatraTable(
//                 key: ValueKey(_searchCode),
//                 searchCode: _searchCode,
//                 onCodeTap: _showFullScreen,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // --- Sidebar ---
//             const Padding(
//               padding: EdgeInsets.only(left: 16),
//               child: SidebarWidget(),
//             ),
//             const SizedBox(height: 24),
//             const TeamPage(),
//             const SizedBox(height: 20),
//             const BottomNewsBar(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- Landscape Layout (TV-optimized) ----------------
//   Widget _buildLandscape() {
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Stack(
//       children: [
//         SingleChildScrollView(
//           child: Center(
//             // ← Center on huge screens
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: 1400,
//               ), // ← Prevent stretch on TV
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const HeaderSection(),
//                     const TopNewsBar(),
//                     const SizedBox(height: 4),

//                     // --- Search Bar ---
//                     SizedBox(
//                       width: screenWidth - 24,
//                       child: CustomSearchBar(
//                         controller: _searchController,
//                         focusNode: _searchFocusNode,
//                         onSearch: _performSearch,
//                         onChanged: (value) {
//                           if (value.contains('*')) {
//                             _handleStarInput();
//                             _searchController.text = _searchController.text
//                                 .replaceAll('*', '');
//                             _searchController
//                                 .selection = TextSelection.fromPosition(
//                               TextPosition(
//                                 offset: _searchController.text.length,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 6),

//                     // --- Table + Sidebar ---
//                     _buildMainRow(),

//                     const SizedBox(height: 25),
//                     const BottomNewsBar(),
//                     const SizedBox(height: 25),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // ---------------- Fullscreen Overlay (capped width) ----------------
//         if (_selectedService != null)
//           Positioned.fill(
//             child: Material(
//               color: Colors.black87.withOpacity(0.9),
//               child: SafeArea(
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       constraints: const BoxConstraints(
//                         maxWidth: 1000,
//                       ), // ← Readable on TV
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'कोड: ${_selectedService!.code}',
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                           ),
//                           const SizedBox(height: 12),
//                           Text('विवरण: ${_selectedService!.serviceRecDetail}'),
//                           const SizedBox(height: 12),
//                           Text('शुल्क: ${_selectedService!.fee}'),
//                           const SizedBox(height: 12),
//                           Text('समय: ${_selectedService!.time}'),
//                           const SizedBox(height: 12),
//                           Text(
//                             'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   // ---------------- Main Row (Table + Sidebar) ----------------
//   Widget _buildMainRow() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double totalWidth = constraints.maxWidth;
//         final double tableWidth = totalWidth * 0.85;
//         final double sidebarWidth = totalWidth * 0.15;

//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // --- Table (85%) ---
//             SizedBox(
//               width: tableWidth,
//               child: Container(
//                 color: Colors.white,
//                 child: WaraBadapatraTable(
//                   searchCode: _searchCode,
//                   onCodeTap: _showFullScreen,
//                 ),
//               ),
//             ),

//             const SizedBox(width: 8),

//             // --- Sidebar (15%) ---
//             SizedBox(
//               width: sidebarWidth - 8,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   SidebarWidget(),
//                   SizedBox(height: 12),
//                   TeamPage(scrollable: false),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

//changed:
//BEFORE HEADER:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import 'components/search_bar.dart';
// import 'services/socket_table_service.dart';
// import 'login_page.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {}; // <-- store API organization info

//   @override
//   void initState() {
//     super.initState();
//     fetchOrganizationInfo(); // fetch org info from API

//     SocketTableService().onTableUpdate(
//       (data) => print('📡 Table updated: $data'),
//     );
//     SocketTableService().onYoutubeCommand(
//       (videoId) => print('▶️ Play YouTube video: $videoId'),
//     );
//     SocketTableService().onAdminRestart(() {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => const LoginPage()),
//         (route) => false,
//       );
//     });
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/login'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success' && data['organization_info'] != null) {
//           setState(() {
//             orgInfo = data['organization_info'];
//           });
//         }
//       } else {
//         print("Failed to fetch org info: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 5), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleStarInput() {
//     if (_selectedService != null) setState(() => _selectedService = null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _handleStarInput();
//         },
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final screenWidth = constraints.maxWidth;
//             final isTablet = screenWidth >= 600 && screenWidth < 1200;
//             final isDesktop = screenWidth >= 1200;

//             return (isTablet || isDesktop)
//                 ? _buildLandscape()
//                 : _buildPortrait();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPortrait() {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           HeaderSection(orgInfo: orgInfo), // <-- now fetches from API
//           const TopNewsBar(),
//           const SizedBox(height: 4),
//           CustomSearchBar(
//             controller: _searchController,
//             focusNode: _searchFocusNode,
//             onSearch: _performSearch,
//             onChanged: (value) {
//               if (value.contains('*')) {
//                 _handleStarInput();
//                 _searchController.text =
//                     _searchController.text.replaceAll('*', '');
//                 _searchController.selection = TextSelection.fromPosition(
//                   TextPosition(offset: _searchController.text.length),
//                 );
//               }
//             },
//           ),
//           const SizedBox(height: 4),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: WaraBadapatraTable(
//               key: ValueKey(_searchCode),
//               searchCode: _searchCode,
//               onCodeTap: _showFullScreen,
//               userid: widget.userid,
//               orgid: widget.orgid,
//               orgCode: widget.orgCode,
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Padding(
//             padding: EdgeInsets.only(left: 16),
//             child: SidebarWidget(),
//           ),
//           const SizedBox(height: 24),
//           const TeamPage(),
//           const SizedBox(height: 20),
//           const BottomNewsBar(),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildLandscape() {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Stack(
//       children: [
//         SingleChildScrollView(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 1400),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     HeaderSection(orgInfo: orgInfo),
//                     const TopNewsBar(),
//                     const SizedBox(height: 4),
//                     SizedBox(
//                       width: screenWidth - 24,
//                       child: CustomSearchBar(
//                         controller: _searchController,
//                         focusNode: _searchFocusNode,
//                         onSearch: _performSearch,
//                         onChanged: (value) {
//                           if (value.contains('*')) {
//                             _handleStarInput();
//                             _searchController.text =
//                                 _searchController.text.replaceAll('*', '');
//                             _searchController.selection =
//                                 TextSelection.fromPosition(
//                               TextPosition(
//                                 offset: _searchController.text.length,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     _buildMainRow(),
//                     const SizedBox(height: 25),
//                     const BottomNewsBar(),
//                     const SizedBox(height: 25),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (_selectedService != null)
//           Positioned.fill(
//             child: Material(
//               color: Colors.black87.withOpacity(0.9),
//               child: SafeArea(
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       width: screenWidth * 0.9,
//                       constraints: const BoxConstraints(maxWidth: 1000),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: _buildServiceDetails(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildServiceDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'कोड: ${_selectedService!.code}',
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.red,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text('सेवा किसिम: ${_selectedService!.serviceTypeName}'),
//         const SizedBox(height: 12),
//         Text('विवरण: ${_selectedService!.serviceRecDetail}'),
//         const SizedBox(height: 12),
//         Text('शुल्क: ${_selectedService!.fee}'),
//         const SizedBox(height: 12),
//         Text('समय: ${_selectedService!.time}'),
//         const SizedBox(height: 12),
//         Text('सेवा दिने शाखा: ${_selectedService!.serviceProvider}'),
//         const SizedBox(height: 12),
//         Text('गुनासो अधिकारी: ${_selectedService!.complainListen}'),
//       ],
//     );
//   }

//   Widget _buildMainRow() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final totalWidth = constraints.maxWidth;
//         final tableWidth = totalWidth * 0.85;
//         final sidebarWidth = totalWidth * 0.15;

//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: tableWidth,
//               child: Container(
//                 color: Colors.white,
//                 child: WaraBadapatraTable(
//                   searchCode: _searchCode,
//                   onCodeTap: _showFullScreen,
//                   userid: widget.userid,
//                   orgid: widget.orgid,
//                   orgCode: widget.orgCode,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             SizedBox(
//               width: sidebarWidth - 8,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   SidebarWidget(),
//                   SizedBox(height: 12),
//                   TeamPage(scrollable: false),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

//#################################################################################//

//AFTER HEADER:
// 2050:

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart';
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData; // full login response

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   bool isLoadingOrgInfo = true;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     fetchOrganizationInfo(); // fetch table data dynamically
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = Map<String, dynamic>.from(jsonDecode(response.body));

//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         } else {
//           setState(() => isLoadingOrgInfo = false);
//           print('Failed to fetch organization info');
//         }
//       } else {
//         print("Failed to fetch org info: ${response.statusCode}");
//         setState(() => isLoadingOrgInfo = false);
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 5), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleStarInput() {
//     if (_selectedService != null) setState(() => _selectedService = null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _handleStarInput();
//         },
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               HeaderSection(orgInfo: orgInfo),
//               const TopNewsBar(),
//               const SizedBox(height: 4),
//               CustomSearchBar(
//                 controller: _searchController,
//                 focusNode: _searchFocusNode,
//                 onSearch: _performSearch,
//                 onChanged: (value) {
//                   if (value.contains('*')) {
//                     _handleStarInput();
//                     _searchController.text = _searchController.text.replaceAll(
//                       '*',
//                       '',
//                     );
//                     _searchController.selection = TextSelection.fromPosition(
//                       TextPosition(offset: _searchController.text.length),
//                     );
//                   }
//                 },
//               ),
//               const SizedBox(height: 4),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: WaraBadapatraTable(
//                   key: ValueKey(_searchCode),
//                   searchCode: _searchCode,
//                   onCodeTap: _showFullScreen,
//                   userid: widget.userid,
//                   orgid: widget.orgid,
//                   orgCode: widget.orgCode,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               widget.teams.isNotEmpty
//                   ? TeamPage(scrollable: true, teams: widget.teams)
//                   : const Center(child: Text('No team members found.')),
//               const SizedBox(height: 24),
//               const Padding(
//                 padding: EdgeInsets.only(left: 16),
//                 child: SidebarWidget(),
//               ),
//               const SizedBox(height: 20),
//               BottomNewsBar(
//                 newsItems: rssItems,
//                 rssType: widget.loginData['rss_type'] ?? 'News',
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//AAZZ:
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart';
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   bool isLoadingOrgInfo = true;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     fetchOrganizationInfo();
//     super.initState();
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       // silent
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _performSearch() {
//     setState(() => _searchCode = _searchController.text.trim());
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') {
//             if (_selectedService != null) {
//               setState(() => _selectedService = null);
//             }
//           }
//         },
//         child: isLandscape ? _buildLandscape() : _buildPortrait(),
//       ),
//     );
//   }

//   // ==================== PORTRAIT LAYOUT ====================
//   Widget _buildPortrait() {
//     return Column(
//       children: [
//         HeaderSection(orgInfo: orgInfo),
//         const TopNewsBar(),
//         const SizedBox(height: 4),
//         CustomSearchBar(
//           controller: _searchController,
//           focusNode: _searchFocusNode,
//           onSearch: _performSearch,
//           onChanged: (value) {
//             if (value.contains('*')) {
//               setState(() => _selectedService = null);
//               _searchController.text = value.replaceAll('*', '');
//               _searchController.selection = TextSelection.fromPosition(
//                 TextPosition(offset: _searchController.text.length),
//               );
//             }
//           },
//         ),
//         const SizedBox(height: 8),

//         // TABLE — full width
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: WaraBadapatraTable(
//               key: ValueKey(_searchCode),
//               searchCode: _searchCode,
//               onCodeTap: _showFullScreen,
//               userid: widget.userid,
//               orgid: widget.orgid,
//               orgCode: widget.orgCode,
//             ),
//           ),
//         ),

//         const SizedBox(height: 16),

//         // BOTTOM CONTENT
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 widget.teams.isNotEmpty
//                     ? TeamPage(scrollable: false, teams: widget.teams)
//                     : const SizedBox(height: 20),
//                 const SizedBox(height: 20),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 16),
//                   child: SidebarWidget(),
//                 ),
//                 const SizedBox(height: 20),
//                 BottomNewsBar(
//                   newsItems: rssItems,
//                   rssType: widget.loginData['rss_type'] ?? 'News',
//                 ),
//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ==================== LANDSCAPE LAYOUT ====================
//   Widget _buildLandscape() {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             HeaderSection(orgInfo: orgInfo),
//             const TopNewsBar(),
//             const SizedBox(height: 4),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: CustomSearchBar(
//                 controller: _searchController,
//                 focusNode: _searchFocusNode,
//                 onSearch: _performSearch,
//                 onChanged: (v) {
//                   if (v.contains('*')) {
//                     setState(() => _selectedService = null);
//                     _searchController.text = v.replaceAll('*', '');
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 12),

//             // MAIN ROW: Table (85%) + Right Panel (15%)
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // TABLE — 85%
//                   Expanded(
//                     flex: 85,
//                     child: WaraBadapatraTable(
//                       searchCode: _searchCode,
//                       onCodeTap: _showFullScreen,
//                       userid: widget.userid,
//                       orgid: widget.orgid,
//                       orgCode: widget.orgCode,
//                     ),
//                   ),

//                   const SizedBox(width: 12),

//                   // RIGHT PANEL — 15%
//                   Expanded(
//                     flex: 15,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           const SidebarWidget(),
//                           const SizedBox(height: 20),
//                           if (widget.teams.isNotEmpty)
//                             TeamPage(scrollable: false, teams: widget.teams),
//                           const SizedBox(height: 30),
//                           BottomNewsBar(
//                             newsItems: rssItems,
//                             rssType: widget.loginData['rss_type'] ?? 'News',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         // FULL SCREEN POPUP OVERLAY
//         if (_selectedService != null)
//           Positioned.fill(
//             child: Material(
//               color: Colors.black87.withOpacity(0.94),
//               child: Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   padding: const EdgeInsets.all(32),
//                   margin: const EdgeInsets.all(40),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(color: Colors.black38, blurRadius: 20),
//                     ],
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'कोड: ${_selectedService!.code}',
//                           style: const TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           'सेवा: ${_selectedService!.serviceTypeName ?? ''}',
//                           style: const TextStyle(fontSize: 26),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'विवरण: ${_selectedService!.serviceRecDetail ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'शुल्क: ${_selectedService!.fee ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'समय: ${_selectedService!.time ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'शाखा: ${_selectedService!.serviceProvider ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'गुनासो अधिकारी: ${_selectedService!.complainListen ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         const SizedBox(height: 40),
//                         const Center(
//                           child: Text(
//                             "∗ थिचेर बन्द गर्नुहोस्",
//                             style: TextStyle(color: Colors.grey, fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

//scrolling good:

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   bool isLoadingOrgInfo = true;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     fetchOrganizationInfo();
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       // silent
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _performSearch() {
//     setState(() => _searchCode = _searchController.text.trim());
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') {
//             if (_selectedService != null) {
//               setState(() => _selectedService = null);
//             }
//           }
//         },
//         child: isLandscape ? _buildLandscape() : _buildPortrait(),
//       ),
//     );
//   }

//   // ==================== PORTRAIT LAYOUT ====================
//   Widget _buildPortrait() {
//     return Column(
//       children: [
//         HeaderSection(orgInfo: orgInfo),
//         const TopNewsBar(),
//         const SizedBox(height: 4),

//         // SEARCH BAR
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: CustomSearchBar(
//             controller: _searchController,
//             focusNode: _searchFocusNode,
//             onSearch: _performSearch,
//             onChanged: (value) {
//               if (value.contains('*')) {
//                 setState(() => _selectedService = null);
//                 _searchController.text = value.replaceAll('*', '');
//                 _searchController.selection = TextSelection.fromPosition(
//                   TextPosition(offset: _searchController.text.length),
//                 );
//               }
//             },
//           ),
//         ),
//         const SizedBox(height: 8),

//         // SCROLLABLE CONTENT (Table + Bottom Content + News Bar)
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // TABLE
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: WaraBadapatraTable(
//                       key: ValueKey(_searchCode),
//                       searchCode: _searchCode,
//                       onCodeTap: _showFullScreen,
//                       userid: widget.userid,
//                       orgid: widget.orgid,
//                       orgCode: widget.orgCode,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 // TEAM PAGE
//                 if (widget.teams.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: TeamPage(scrollable: false, teams: widget.teams),
//                   ),

//                 const SizedBox(height: 20),

//                 // SIDEBAR/QR CODE
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: SidebarWidget(),
//                 ),

//                 const SizedBox(height: 20),

//                 // BOTTOM NEWS BAR (appears while scrolling)
//                 SizedBox(
//                   height: 35,
//                   width: double.infinity,
//                   child: BottomNewsBar(
//                     newsItems: rssItems,
//                     rssType: widget.loginData['rss_type'] ?? 'News',
//                   ),
//                 ),

//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ==================== LANDSCAPE LAYOUT ====================
//   Widget _buildLandscape() {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             // HEADER SECTION
//             HeaderSection(orgInfo: orgInfo),
//             const TopNewsBar(),
//             const SizedBox(height: 8),

//             // MAIN CONTENT
//             Expanded(
//               child: Column(
//                 children: [
//                   // SEARCH BAR - Only spans the table width (85%)
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 85,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: CustomSearchBar(
//                             controller: _searchController,
//                             focusNode: _searchFocusNode,
//                             onSearch: _performSearch,
//                             onChanged: (v) {
//                               if (v.contains('*')) {
//                                 setState(() => _selectedService = null);
//                                 _searchController.text = v.replaceAll('*', '');
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       const Expanded(flex: 15, child: SizedBox()),
//                     ],
//                   ),
//                   const SizedBox(height: 12),

//                   // SCROLLABLE CONTENT (Table + Right Panel + News Bar)
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           // TABLE + RIGHT PANEL ROW
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.7,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // LEFT: TABLE — 85%
//                                 Expanded(
//                                   flex: 85,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                       left: 16,
//                                       right: 8,
//                                     ),
//                                     child: WaraBadapatraTable(
//                                       searchCode: _searchCode,
//                                       onCodeTap: _showFullScreen,
//                                       userid: widget.userid,
//                                       orgid: widget.orgid,
//                                       orgCode: widget.orgCode,
//                                     ),
//                                   ),
//                                 ),

//                                 // RIGHT PANEL — 15%
//                                 Expanded(
//                                   flex: 15,
//                                   child: Container(
//                                     color: Colors.grey[100],
//                                     padding: const EdgeInsets.all(12),
//                                     child: SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           // TEAM PAGE at TOP
//                                           if (widget.teams.isNotEmpty) ...[
//                                             TeamPage(
//                                               scrollable: false,
//                                               teams: widget.teams,
//                                             ),
//                                             const SizedBox(height: 20),
//                                           ],

//                                           // QR CODE at BOTTOM
//                                           const SidebarWidget(),
//                                           const SizedBox(height: 12),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // BOTTOM NEWS BAR (appears while scrolling)
//                           SizedBox(
//                             height: 35,
//                             width: double.infinity,
//                             child: BottomNewsBar(
//                               newsItems: rssItems,
//                               rssType: widget.loginData['rss_type'] ?? 'News',
//                             ),
//                           ),

//                           const SizedBox(height: 40),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         // FULL SCREEN POPUP OVERLAY
//         if (_selectedService != null)
//           Positioned.fill(
//             child: Material(
//               color: Colors.black87.withOpacity(0.94),
//               child: Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   padding: const EdgeInsets.all(32),
//                   margin: const EdgeInsets.all(40),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(color: Colors.black38, blurRadius: 20),
//                     ],
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'कोड: ${_selectedService!.code}',
//                           style: const TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           'सेवा: ${_selectedService!.serviceTypeName ?? ''}',
//                           style: const TextStyle(fontSize: 26),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'विवरण: ${_selectedService!.serviceRecDetail ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'शुल्क: ${_selectedService!.fee ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'समय: ${_selectedService!.time ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'शाखा: ${_selectedService!.serviceProvider ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'गुनासो अधिकारी: ${_selectedService!.complainListen ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         const SizedBox(height: 40),
//                         const Center(
//                           child: Text(
//                             "∗ थिचेर बन्द गर्नुहोस्",
//                             style: TextStyle(color: Colors.grey, fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   bool isLoadingOrgInfo = true;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     fetchOrganizationInfo();
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       // silent
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _performSearch() {
//     setState(() => _searchCode = _searchController.text.trim());
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') {
//             if (_selectedService != null) {
//               setState(() => _selectedService = null);
//             }
//           }
//         },
//         child: isLandscape ? _buildLandscape() : _buildPortrait(),
//       ),
//     );
//   }

//   // ==================== PORTRAIT LAYOUT ====================
//   Widget _buildPortrait() {
//     return Column(
//       children: [
//         HeaderSection(orgInfo: orgInfo),
//         const TopNewsBar(),
//         const SizedBox(height: 4),

//         // SEARCH BAR
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: CustomSearchBar(
//             controller: _searchController,
//             focusNode: _searchFocusNode,
//             onSearch: _performSearch,
//             onChanged: (value) {
//               if (value.contains('*')) {
//                 setState(() => _selectedService = null);
//                 _searchController.text = value.replaceAll('*', '');
//                 _searchController.selection = TextSelection.fromPosition(
//                   TextPosition(offset: _searchController.text.length),
//                 );
//               }
//             },
//           ),
//         ),
//         const SizedBox(height: 8),

//         // SCROLLABLE CONTENT (Table + Bottom Content + News Bar)
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // TABLE
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: WaraBadapatraTable(
//                       key: ValueKey(_searchCode),
//                       searchCode: _searchCode,
//                       onCodeTap: _showFullScreen,
//                       userid: widget.userid,
//                       orgid: widget.orgid,
//                       orgCode: widget.orgCode,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 // TEAM PAGE
//                 if (widget.teams.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: TeamPage(scrollable: false, teams: widget.teams),
//                   ),

//                 const SizedBox(height: 20),

//                 // SIDEBAR/QR CODE
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: SidebarWidget(),
//                 ),

//                 const SizedBox(height: 20),

//                 // BOTTOM NEWS BAR (appears while scrolling)
//                 SizedBox(
//                   height: 35,
//                   width: double.infinity,
//                   child: BottomNewsBar(
//                     newsItems: rssItems,
//                     rssType: widget.loginData['rss_type'] ?? 'News',
//                   ),
//                 ),

//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ==================== LANDSCAPE LAYOUT ====================
//   Widget _buildLandscape() {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             // HEADER SECTION
//             HeaderSection(orgInfo: orgInfo),
//             const TopNewsBar(),
//             const SizedBox(height: 8),

//             // MAIN CONTENT
//             Expanded(
//               child: Column(
//                 children: [
//                   // SEARCH BAR - Only spans the table width (85%)
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 85,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: CustomSearchBar(
//                             controller: _searchController,
//                             focusNode: _searchFocusNode,
//                             onSearch: _performSearch,
//                             onChanged: (v) {
//                               if (v.contains('*')) {
//                                 setState(() => _selectedService = null);
//                                 _searchController.text = v.replaceAll('*', '');
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       const Expanded(flex: 15, child: SizedBox()),
//                     ],
//                   ),
//                   const SizedBox(height: 12),

//                   // SCROLLABLE CONTENT (Table + Right Panel + News Bar)
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           // TABLE + RIGHT PANEL ROW
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.7,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // LEFT: TABLE — 85%
//                                 Expanded(
//                                   flex: 85,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 16),
//                                     child: WaraBadapatraTable(
//                                       searchCode: _searchCode,
//                                       onCodeTap: _showFullScreen,
//                                       userid: widget.userid,
//                                       orgid: widget.orgid,
//                                       orgCode: widget.orgCode,
//                                     ),
//                                   ),
//                                 ),

//                                 // RIGHT PANEL — 15% (No gap, aligned with table)
//                                 Expanded(
//                                   flex: 15,
//                                   child: Container(
//                                     color: Colors.grey[100],
//                                     padding: const EdgeInsets.only(
//                                       left: 12,
//                                       right: 12,
//                                       bottom: 12,
//                                     ),
//                                     child: SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           // TEAM PAGE at TOP
//                                           if (widget.teams.isNotEmpty) ...[
//                                             TeamPage(
//                                               scrollable: false,
//                                               teams: widget.teams,
//                                             ),
//                                             const SizedBox(height: 20),
//                                           ],

//                                           // QR CODE at BOTTOM
//                                           const SidebarWidget(),
//                                           const SizedBox(height: 12),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // BOTTOM NEWS BAR (appears while scrolling)
//                           SizedBox(
//                             height: 35,
//                             width: double.infinity,
//                             child: BottomNewsBar(
//                               newsItems: rssItems,
//                               rssType: widget.loginData['rss_type'] ?? 'News',
//                             ),
//                           ),

//                           const SizedBox(height: 40),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         // FULL SCREEN POPUP OVERLAY
//         if (_selectedService != null)
//           Positioned.fill(
//             child: Material(
//               color: Colors.black87.withOpacity(0.94),
//               child: Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   padding: const EdgeInsets.all(32),
//                   margin: const EdgeInsets.all(40),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(color: Colors.black38, blurRadius: 20),
//                     ],
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'कोड: ${_selectedService!.code}',
//                           style: const TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           'सेवा: ${_selectedService!.serviceTypeName ?? ''}',
//                           style: const TextStyle(fontSize: 26),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'विवरण: ${_selectedService!.serviceRecDetail ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'शुल्क: ${_selectedService!.fee ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'समय: ${_selectedService!.time ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'शाखा: ${_selectedService!.serviceProvider ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         Text(
//                           'गुनासो अधिकारी: ${_selectedService!.complainListen ?? ''}',
//                           style: const TextStyle(fontSize: 22),
//                         ),
//                         const SizedBox(height: 40),
//                         const Center(
//                           child: Text(
//                             "∗ थिचेर बन्द गर्नुहोस्",
//                             style: TextStyle(color: Colors.grey, fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

//after the socket :

// final_homepage.dart -set time by admin
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   bool isLoadingOrgInfo = true;

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     fetchOrganizationInfo();
//     _initializePusher();
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//     );
//   }

//   void _showVideoDialog(String url) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.zero,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.black87,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       constraints: BoxConstraints(
//                         maxHeight: MediaQuery.of(context).size.height * 0.7,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Header
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.warning_amber_rounded,
//                                   color: Colors.white,
//                                   size: 32,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'आपतकालीन प्रसारण',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         'EMERGENCY BROADCAST',
//                                         style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Video
//                           Expanded(
//                             child: Container(
//                               color: Colors.black,
//                               child:
//                                   _isYouTubeUrl(url)
//                                       ? YouTubeVideoWidget(url: url)
//                                       : VideoPlayerWidget(url: url),
//                             ),
//                           ),
//                           // Footer
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[900],
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Emergency Alert',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Received: ${DateTime.now().toString().substring(0, 19)}',
//                                       style: const TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     setState(() {
//                                       _videoUrl = null;
//                                       _isVideoPlaying = false;
//                                     });
//                                   },
//                                   icon: const Icon(Icons.close),
//                                   label: const Text('बन्द गर्नुहोस्'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 24,
//                                       vertical: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   bool _isYouTubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 HeaderSection(orgInfo: orgInfo),
//                 const TopNewsBar(),
//                 const SizedBox(height: 8),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: CustomSearchBar(
//                             controller: _searchController,
//                             focusNode: _searchFocusNode,
//                             onSearch: _performSearch,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.5,
//                           child: WaraBadapatraTable(
//                             key: ValueKey(_searchCode),
//                             searchCode: _searchCode,
//                             onCodeTap:
//                                 (service) =>
//                                     setState(() => _selectedService = service),
//                             userid: widget.userid,
//                             orgid: widget.orgid,
//                             orgCode: widget.orgCode,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         if (widget.teams.isNotEmpty)
//                           TeamPage(scrollable: false, teams: widget.teams),
//                         const SizedBox(height: 20),
//                         const SidebarWidget(),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: 35,
//                           width: double.infinity,
//                           child: BottomNewsBar(
//                             newsItems: rssItems,
//                             rssType: widget.loginData['rss_type'] ?? 'News',
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // VIDEO WIDGETS
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize()
//           .then((_) {
//             setState(() => _isInitialized = true);
//             _controller.play();
//             _controller.setLooping(false);
//           })
//           .catchError((e) => print("Video error: $e"));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized)
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     return Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }

// class YouTubeVideoWidget extends StatefulWidget {
//   final String url;
//   const YouTubeVideoWidget({super.key, required this.url});
//   @override
//   State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
// }

// class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
//   late YoutubePlayerController _controller;
//   String? _videoId;

//   @override
//   void initState() {
//     super.initState();
//     _videoId = YoutubePlayer.convertUrlToId(widget.url);
//     if (_videoId != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: _videoId!,
//         flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//       );
//     } else {
//       print("❌ Invalid YouTube URL: ${widget.url}");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoId == null)
//       return const Center(
//         child: Text(
//           'Invalid YouTube URL',
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }
// }

//immediate:

// final_homepage.dart - Play video immediately when admin sets URL

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   bool isLoadingOrgInfo = true;

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   // Add polling timer
//   Timer? _broadcastCheckTimer;
//   String? _lastBroadcastId;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     fetchOrganizationInfo();
//     _initializePusher();

//     // Start polling for broadcasts every 5 seconds
//     _startBroadcastPolling();
//   }

//   // NEW: Poll backend for latest broadcast
//   void _startBroadcastPolling() {
//     _broadcastCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkForNewBroadcast();
//     });
//   }

//   // NEW: Check if there's a new broadcast
//   Future<void> _checkForNewBroadcast() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_latest_broadcast'),
//         body: {
//           'orgid': widget.orgid,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Check if there's a broadcast and it's new
//         if (data['status'] == true && data['broadcast'] != null) {
//           final broadcast = data['broadcast'];
//           final broadcastId = broadcast['id']?.toString();
//           final videoUrl = broadcast['youtube_url'] ?? broadcast['url'] ?? '';

//           // If this is a new broadcast, play it immediately
//           if (broadcastId != null &&
//               broadcastId != _lastBroadcastId &&
//               videoUrl.isNotEmpty) {
//             _lastBroadcastId = broadcastId;

//             if (mounted) {
//               setState(() {
//                 _videoUrl = videoUrl;
//                 _isVideoPlaying = true;
//               });
//               _showVideoDialog(videoUrl);
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error checking for broadcast: $e");
//     }
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//     );
//   }

//   void _showVideoDialog(String url) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.zero,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.black87,
//           child: Stack(
//             children: [
//               Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   constraints: BoxConstraints(
//                     maxHeight: MediaQuery.of(context).size.height * 0.7,
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Header
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(12),
//                             topRight: Radius.circular(12),
//                           ),
//                         ),
//                         child: Row(
//                           children: const [
//                             Icon(
//                               Icons.warning_amber_rounded,
//                               color: Colors.white,
//                               size: 32,
//                             ),
//                             SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'आपतकालीन प्रसारण',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'EMERGENCY BROADCAST',
//                                     style: TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Video
//                       Expanded(
//                         child: Container(
//                           color: Colors.black,
//                           child: _isYouTubeUrl(url)
//                               ? YouTubeVideoWidget(url: url)
//                               : VideoPlayerWidget(url: url),
//                         ),
//                       ),
//                       // Footer
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[900],
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(12),
//                             bottomRight: Radius.circular(12),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Emergency Alert',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Received: ${DateTime.now().toString().substring(0, 19)}',
//                                   style: const TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 setState(() {
//                                   _videoUrl = null;
//                                   _isVideoPlaying = false;
//                                 });
//                               },
//                               icon: const Icon(Icons.close),
//                               label: const Text('बन्द गर्नुहोस्'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                                 foregroundColor: Colors.white,
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 24,
//                                   vertical: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   bool _isYouTubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     _broadcastCheckTimer?.cancel(); // Cancel polling timer
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 HeaderSection(orgInfo: orgInfo),
//                 const TopNewsBar(),
//                 const SizedBox(height: 8),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: CustomSearchBar(
//                             controller: _searchController,
//                             focusNode: _searchFocusNode,
//                             onSearch: _performSearch,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.5,
//                           child: WaraBadapatraTable(
//                             key: ValueKey(_searchCode),
//                             searchCode: _searchCode,
//                             onCodeTap: (service) =>
//                                 setState(() => _selectedService = service),
//                             userid: widget.userid,
//                             orgid: widget.orgid,
//                             orgCode: widget.orgCode,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         if (widget.teams.isNotEmpty)
//                           TeamPage(scrollable: false, teams: widget.teams),
//                         const SizedBox(height: 20),
//                         const SidebarWidget(),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: 35,
//                           width: double.infinity,
//                           child: BottomNewsBar(
//                             newsItems: rssItems,
//                             rssType: widget.loginData['rss_type'] ?? 'News',
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // VIDEO WIDGETS
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize().then((_) {
//         setState(() => _isInitialized = true);
//         _controller.play();
//         _controller.setLooping(false);
//       }).catchError((e) => print("Video error: $e"));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized)
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     return Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }

// class YouTubeVideoWidget extends StatefulWidget {
//   final String url;
//   const YouTubeVideoWidget({super.key, required this.url});
//   @override
//   State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
// }

// class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
//   late YoutubePlayerController _controller;
//   String? _videoId;

//   @override
//   void initState() {
//     super.initState();
//     _videoId = YoutubePlayer.convertUrlToId(widget.url);
//     if (_videoId != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: _videoId!,
//         flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//       );
//     } else {
//       print("❌ Invalid YouTube URL: ${widget.url}");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoId == null)
//       return const Center(
//         child: Text(
//           'Invalid YouTube URL',
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }
// }

//video stop:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   bool isLoadingOrgInfo = true;

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   // Add polling timer
//   Timer? _broadcastCheckTimer;
//   String? _lastBroadcastId;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     fetchOrganizationInfo();
//     _initializePusher();

//     // Start polling for broadcasts every 5 seconds
//     _startBroadcastPolling();
//   }

//   // NEW: Poll backend for latest broadcast
//   void _startBroadcastPolling() {
//     _broadcastCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkForNewBroadcast();
//     });
//   }

//   // UPDATED: Check if there's a new broadcast or if it was cleared (for restart)
//   Future<void> _checkForNewBroadcast() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_latest_broadcast',
//         ),
//         body: {'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Check if there's a broadcast and it's new
//         if (data['status'] == true) {
//           final broadcast = data['broadcast'];
//           final broadcastId =
//               broadcast?['id']?.toString(); // Handle null broadcast
//           final videoUrl = broadcast?['youtube_url'] ?? broadcast?['url'] ?? '';

//           if (broadcast == null || videoUrl.isEmpty) {
//             // NEW: If no broadcast or empty URL (restart signal), close video if playing
//             if (_isVideoPlaying && mounted) {
//               _closeVideo();
//               _lastBroadcastId = null;
//             }
//             return;
//           }

//           // If this is a new broadcast, play it immediately
//           if (broadcastId != null &&
//               broadcastId != _lastBroadcastId &&
//               videoUrl.isNotEmpty) {
//             _lastBroadcastId = broadcastId;

//             if (mounted) {
//               setState(() {
//                 _videoUrl = videoUrl;
//                 _isVideoPlaying = true;
//               });
//               _showVideoDialog(videoUrl);
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error checking for broadcast: $e");
//     }
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//       onRestart: _closeVideo,
//     );
//   }

//   // NEW: Method to close the video dialog and reset state
//   void _closeVideo() {
//     if (_isVideoPlaying && mounted) {
//       Navigator.pop(context); // Close the dialog (assumes it's the top route)
//       setState(() {
//         _videoUrl = null;
//         _isVideoPlaying = false;
//       });
//     }
//   }

//   void _showVideoDialog(String url) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.zero,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.black87,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       constraints: BoxConstraints(
//                         maxHeight: MediaQuery.of(context).size.height * 0.7,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Header
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.warning_amber_rounded,
//                                   color: Colors.white,
//                                   size: 32,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'आपतकालीन प्रसारण',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         'EMERGENCY BROADCAST',
//                                         style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Video
//                           Expanded(
//                             child: Container(
//                               color: Colors.black,
//                               child:
//                                   _isYouTubeUrl(url)
//                                       ? YouTubeVideoWidget(url: url)
//                                       : VideoPlayerWidget(url: url),
//                             ),
//                           ),
//                           // Footer
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[900],
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Emergency Alert',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Received: ${DateTime.now().toString().substring(0, 19)}',
//                                       style: const TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     setState(() {
//                                       _videoUrl = null;
//                                       _isVideoPlaying = false;
//                                     });
//                                   },
//                                   icon: const Icon(Icons.close),
//                                   label: const Text('बन्द गर्नुहोस्'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 24,
//                                       vertical: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   bool _isYouTubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     _broadcastCheckTimer?.cancel(); // Cancel polling timer
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 HeaderSection(orgInfo: orgInfo),
//                 const TopNewsBar(),
//                 const SizedBox(height: 8),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: CustomSearchBar(
//                             controller: _searchController,
//                             focusNode: _searchFocusNode,
//                             onSearch: _performSearch,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.5,
//                           child: WaraBadapatraTable(
//                             key: ValueKey(_searchCode),
//                             searchCode: _searchCode,
//                             onCodeTap:
//                                 (service) =>
//                                     setState(() => _selectedService = service),
//                             userid: widget.userid,
//                             orgid: widget.orgid,
//                             orgCode: widget.orgCode,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         if (widget.teams.isNotEmpty)
//                           TeamPage(scrollable: false, teams: widget.teams),
//                         const SizedBox(height: 20),
//                         const SidebarWidget(),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: 35,
//                           width: double.infinity,
//                           child: BottomNewsBar(
//                             newsItems: rssItems,
//                             rssType: widget.loginData['rss_type'] ?? 'News',
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // VIDEO WIDGETS
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize()
//           .then((_) {
//             setState(() => _isInitialized = true);
//             _controller.play();
//             _controller.setLooping(false);
//           })
//           .catchError((e) => print("Video error: $e"));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized)
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     return Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }

// class YouTubeVideoWidget extends StatefulWidget {
//   final String url;
//   const YouTubeVideoWidget({super.key, required this.url});
//   @override
//   State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
// }

// class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
//   late YoutubePlayerController _controller;
//   String? _videoId;

//   @override
//   void initState() {
//     super.initState();
//     _videoId = YoutubePlayer.convertUrlToId(widget.url);
//     if (_videoId != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: _videoId!,
//         flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//       );
//     } else {
//       print("❌ Invalid YouTube URL: ${widget.url}");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoId == null)
//       return const Center(
//         child: Text(
//           'Invalid YouTube URL',
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }
// }

//actual restart:
// final_homepage.dart - Play video immediately when admin sets URL and close video immediately when admin clicks restart
// final_homepage.dart - Play video immediately when admin sets URL and close video immediately when admin clicks restart

//BEFORE LAYOUT:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   List<dynamic> _teams = []; // NEW: Mutable teams list in state
//   bool isLoadingOrgInfo = true;

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   // Add polling timer
//   Timer? _broadcastCheckTimer;
//   String? _lastBroadcastId;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     _teams = List.from(widget.teams); // NEW: Initialize mutable teams
//     fetchOrganizationInfo();
//     _initializePusher();

//     // Start polling for broadcasts every 5 seconds
//     _startBroadcastPolling();
//   }

//   // NEW: Poll backend for latest broadcast
//   void _startBroadcastPolling() {
//     _broadcastCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkForNewBroadcast();
//     });
//   }

//   // UPDATED: Check if there's a new broadcast or if it was cleared (for restart)
//   Future<void> _checkForNewBroadcast() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_latest_broadcast',
//         ),
//         body: {'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Check if there's a broadcast and it's new
//         if (data['status'] == true) {
//           final broadcast = data['broadcast'];
//           final broadcastId =
//               broadcast?['id']?.toString(); // Handle null broadcast
//           final videoUrl = broadcast?['youtube_url'] ?? broadcast?['url'] ?? '';

//           if (broadcast == null || videoUrl.isEmpty) {
//             // NEW: If no broadcast or empty URL (restart signal), close video if playing
//             if (_isVideoPlaying && mounted) {
//               _closeVideo();
//               _lastBroadcastId = null;
//             }
//             return;
//           }

//           // If this is a new broadcast, play it immediately
//           if (broadcastId != null &&
//               broadcastId != _lastBroadcastId &&
//               videoUrl.isNotEmpty) {
//             _lastBroadcastId = broadcastId;

//             if (mounted) {
//               setState(() {
//                 _videoUrl = videoUrl;
//                 _isVideoPlaying = true;
//               });
//               _showVideoDialog(videoUrl);
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error checking for broadcast: $e");
//     }
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   Future<void> _fetchNewData() async {
//     setState(() => isLoadingOrgInfo = true);
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_fetch_data_record',
//         ),
//         body: {'userid': widget.userid, 'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           setState(() {
//             orgInfo = data['organization_info'] ?? orgInfo;
//             rssItems = data['rss_items'] ?? rssItems;
//             _teams = data['teams'] ?? _teams;
//             // Update other data if needed, e.g., badapatradata if used in table
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching new data: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//       onRestart: _restartApp,
//     );
//   }

//   // UPDATED: Close video and refresh data on restart
//   void _restartApp() {
//     _closeVideo();
//     _fetchNewData();
//   }

//   void _closeVideo() {
//     if (_isVideoPlaying && mounted) {
//       Navigator.pop(context); // Close the dialog if open
//       setState(() {
//         _videoUrl = null;
//         _isVideoPlaying = false;
//       });
//     }
//   }

//   void _showVideoDialog(String url) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.zero,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.black87,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       constraints: BoxConstraints(
//                         maxHeight: MediaQuery.of(context).size.height * 0.7,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Header
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.warning_amber_rounded,
//                                   color: Colors.white,
//                                   size: 32,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'आपतकालीन प्रसारण',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         'EMERGENCY BROADCAST',
//                                         style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Video
//                           Expanded(
//                             child: Container(
//                               color: Colors.black,
//                               child:
//                                   _isYouTubeUrl(url)
//                                       ? YouTubeVideoWidget(url: url)
//                                       : VideoPlayerWidget(url: url),
//                             ),
//                           ),
//                           // Footer
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[900],
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Emergency Alert',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Received: ${DateTime.now().toString().substring(0, 19)}',
//                                       style: const TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     setState(() {
//                                       _videoUrl = null;
//                                       _isVideoPlaying = false;
//                                     });
//                                   },
//                                   icon: const Icon(Icons.close),
//                                   label: const Text('बन्द गर्नुहोस्'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 24,
//                                       vertical: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   bool _isYouTubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     _broadcastCheckTimer?.cancel(); // Cancel polling timer
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 HeaderSection(orgInfo: orgInfo),
//                 const TopNewsBar(),
//                 const SizedBox(height: 8),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: CustomSearchBar(
//                             controller: _searchController,
//                             focusNode: _searchFocusNode,
//                             onSearch: _performSearch,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.5,
//                           child: WaraBadapatraTable(
//                             key: ValueKey(_searchCode),
//                             searchCode: _searchCode,
//                             onCodeTap:
//                                 (service) =>
//                                     setState(() => _selectedService = service),
//                             userid: widget.userid,
//                             orgid: widget.orgid,
//                             orgCode: widget.orgCode,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         if (_teams.isNotEmpty) // UPDATED: Use _teams
//                           TeamPage(scrollable: false, teams: _teams),
//                         const SizedBox(height: 20),
//                         const SidebarWidget(),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: 35,
//                           width: double.infinity,
//                           child: BottomNewsBar(
//                             newsItems: rssItems,
//                             rssType: widget.loginData['rss_type'] ?? 'News',
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // VIDEO WIDGETS
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize()
//           .then((_) {
//             setState(() => _isInitialized = true);
//             _controller.play();
//             _controller.setLooping(false);
//           })
//           .catchError((e) => print("Video error: $e"));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized)
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     return Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }

// class YouTubeVideoWidget extends StatefulWidget {
//   final String url;
//   const YouTubeVideoWidget({super.key, required this.url});
//   @override
//   State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
// }

// class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
//   late YoutubePlayerController _controller;
//   String? _videoId;

//   @override
//   void initState() {
//     super.initState();
//     _videoId = YoutubePlayer.convertUrlToId(widget.url);
//     if (_videoId != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: _videoId!,
//         flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//       );
//     } else {
//       print("❌ Invalid YouTube URL: ${widget.url}");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoId == null)
//       return const Center(
//         child: Text(
//           'Invalid YouTube URL',
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }
// }

//DOING LAYOUT:

// final_homepage.dart - Play video immediately when admin sets URL and close video immediately when admin clicks restart
// final_homepage.dart - Play video immediately when admin sets URL and close video immediately when admin clicks restart
// final_homepage.dart - Play video immediately when admin sets URL and close video immediately when admin clicks restart

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   final ScrollController _scrollController =
//       ScrollController(); // NEW: For scroll detection

//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   List<dynamic> _teams = []; // NEW: Mutable teams list in state
//   bool isLoadingOrgInfo = true;
//   bool _showBottomBar = false; // NEW: Control bottom bar visibility

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   // Add polling timer
//   Timer? _broadcastCheckTimer;
//   String? _lastBroadcastId;

//   @override
//   void initState() {
//     super.initState();
//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     _teams = List.from(widget.teams); // NEW: Initialize mutable teams
//     fetchOrganizationInfo();
//     _initializePusher();

//     // Start polling for broadcasts every 5 seconds
//     _startBroadcastPolling();

//     // NEW: Listen for scroll to show bottom bar
//     _scrollController.addListener(_scrollListener);
//   }

//   // NEW: Scroll listener to show bottom bar after scrolling
//   void _scrollListener() {
//     if (_scrollController.offset > 100 && !_showBottomBar) {
//       // Adjust threshold as needed
//       setState(() {
//         _showBottomBar = true;
//       });
//     }
//   }

//   // NEW: Poll backend for latest broadcast
//   void _startBroadcastPolling() {
//     _broadcastCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkForNewBroadcast();
//     });
//   }

//   // UPDATED: Check if there's a new broadcast or if it was cleared (for restart)
//   Future<void> _checkForNewBroadcast() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_latest_broadcast',
//         ),
//         body: {'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Check if there's a broadcast and it's new
//         if (data['status'] == true) {
//           final broadcast = data['broadcast'];
//           final broadcastId =
//               broadcast?['id']?.toString(); // Handle null broadcast
//           final videoUrl = broadcast?['youtube_url'] ?? broadcast?['url'] ?? '';

//           if (broadcast == null || videoUrl.isEmpty) {
//             // NEW: If no broadcast or empty URL (restart signal), close video if playing
//             if (_isVideoPlaying && mounted) {
//               _closeVideo();
//               _lastBroadcastId = null;
//             }
//             return;
//           }

//           // If this is a new broadcast, play it immediately
//           if (broadcastId != null &&
//               broadcastId != _lastBroadcastId &&
//               videoUrl.isNotEmpty) {
//             _lastBroadcastId = broadcastId;

//             if (mounted) {
//               setState(() {
//                 _videoUrl = videoUrl;
//                 _isVideoPlaying = true;
//               });
//               _showVideoDialog(videoUrl);
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error checking for broadcast: $e");
//     }
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   Future<void> _fetchNewData() async {
//     setState(() => isLoadingOrgInfo = true);
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_fetch_data_record',
//         ),
//         body: {'userid': widget.userid, 'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           setState(() {
//             orgInfo = data['organization_info'] ?? orgInfo;
//             rssItems = data['rss_items'] ?? rssItems;
//             _teams = data['teams'] ?? _teams;
//             // Update other data if needed, e.g., badapatradata if used in table
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching new data: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//       onRestart: _restartApp,
//     );
//   }

//   // UPDATED: Close video and refresh data on restart
//   void _restartApp() {
//     _closeVideo();
//     _fetchNewData();
//   }

//   void _closeVideo() {
//     if (_isVideoPlaying && mounted) {
//       Navigator.pop(context); // Close the dialog if open
//       setState(() {
//         _videoUrl = null;
//         _isVideoPlaying = false;
//       });
//     }
//   }

//   void _showVideoDialog(String url) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.zero,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.black87,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       constraints: BoxConstraints(
//                         maxHeight: MediaQuery.of(context).size.height * 0.7,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Header
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.warning_amber_rounded,
//                                   color: Colors.white,
//                                   size: 32,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'आपतकालीन प्रसारण',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         'EMERGENCY BROADCAST',
//                                         style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Video
//                           Expanded(
//                             child: Container(
//                               color: Colors.black,
//                               child:
//                                   _isYouTubeUrl(url)
//                                       ? YouTubeVideoWidget(url: url)
//                                       : VideoPlayerWidget(url: url),
//                             ),
//                           ),
//                           // Footer
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[900],
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Emergency Alert',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Received: ${DateTime.now().toString().substring(0, 19)}',
//                                       style: const TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     setState(() {
//                                       _videoUrl = null;
//                                       _isVideoPlaying = false;
//                                     });
//                                   },
//                                   icon: const Icon(Icons.close),
//                                   label: const Text('बन्द गर्नुहोस्'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 24,
//                                       vertical: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   bool _isYouTubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     _broadcastCheckTimer?.cancel(); // Cancel polling timer
//     _scrollController.dispose(); // NEW: Dispose scroll controller
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 HeaderSection(orgInfo: orgInfo),
//                 const TopNewsBar(),
//                 const SizedBox(height: 8),
//                 Expanded(child: _buildMainContent()),
//               ],
//             ),
//             if (_showBottomBar) // NEW: Show bottom bar only when scrolled
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 35,
//                       width: double.infinity,
//                       child: BottomNewsBar(
//                         newsItems: rssItems,
//                         rssType: widget.loginData['rss_type'] ?? 'News',
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // UPDATED: Main content with scroll controller
//   Widget _buildMainContent() {
//     final orientation = MediaQuery.of(context).orientation;

//     if (orientation == Orientation.landscape) {
//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4, // 80% for table and search
//             child: SingleChildScrollView(
//               controller: _scrollController, // NEW: Add controller
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: CustomSearchBar(
//                       controller: _searchController,
//                       focusNode: _searchFocusNode,
//                       onSearch: _performSearch,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     child: WaraBadapatraTable(
//                       key: ValueKey(_searchCode),
//                       searchCode: _searchCode,
//                       onCodeTap:
//                           (service) =>
//                               setState(() => _selectedService = service),
//                       userid: widget.userid,
//                       orgid: widget.orgid,
//                       orgCode: widget.orgCode,
//                     ),
//                   ),
//                   const SizedBox(height: 80), // Extra space for scrolling
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1, // 20% for team and sidebar (QR code)
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   if (_teams.isNotEmpty)
//                     TeamPage(scrollable: false, teams: _teams),
//                   const SizedBox(height: 20),
//                   const SidebarWidget(),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     } else {
//       // Portrait mode (original layout)
//       return SingleChildScrollView(
//         controller: _scrollController, // NEW: Add controller
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: CustomSearchBar(
//                 controller: _searchController,
//                 focusNode: _searchFocusNode,
//                 onSearch: _performSearch,
//               ),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.5,
//               child: WaraBadapatraTable(
//                 key: ValueKey(_searchCode),
//                 searchCode: _searchCode,
//                 onCodeTap:
//                     (service) => setState(() => _selectedService = service),
//                 userid: widget.userid,
//                 orgid: widget.orgid,
//                 orgCode: widget.orgCode,
//               ),
//             ),
//             const SizedBox(height: 16),
//             if (_teams.isNotEmpty) TeamPage(scrollable: false, teams: _teams),
//             const SizedBox(height: 20),
//             const SidebarWidget(),
//             const SizedBox(height: 20),
//             const SizedBox(
//               height: 80,
//             ), // NEW: Extra padding to ensure scrollable space for bottom bar trigger
//           ],
//         ),
//       );
//     }
//   }
// }

// // VIDEO WIDGETS
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize()
//           .then((_) {
//             setState(() => _isInitialized = true);
//             _controller.play();
//             _controller.setLooping(false);
//           })
//           .catchError((e) => print("Video error: $e"));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized)
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     return Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }

// class YouTubeVideoWidget extends StatefulWidget {
//   final String url;
//   const YouTubeVideoWidget({super.key, required this.url});
//   @override
//   State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
// }

// class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
//   late YoutubePlayerController _controller;
//   String? _videoId;

//   @override
//   void initState() {
//     super.initState();
//     _videoId = YoutubePlayer.convertUrlToId(widget.url);
//     if (_videoId != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: _videoId!,
//         flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//       );
//     } else {
//       print("❌ Invalid YouTube URL: ${widget.url}");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoId == null)
//       return const Center(
//         child: Text(
//           'Invalid YouTube URL',
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }
// }

//qr

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;
//   final String? token; // ✅ NEW: Added token parameter

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//     this.token, // ✅ NEW: Added token parameter
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   final ScrollController _scrollController =
//       ScrollController(); // NEW: For scroll detection

//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   List<dynamic> _teams = []; // NEW: Mutable teams list in state
//   bool isLoadingOrgInfo = true;
//   bool _showBottomBar = false; // NEW: Control bottom bar visibility

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   // Add polling timer
//   Timer? _broadcastCheckTimer;
//   String? _lastBroadcastId;

//   @override
//   void initState() {
//     super.initState();

//     // ✅ Debug: Check if token exists
//     print("🔑 Token from widget: ${widget.token?.substring(0, 20)}...");

//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     _teams = List.from(widget.teams); // NEW: Initialize mutable teams
//     fetchOrganizationInfo();
//     _initializePusher();

//     // Start polling for broadcasts every 5 seconds
//     _startBroadcastPolling();

//     // NEW: Listen for scroll to show bottom bar
//     _scrollController.addListener(_scrollListener);
//   }

//   // NEW: Scroll listener to show bottom bar after scrolling
//   void _scrollListener() {
//     if (_scrollController.offset > 100 && !_showBottomBar) {
//       // Adjust threshold as needed
//       setState(() {
//         _showBottomBar = true;
//       });
//     }
//   }

//   // NEW: Poll backend for latest broadcast
//   void _startBroadcastPolling() {
//     _broadcastCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkForNewBroadcast();
//     });
//   }

//   // UPDATED: Check if there's a new broadcast or if it was cleared (for restart)
//   Future<void> _checkForNewBroadcast() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_latest_broadcast',
//         ),
//         body: {'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Check if there's a broadcast and it's new
//         if (data['status'] == true) {
//           final broadcast = data['broadcast'];
//           final broadcastId =
//               broadcast?['id']?.toString(); // Handle null broadcast
//           final videoUrl = broadcast?['youtube_url'] ?? broadcast?['url'] ?? '';

//           if (broadcast == null || videoUrl.isEmpty) {
//             // NEW: If no broadcast or empty URL (restart signal), close video if playing
//             if (_isVideoPlaying && mounted) {
//               _closeVideo();
//               _lastBroadcastId = null;
//             }
//             return;
//           }

//           // If this is a new broadcast, play it immediately
//           if (broadcastId != null &&
//               broadcastId != _lastBroadcastId &&
//               videoUrl.isNotEmpty) {
//             _lastBroadcastId = broadcastId;

//             if (mounted) {
//               setState(() {
//                 _videoUrl = videoUrl;
//                 _isVideoPlaying = true;
//               });
//               _showVideoDialog(videoUrl);
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error checking for broadcast: $e");
//     }
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   Future<void> _fetchNewData() async {
//     setState(() => isLoadingOrgInfo = true);
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_fetch_data_record',
//         ),
//         body: {'userid': widget.userid, 'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           setState(() {
//             orgInfo = data['organization_info'] ?? orgInfo;
//             rssItems = data['rss_items'] ?? rssItems;
//             _teams = data['teams'] ?? _teams;
//             // Update other data if needed, e.g., badapatradata if used in table
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching new data: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//       onRestart: _restartApp,
//     );
//   }

//   // UPDATED: Close video and refresh data on restart
//   void _restartApp() {
//     _closeVideo();
//     _fetchNewData();
//   }

//   void _closeVideo() {
//     if (_isVideoPlaying && mounted) {
//       Navigator.pop(context); // Close the dialog if open
//       setState(() {
//         _videoUrl = null;
//         _isVideoPlaying = false;
//       });
//     }
//   }

//   void _showVideoDialog(String url) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.zero,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.black87,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       constraints: BoxConstraints(
//                         maxHeight: MediaQuery.of(context).size.height * 0.7,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Header
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.warning_amber_rounded,
//                                   color: Colors.white,
//                                   size: 32,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'आपतकालीन प्रसारण',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         'EMERGENCY BROADCAST',
//                                         style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Video
//                           Expanded(
//                             child: Container(
//                               color: Colors.black,
//                               child:
//                                   _isYouTubeUrl(url)
//                                       ? YouTubeVideoWidget(url: url)
//                                       : VideoPlayerWidget(url: url),
//                             ),
//                           ),
//                           // Footer
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[900],
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Emergency Alert',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Received: ${DateTime.now().toString().substring(0, 19)}',
//                                       style: const TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     setState(() {
//                                       _videoUrl = null;
//                                       _isVideoPlaying = false;
//                                     });
//                                   },
//                                   icon: const Icon(Icons.close),
//                                   label: const Text('बन्द गर्नुहोस्'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 24,
//                                       vertical: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   bool _isYouTubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     _broadcastCheckTimer?.cancel(); // Cancel polling timer
//     _scrollController.dispose(); // NEW: Dispose scroll controller
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 HeaderSection(orgInfo: orgInfo),
//                 const TopNewsBar(),
//                 const SizedBox(height: 8),
//                 Expanded(child: _buildMainContent()),
//               ],
//             ),
//             if (_showBottomBar) // NEW: Show bottom bar only when scrolled
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 35,
//                       width: double.infinity,
//                       child: BottomNewsBar(
//                         newsItems: rssItems,
//                         rssType: widget.loginData['rss_type'] ?? 'News',
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // UPDATED: Main content with scroll controller
//   Widget _buildMainContent() {
//     final orientation = MediaQuery.of(context).orientation;

//     if (orientation == Orientation.landscape) {
//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4, // 80% for table and search
//             child: SingleChildScrollView(
//               controller: _scrollController, // NEW: Add controller
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: CustomSearchBar(
//                       controller: _searchController,
//                       focusNode: _searchFocusNode,
//                       onSearch: _performSearch,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     child: WaraBadapatraTable(
//                       key: ValueKey(_searchCode),
//                       searchCode: _searchCode,
//                       onCodeTap:
//                           (service) =>
//                               setState(() => _selectedService = service),
//                       userid: widget.userid,
//                       orgid: widget.orgid,
//                       orgCode: widget.orgCode,
//                     ),
//                   ),
//                   const SizedBox(height: 80), // Extra space for scrolling
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1, // 20% for team and sidebar (QR code)
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   if (_teams.isNotEmpty)
//                     TeamPage(scrollable: false, teams: _teams),
//                   const SizedBox(height: 20),
//                   SidebarWidget(
//                     qrUrl:
//                         widget
//                             .loginData['qr_url'], // ✅ Pass the QR URL directly
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     } else {
//       // Portrait mode (original layout)
//       return SingleChildScrollView(
//         controller: _scrollController, // NEW: Add controller
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: CustomSearchBar(
//                 controller: _searchController,
//                 focusNode: _searchFocusNode,
//                 onSearch: _performSearch,
//               ),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.5,
//               child: WaraBadapatraTable(
//                 key: ValueKey(_searchCode),
//                 searchCode: _searchCode,
//                 onCodeTap:
//                     (service) => setState(() => _selectedService = service),
//                 userid: widget.userid,
//                 orgid: widget.orgid,
//                 orgCode: widget.orgCode,
//               ),
//             ),
//             const SizedBox(height: 16),
//             if (_teams.isNotEmpty) TeamPage(scrollable: false, teams: _teams),
//             const SizedBox(height: 20),
//             SidebarWidget(
//               qrUrl: widget.loginData['qr_url'], // ✅ Pass the QR URL directly
//             ),
//             const SizedBox(height: 20),
//             const SizedBox(
//               height: 80,
//             ), // NEW: Extra padding to ensure scrollable space for bottom bar trigger
//           ],
//         ),
//       );
//     }
//   }
// }

// // VIDEO WIDGETS
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize()
//           .then((_) {
//             setState(() => _isInitialized = true);
//             _controller.play();
//             _controller.setLooping(false);
//           })
//           .catchError((e) => print("Video error: $e"));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized)
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     return Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }

// class YouTubeVideoWidget extends StatefulWidget {
//   final String url;
//   const YouTubeVideoWidget({super.key, required this.url});
//   @override
//   State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
// }

// class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
//   late YoutubePlayerController _controller;
//   String? _videoId;

//   @override
//   void initState() {
//     super.initState();
//     _videoId = YoutubePlayer.convertUrlToId(widget.url);
//     if (_videoId != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: _videoId!,
//         flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//       );
//     } else {
//       print("❌ Invalid YouTube URL: ${widget.url}");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoId == null)
//       return const Center(
//         child: Text(
//           'Invalid YouTube URL',
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }
// }

//####################################################################################//

//FINAL DESIGN: SCROLLABLE BUT UNEVEN:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;
//   final String? token;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//     this.token,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   final ScrollController _scrollController = ScrollController();

//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   List<dynamic> _teams = [];
//   bool isLoadingOrgInfo = true;

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   Timer? _broadcastCheckTimer;
//   String? _lastBroadcastId;

//   @override
//   void initState() {
//     super.initState();
//     print("🔑 Token from widget: ${widget.token?.substring(0, 20)}...");

//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     _teams = List.from(widget.teams);
//     fetchOrganizationInfo();
//     _initializePusher();
//     _startBroadcastPolling();
//   }

//   void _startBroadcastPolling() {
//     _broadcastCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkForNewBroadcast();
//     });
//   }

//   Future<void> _checkForNewBroadcast() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_latest_broadcast',
//         ),
//         body: {'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true) {
//           final broadcast = data['broadcast'];
//           final broadcastId = broadcast?['id']?.toString();
//           final videoUrl = broadcast?['youtube_url'] ?? broadcast?['url'] ?? '';

//           if (broadcast == null || videoUrl.isEmpty) {
//             if (_isVideoPlaying && mounted) {
//               _closeVideo();
//               _lastBroadcastId = null;
//             }
//             return;
//           }

//           if (broadcastId != null &&
//               broadcastId != _lastBroadcastId &&
//               videoUrl.isNotEmpty) {
//             _lastBroadcastId = broadcastId;

//             if (mounted) {
//               setState(() {
//                 _videoUrl = videoUrl;
//                 _isVideoPlaying = true;
//               });
//               _showVideoDialog(videoUrl);
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error checking for broadcast: $e");
//     }
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sprta.digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   Future<void> _fetchNewData() async {
//     setState(() => isLoadingOrgInfo = true);
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_fetch_data_record',
//         ),
//         body: {'userid': widget.userid, 'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           setState(() {
//             orgInfo = data['organization_info'] ?? orgInfo;
//             rssItems = data['rss_items'] ?? rssItems;
//             _teams = data['teams'] ?? _teams;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching new data: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//       onRestart: _restartApp,
//     );
//   }

//   void _restartApp() {
//     _closeVideo();
//     _fetchNewData();
//   }

//   void _closeVideo() {
//     if (_isVideoPlaying && mounted) {
//       Navigator.pop(context);
//       setState(() {
//         _videoUrl = null;
//         _isVideoPlaying = false;
//       });
//     }
//   }

//   void _showVideoDialog(String url) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.zero,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.black87,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       constraints: BoxConstraints(
//                         maxHeight: MediaQuery.of(context).size.height * 0.7,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Header
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.warning_amber_rounded,
//                                   color: Colors.white,
//                                   size: 32,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'आपतकालीन प्रसारण',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         'EMERGENCY BROADCAST',
//                                         style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Video
//                           Expanded(
//                             child: Container(
//                               color: Colors.black,
//                               child:
//                                   _isYouTubeUrl(url)
//                                       ? YouTubeVideoWidget(url: url)
//                                       : VideoPlayerWidget(url: url),
//                             ),
//                           ),
//                           // Footer
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[900],
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Emergency Alert',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Received: ${DateTime.now().toString().substring(0, 19)}',
//                                       style: const TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     setState(() {
//                                       _videoUrl = null;
//                                       _isVideoPlaying = false;
//                                     });
//                                   },
//                                   icon: const Icon(Icons.close),
//                                   label: const Text('बन्द गर्नुहोस्'),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 24,
//                                       vertical: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   bool _isYouTubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     _broadcastCheckTimer?.cancel();
//     _scrollController.dispose();
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Column(
//           children: [
//             HeaderSection(orgInfo: orgInfo),
//             const TopNewsBar(),
//             const SizedBox(height: 8),
//             Expanded(child: _buildMainContent()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     final orientation = MediaQuery.of(context).orientation;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // LANDSCAPE MODE
//     if (orientation == Orientation.landscape) {
//       return SingleChildScrollView(
//         controller: _scrollController,
//         child: Column(
//           children: [
//             // Main content row (85% left + 15% right)
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // LEFT SIDE: 85% - Search + Table
//                 Expanded(
//                   flex: 85,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Search Bar
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: CustomSearchBar(
//                           controller: _searchController,
//                           focusNode: _searchFocusNode,
//                           onSearch: _performSearch,
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       // Table - Wrap in LayoutBuilder to get constraints
//                       LayoutBuilder(
//                         builder: (context, constraints) {
//                           return SizedBox(
//                             width: constraints.maxWidth,
//                             height: screenHeight * 0.7, // Fixed height
//                             child: WaraBadapatraTable(
//                               key: ValueKey(_searchCode),
//                               searchCode: _searchCode,
//                               onCodeTap:
//                                   (service) => setState(
//                                     () => _selectedService = service,
//                                   ),
//                               userid: widget.userid,
//                               orgid: widget.orgid,
//                               orgCode: widget.orgCode,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),

//                 // RIGHT SIDE: 15% - Teams + Sidebar
//                 Expanded(
//                   flex: 15,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (_teams.isNotEmpty)
//                           TeamPage(scrollable: false, teams: _teams),
//                         const SizedBox(height: 20),
//                         SidebarWidget(qrUrl: widget.loginData['qr_url']),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // Bottom News Bar - FULL WIDTH at the end
//             SizedBox(
//               height: 50,
//               width: double.infinity,
//               child: BottomNewsBar(
//                 newsItems: rssItems,
//                 rssType: widget.loginData['rss_type'] ?? 'News',
//               ),
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       );
//     }

//     // PORTRAIT MODE
//     return SingleChildScrollView(
//       controller: _scrollController,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: CustomSearchBar(
//               controller: _searchController,
//               focusNode: _searchFocusNode,
//               onSearch: _performSearch,
//             ),
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: screenHeight * 0.5,
//             child: WaraBadapatraTable(
//               key: ValueKey(_searchCode),
//               searchCode: _searchCode,
//               onCodeTap:
//                   (service) => setState(() => _selectedService = service),
//               userid: widget.userid,
//               orgid: widget.orgid,
//               orgCode: widget.orgCode,
//             ),
//           ),
//           const SizedBox(height: 20),
//           if (_teams.isNotEmpty) TeamPage(scrollable: false, teams: _teams),
//           const SizedBox(height: 20),
//           SidebarWidget(qrUrl: widget.loginData['qr_url']),
//           const SizedBox(height: 20),

//           // Bottom News Bar at the end
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: SizedBox(
//               height: 50,
//               child: BottomNewsBar(
//                 newsItems: rssItems,
//                 rssType: widget.loginData['rss_type'] ?? 'News',
//               ),
//             ),
//           ),
//           const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }

// // VIDEO WIDGETS
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//   const VideoPlayerWidget({super.key, required this.url});
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize()
//           .then((_) {
//             setState(() => _isInitialized = true);
//             _controller.play();
//             _controller.setLooping(false);
//           })
//           .catchError((e) => print("Video error: $e"));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized)
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     return Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }

// class YouTubeVideoWidget extends StatefulWidget {
//   final String url;
//   const YouTubeVideoWidget({super.key, required this.url});
//   @override
//   State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
// }

// class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
//   late YoutubePlayerController _controller;
//   String? _videoId;

//   @override
//   void initState() {
//     super.initState();
//     _videoId = YoutubePlayer.convertUrlToId(widget.url);
//     if (_videoId != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: _videoId!,
//         flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//       );
//     } else {
//       print("❌ Invalid YouTube URL: ${widget.url}");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoId == null)
//       return const Center(
//         child: Text(
//           'Invalid YouTube URL',
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }
// }

//##################################################################################//
//Design: Working:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'components/bottom_news_bar.dart';
// import 'components/header_section.dart';
// import 'components/sidebar_widget.dart';
// import 'components/top_news_bar.dart';
// import 'components/search_bar.dart' hide BottomNewsBar;
// import 'wara_badapatra_table.dart';
// import 'team_page.dart';
// import 'models/service.dart';
// import './services/pusher_service.dart';

// class FinalHomePage extends StatefulWidget {
//   final String userid;
//   final String orgid;
//   final String orgCode;
//   final List<dynamic> teams;
//   final Map<String, dynamic> loginData;
//   final String? token;

//   const FinalHomePage({
//     Key? key,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//     required this.teams,
//     required this.loginData,
//     this.token,
//   }) : super(key: key);

//   @override
//   State<FinalHomePage> createState() => _FinalHomePageState();
// }

// class _FinalHomePageState extends State<FinalHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FocusNode _keyboardFocusNode = FocusNode();
//   final ScrollController _scrollController = ScrollController();

//   String _searchCode = "";
//   Service? _selectedService;

//   Map<String, dynamic> orgInfo = {};
//   List<dynamic> rssItems = [];
//   List<dynamic> _teams = [];
//   bool isLoadingOrgInfo = true;

//   String? _videoUrl;
//   bool _isVideoPlaying = false;

//   Timer? _broadcastCheckTimer;
//   String? _lastBroadcastId;

//   @override
//   void initState() {
//     super.initState();
//     print("🔑 Token from widget: ${widget.token?.substring(0, 20)}...");

//     orgInfo = widget.loginData['organization_info'] ?? {};
//     rssItems = widget.loginData['rss_items'] ?? [];
//     _teams = List.from(widget.teams);
//     fetchOrganizationInfo();
//     _initializePusher();
//     _startBroadcastPolling();
//   }

//   void _startBroadcastPolling() {
//     _broadcastCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkForNewBroadcast();
//     });
//   }

//   Future<void> _checkForNewBroadcast() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_latest_broadcast',
//         ),
//         body: {'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true) {
//           final broadcast = data['broadcast'];
//           final broadcastId = broadcast?['id']?.toString();
//           final videoUrl = broadcast?['youtube_url'] ?? broadcast?['url'] ?? '';

//           if (broadcast == null || videoUrl.isEmpty) {
//             if (_isVideoPlaying && mounted) {
//               _closeVideo();
//               _lastBroadcastId = null;
//             }
//             return;
//           }

//           if (broadcastId != null &&
//               broadcastId != _lastBroadcastId &&
//               videoUrl.isNotEmpty) {
//             _lastBroadcastId = broadcastId;

//             if (mounted) {
//               setState(() {
//                 _videoUrl = videoUrl;
//                 _isVideoPlaying = true;
//               });
//               _showVideoDialog(videoUrl);
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error checking for broadcast: $e");
//     }
//   }

//   Future<void> fetchOrganizationInfo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://digitalbadapatra.com/api/v1/get_org_info'),
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == true || data['status'] == "success") {
//           setState(() {
//             rssItems = data['rss_items'] ?? rssItems;
//             isLoadingOrgInfo = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching org info: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   Future<void> _fetchNewData() async {
//     setState(() => isLoadingOrgInfo = true);
//     try {
//       final response = await http.post(
//         Uri.parse(
//           'https://sprta.digitalbadapatra.com/api/v1/get_fetch_data_record',
//         ),
//         body: {'userid': widget.userid, 'orgid': widget.orgid},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           setState(() {
//             orgInfo = data['organization_info'] ?? orgInfo;
//             rssItems = data['rss_items'] ?? rssItems;
//             _teams = data['teams'] ?? _teams;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching new data: $e");
//     } finally {
//       setState(() => isLoadingOrgInfo = false);
//     }
//   }

//   void _initializePusher() {
//     final pusherData = widget.loginData['pusher_array'] ?? {};
//     if (pusherData.isEmpty) {
//       print("⚠️ No Pusher data found");
//       return;
//     }

//     final pusherKey = pusherData['pusher_app_key'] ?? '';
//     final cluster = pusherData['cluster'] ?? '';
//     final orgId = widget.orgid;

//     if (pusherKey.isEmpty || cluster.isEmpty) return;

//     PusherService().connect(
//       orgId: orgId,
//       pusherKey: pusherKey,
//       cluster: cluster,
//       onVideo: (url) {
//         if (mounted) {
//           setState(() {
//             _videoUrl = url;
//             _isVideoPlaying = true;
//           });
//           _showVideoDialog(url);
//         }
//       },
//       onRestart: _restartApp,
//     );
//   }

//   void _restartApp() {
//     _closeVideo();
//     _fetchNewData();
//   }

//   void _closeVideo() {
//     if (_isVideoPlaying && mounted) {
//       Navigator.pop(context);
//       setState(() {
//         _videoUrl = null;
//         _isVideoPlaying = false;
//       });
//     }
//   }

//   void _showVideoDialog(String videoUrl) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder:
//           (context) => AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             content: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Container(
//                 color: Colors.black,
//                 child: Center(
//                   child: Text(
//                     "Video URL:\n$videoUrl",
//                     style: const TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   setState(() => _isVideoPlaying = false);
//                 },
//                 child: const Text("Close"),
//               ),
//             ],
//           ),
//     );
//   }

//   void _performSearch() =>
//       setState(() => _searchCode = _searchController.text.trim());

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _keyboardFocusNode.dispose();
//     _broadcastCheckTimer?.cancel();
//     _scrollController.dispose();
//     PusherService().disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoadingOrgInfo)
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: RawKeyboardListener(
//         focusNode: _keyboardFocusNode,
//         autofocus: true,
//         onKey: (event) {
//           if (event.logicalKey.keyLabel == '*') _selectedService = null;
//         },
//         child: Column(
//           children: [
//             HeaderSection(orgInfo: orgInfo),
//             const TopNewsBar(),
//             const SizedBox(height: 8),
//             Expanded(child: _buildMainContent()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     final orientation = MediaQuery.of(context).orientation;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // LANDSCAPE MODE
//     if (orientation == Orientation.landscape) {
//       return SingleChildScrollView(
//         controller: _scrollController,
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 85,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: CustomSearchBar(
//                           controller: _searchController,
//                           focusNode: _searchFocusNode,
//                           onSearch: _performSearch,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       LayoutBuilder(
//                         builder: (context, constraints) {
//                           return SizedBox(
//                             width: constraints.maxWidth,
//                             height: screenHeight * 0.7,
//                             child: WaraBadapatraTable(
//                               key: ValueKey(_searchCode),
//                               searchCode: _searchCode,
//                               onCodeTap:
//                                   (service) => setState(
//                                     () => _selectedService = service,
//                                   ),
//                               userid: widget.userid,
//                               orgid: widget.orgid,
//                               orgCode: widget.orgCode,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 15,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (_teams.isNotEmpty)
//                           TeamPage(scrollable: false, teams: _teams),
//                         const SizedBox(height: 20),
//                         SidebarWidget(qrUrl: widget.loginData['qr_url']),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               height: 50,
//               width: double.infinity,
//               child: BottomNewsBar(
//                 newsItems: rssItems,
//                 rssType: widget.loginData['rss_type'] ?? 'News',
//               ),
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       );
//     }

//     // PORTRAIT MODE
//     return SingleChildScrollView(
//       controller: _scrollController,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: CustomSearchBar(
//               controller: _searchController,
//               focusNode: _searchFocusNode,
//               onSearch: _performSearch,
//             ),
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: screenHeight * 0.5,
//             child: WaraBadapatraTable(
//               key: ValueKey(_searchCode),
//               searchCode: _searchCode,
//               onCodeTap:
//                   (service) => setState(() => _selectedService = service),
//               userid: widget.userid,
//               orgid: widget.orgid,
//               orgCode: widget.orgCode,
//             ),
//           ),
//           const SizedBox(height: 20),
//           if (_teams.isNotEmpty) TeamPage(scrollable: false, teams: _teams),
//           const SizedBox(height: 20),
//           SidebarWidget(qrUrl: widget.loginData['qr_url']),
//           const SizedBox(height: 20),
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: SizedBox(
//               height: 50,
//               child: BottomNewsBar(
//                 newsItems: rssItems,
//                 rssType: widget.loginData['rss_type'] ?? 'News',
//               ),
//             ),
//           ),
//           const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }

//##################################################################################//

//RAMPUR:
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components/bottom_news_bar.dart';
import 'components/header_section.dart';
import 'components/sidebar_widget.dart';
import 'components/top_news_bar.dart';
import 'components/search_bar.dart' hide BottomNewsBar;
import 'wara_badapatra_table.dart';
import 'team_page.dart';
import 'models/service.dart';

import 'services/pusher_service.dart';
import 'brodcast_page.dart';

class FinalHomePage extends StatefulWidget {
  final String userid;
  final String orgid;
  final String orgCode;
  final List<dynamic> teams;
  final Map<String, dynamic> loginData;
  final String? token;

  const FinalHomePage({
    Key? key,
    required this.userid,
    required this.orgid,
    required this.orgCode,
    required this.teams,
    required this.loginData,
    this.token,
  }) : super(key: key);

  @override
  State<FinalHomePage> createState() => _FinalHomePageState();
}

class _FinalHomePageState extends State<FinalHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final FocusNode _keyboardFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  String _searchCode = "";
  Service? _selectedService;

  Map<String, dynamic> orgInfo = {};
  List<dynamic> rssItems = [];
  List<dynamic> _teams = [];
  bool isLoadingOrgInfo = true;

  bool _isBroadcastOpen = false;

  @override
  void initState() {
    super.initState();

    orgInfo = widget.loginData['organization_info'] ?? {};
    rssItems = widget.loginData['rss_items'] ?? [];
    _teams = List.from(widget.teams);

    fetchOrganizationInfo();

    // Initialize Pusher with event callbacks
    PusherService.init(
      apiKey: 'YOUR_PUSHER_KEY', // Replace with your actual Pusher app key
      cluster: 'ap2',
      onEmergencyBroadcast: _handleBroadcastEvent,
      onRestartSignage: (_) => _restartApp(),
    );
  }

  Future<void> fetchOrganizationInfo() async {
    try {
      final response = await http.post(
        Uri.parse('https://digitalbadapatra.com/api/v1/get_org_info'),
        body: {
          'userid': widget.userid,
          'orgid': widget.orgid,
          'org_code': widget.orgCode,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true || data['status'] == "success") {
          setState(() {
            rssItems = data['rss_items'] ?? rssItems;
            isLoadingOrgInfo = false;
          });

          if (data['active_broadcast'] != null) {
            _handleBroadcastEvent(data['active_broadcast']);
          }
        }
      }
    } catch (e) {
      print("❌ Error fetching org info: $e");
    } finally {
      setState(() => isLoadingOrgInfo = false);
    }
  }

  Future<void> _fetchNewData() async {
    setState(() => isLoadingOrgInfo = true);
    try {
      final response = await http.post(
        Uri.parse('https://digitalbadapatra.com/api/v1/get_fetch_data_record'),
        body: {'userid': widget.userid, 'orgid': widget.orgid},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            orgInfo = data['organization_info'] ?? orgInfo;
            rssItems = data['rss_items'] ?? rssItems;
            _teams = data['teams'] ?? _teams;
          });

          if (data['active_broadcast'] != null) {
            _handleBroadcastEvent(data['active_broadcast']);
          }
        }
      }
    } catch (e) {
      print("❌ Error fetching new data: $e");
    } finally {
      setState(() => isLoadingOrgInfo = false);
    }
  }

  void _handleBroadcastEvent(dynamic data) {
    if (_isBroadcastOpen || !mounted) return;
    _isBroadcastOpen = true;

    try {
      Map<String, dynamic> parsed;
      if (data is String) {
        if (data.startsWith('{')) {
          parsed = Map<String, dynamic>.from(jsonDecode(data));
        } else {
          parsed = {"url": data, "type": "video", "duration": 60};
        }
      } else {
        parsed = Map<String, dynamic>.from(data);
      }

      final String type = parsed['type'] ?? 'video';
      final String url = parsed['url'] ?? '';
      final int duration =
          parsed['duration'] is int
              ? parsed['duration']
              : int.tryParse(parsed['duration'].toString()) ?? 60;

      if (url.isEmpty) {
        _isBroadcastOpen = false;
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder:
              (_) => BroadcastPage(
                type: type,
                url: url,
                duration: duration,
                orgId: widget.orgCode,
              ),
        ),
      ).then((_) => _isBroadcastOpen = false);
    } catch (e) {
      print("❌ Error handling broadcast event: $e");
      _isBroadcastOpen = false;
    }
  }

  void _restartApp() {
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
    _fetchNewData();
    print("🔄 App restarted via Pusher");
  }

  void _performSearch() =>
      setState(() => _searchCode = _searchController.text.trim());

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _keyboardFocusNode.dispose();
    _scrollController.dispose();
    PusherService.disconnect(); // Static call
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingOrgInfo) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: RawKeyboardListener(
        focusNode: _keyboardFocusNode,
        autofocus: true,
        onKey: (event) {
          if (event.logicalKey.keyLabel == '*') _selectedService = null;
        },
        child: Column(
          children: [
            HeaderSection(orgInfo: orgInfo),
            const TopNewsBar(),
            const SizedBox(height: 8),
            Expanded(child: _buildMainContent()),
          ],
        ),
      ),
    );
  }

  // _buildMainContent() remains unchanged
  Widget _buildMainContent() {
    final orientation = MediaQuery.of(context).orientation;
    final screenHeight = MediaQuery.of(context).size.height;

    if (orientation == Orientation.landscape) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 85,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomSearchBar(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onSearch: _performSearch,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: screenHeight * 0.7,
                            child: WaraBadapatraTable(
                              key: ValueKey(_searchCode),
                              searchCode: _searchCode,
                              onCodeTap:
                                  (service) => setState(
                                    () => _selectedService = service,
                                  ),
                              userid: widget.userid,
                              orgid: widget.orgid,
                              orgCode: widget.orgCode,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_teams.isNotEmpty)
                          TeamPage(scrollable: false, teams: _teams),
                        const SizedBox(height: 20),
                        SidebarWidget(qrUrl: widget.loginData['qr_url']),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: BottomNewsBar(
                newsItems: rssItems,
                rssType: widget.loginData['rss_type'] ?? 'News',
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onSearch: _performSearch,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: screenHeight * 0.5,
            child: WaraBadapatraTable(
              key: ValueKey(_searchCode),
              searchCode: _searchCode,
              onCodeTap:
                  (service) => setState(() => _selectedService = service),
              userid: widget.userid,
              orgid: widget.orgid,
              orgCode: widget.orgCode,
            ),
          ),
          const SizedBox(height: 20),
          if (_teams.isNotEmpty) TeamPage(scrollable: false, teams: _teams),
          const SizedBox(height: 20),
          SidebarWidget(qrUrl: widget.loginData['qr_url']),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SizedBox(
              height: 50,
              child: BottomNewsBar(
                newsItems: rssItems,
                rssType: widget.loginData['rss_type'] ?? 'News',
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
