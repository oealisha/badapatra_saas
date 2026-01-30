//working

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// typedef SearchCallback = void Function(String value);

// class CustomSearchBar extends StatefulWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final VoidCallback onSearch;
//   final SearchCallback? onChanged;

//   const CustomSearchBar({
//     super.key,
//     required this.controller,
//     required this.focusNode,
//     required this.onSearch,
//     this.onChanged,
//   });

//   @override
//   _CustomSearchBarState createState() => _CustomSearchBarState();
// }

// class _CustomSearchBarState extends State<CustomSearchBar> {
//   late final FocusNode _keyboardFocusNode;

//   @override
//   void initState() {
//     super.initState();
//     _keyboardFocusNode = FocusNode();

//     // Listen to all key presses globally
//     HardwareKeyboard.instance.addHandler(_handleKeyPress);
//   }

//   @override
//   void dispose() {
//     HardwareKeyboard.instance.removeHandler(_handleKeyPress);
//     _keyboardFocusNode.dispose();
//     super.dispose();
//   }

//   // Handle global key presses
//   bool _handleKeyPress(KeyEvent event) {
//     // Only respond to key down events
//     if (event is KeyDownEvent) {
//       // Detect '*' key
//       if (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
//           event.character == '*') {
//         // Focus the search bar
//         widget.focusNode.requestFocus();
//         return true; // consumed
//       }
//     }
//     return false; // not consumed
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     // 75% width in landscape, full width in portrait
//     final double barWidth = isLandscape ? screenWidth * 0.75 : screenWidth;

//     // Half-height version
//     const double containerHeight = 25; // compact height
//     const double verticalPadding = 1; // vertical padding inside TextField
//     const double fontSize = 10; // smaller font

//     return Container(
//       width: barWidth,
//       height: containerHeight,
//       margin: const EdgeInsets.only(top: 1), // reduced top margin
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: widget.controller,
//         focusNode: widget.focusNode,
//         keyboardType: TextInputType.text,
//         inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9*]'))],
//         onChanged: widget.onChanged,
//         onSubmitted: (_) => widget.onSearch(),
//         style: const TextStyle(fontSize: fontSize, height: 1.0),
//         decoration: InputDecoration(
//           hintText:
//               "सेवाहरु खोज्न को लागि (*) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//           hintStyle: const TextStyle(color: Colors.blue, fontSize: fontSize),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: verticalPadding,
//           ),
//           border: InputBorder.none,
//           isDense: true,
//           suffixIcon: IconButton(
//             icon: const Icon(Icons.search, size: 16, color: Colors.blue),
//             onPressed: widget.onSearch,
//           ),
//         ),
//       ),
//     );
//   }
// }

//#############################################################################//

//working

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// typedef SearchCallback = void Function(String value);
// typedef CodeTypedCallback = void Function(String code);

// class CustomSearchBar extends StatefulWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final VoidCallback onSearch;
//   final SearchCallback? onChanged;
//   final CodeTypedCallback? onCodeTyped; // triggers full-screen popup

//   const CustomSearchBar({
//     super.key,
//     required this.controller,
//     required this.focusNode,
//     required this.onSearch,
//     this.onChanged,
//     this.onCodeTyped,
//   });

//   @override
//   _CustomSearchBarState createState() => _CustomSearchBarState();
// }

// class _CustomSearchBarState extends State<CustomSearchBar> {
//   String _typedCode = '';
//   Timer? _typingTimer;

//   @override
//   void initState() {
//     super.initState();

//     // Listen to hardware keys
//     HardwareKeyboard.instance.addHandler(_handleKeyPress);
//   }

//   @override
//   void dispose() {
//     HardwareKeyboard.instance.removeHandler(_handleKeyPress);
//     _typingTimer?.cancel();
//     super.dispose();
//   }

//   /// Handles TV remote / hardware keyboard input
//   bool _handleKeyPress(KeyEvent event) {
//     if (event is KeyDownEvent) {
//       final keyChar = event.character;

//       // 1️⃣ '*' key focuses search bar
//       if (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
//           keyChar == '*') {
//         widget.focusNode.requestFocus();
//         return true; // consumed
//       }

//       // 2️⃣ Numeric keys for full-screen popup
//       if (keyChar != null && RegExp(r'^[0-9]+$').hasMatch(keyChar)) {
//         _typedCode += keyChar;

//         // Debounce typing
//         _typingTimer?.cancel();
//         _typingTimer = Timer(const Duration(milliseconds: 300), () {
//           if (_typedCode.isNotEmpty) {
//             widget.onCodeTyped?.call(_typedCode); // trigger popup
//           }
//           _typedCode = '';
//         });

//         return false; // ⚡ Allow TextField to also receive input
//       }
//     }
//     return false; // don't block other keys
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final barWidth = isLandscape ? screenWidth * 0.75 : screenWidth;

//     const containerHeight = 25.0;
//     const verticalPadding = 1.0;
//     const fontSize = 10.0;

//     return Container(
//       width: barWidth,
//       height: containerHeight,
//       margin: const EdgeInsets.only(top: 1),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: widget.controller,
//         focusNode: widget.focusNode,
//         keyboardType: TextInputType.number,
//         inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9*]'))],
//         onChanged: (value) {
//           widget.onChanged?.call(value);

//           // Trigger full-screen popup immediately for mobile input
//           if (value.isNotEmpty) {
//             widget.onCodeTyped?.call(value);
//           }
//         },
//         onSubmitted: (_) => widget.onSearch(),
//         style: const TextStyle(fontSize: fontSize, height: 1.0),
//         decoration: InputDecoration(
//           hintText:
//               "सेवाहरु खोज्न को लागि (*) थिच्नुहोस् र नंम्बर टाइप गर्नुहोस्",
//           hintStyle: const TextStyle(color: Colors.blue, fontSize: fontSize),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: verticalPadding,
//           ),
//           border: InputBorder.none,
//           isDense: true,
//           suffixIcon: IconButton(
//             icon: const Icon(Icons.search, size: 16, color: Colors.blue),
//             onPressed: widget.onSearch,
//           ),
//         ),
//       ),
//     );
//   }
// }

//###################################################################################//

//test
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:bada_patra_task/wara_badapatra_table.dart';
// import 'package:bada_patra_task/models/service.dart';

// typedef SearchCallback = void Function(String value);
// typedef CodeTypedCallback = void Function(String code);

// // Responsive Constants
// class Responsive {
//   static const double mobileMaxWidth = 600;
//   static const double tvMinWidth = 1200;

//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < mobileMaxWidth;

//   static bool isTV(BuildContext context) =>
//       MediaQuery.of(context).size.width >= tvMinWidth;

//   static double fontSize(BuildContext context, double mobile, double tv) {
//     final width = MediaQuery.of(context).size.width;
//     if (width >= tvMinWidth) return tv;
//     if (width < mobileMaxWidth) return mobile;
//     return mobile +
//         (tv - mobile) *
//             (width - mobileMaxWidth) /
//             (tvMinWidth - mobileMaxWidth);
//   }
// }

// // Colors
// final Color headerBg = const Color(0xFFE45C53);
// final Color rowBg = const Color(0xFFF9D7D7);
// final Color appBarBg = Colors.blue;
// final Color textHeader = Colors.white;
// final Color textRow = Colors.black87;

// class CustomSearchBar extends StatefulWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final VoidCallback onSearch;
//   final SearchCallback? onChanged;
//   final CodeTypedCallback? onCodeTyped;

//   const CustomSearchBar({
//     super.key,
//     required this.controller,
//     required this.focusNode,
//     required this.onSearch,
//     this.onChanged,
//     this.onCodeTyped,
//   });

//   @override
//   _CustomSearchBarState createState() => _CustomSearchBarState();
// }

// class _CustomSearchBarState extends State<CustomSearchBar> {
//   String _typedCode = '';
//   Timer? _typingTimer;

//   @override
//   void initState() {
//     super.initState();
//     HardwareKeyboard.instance.addHandler(_handleKeyPress);
//   }

//   @override
//   void dispose() {
//     HardwareKeyboard.instance.removeHandler(_handleKeyPress);
//     _typingTimer?.cancel();
//     super.dispose();
//   }

//   bool _handleKeyPress(KeyEvent event) {
//     if (event is KeyDownEvent) {
//       final keyChar = event.character;

//       // * → focus bar
//       if (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
//           keyChar == '*') {
//         widget.focusNode.requestFocus();
//         return true;
//       }

//       // Accept digits — show immediately + collect
//       if (keyChar != null && RegExp(r'^[0-9]$').hasMatch(keyChar)) {
//         _typedCode += keyChar;
//         widget.controller.text = _typedCode;
//         widget.controller.selection = TextSelection.fromPosition(
//           TextPosition(offset: _typedCode.length),
//         );

//         _typingTimer?.cancel();
//         _typingTimer = Timer(const Duration(milliseconds: 2000), () {
//           if (_typedCode.isNotEmpty) {
//             widget.onCodeTyped?.call(_typedCode);
//             _showFullScreenTable(context, _typedCode);
//             _typedCode = '';
//             widget.controller.clear();
//           }
//         });

//         return true;
//       }
//     }
//     return false;
//   }

//   void _showFullScreenTable(BuildContext context, String code) async {
//     final service = await _fetchServiceByCode(code);

//     final displayService =
//         service ??
//         Service(
//           code: code,
//           serviceTypeName: 'सम्पत्ति कर',
//           serviceRecDetail:
//               'निवेदन : जग्गाधनी प्रमाणपत्रको प्रतिलिपि । नक्साको प्रतिलिपि । भवन/जग्गा खरिद गरको भए मालपोतबाट राजिनामा पारित लिखतको प्रतिलिपि । मालपोत वा सम्पत्ति कर तिरेको रसिद । नागरिकता र नापी नक्साको प्रमाणित प्रतिलिपि ।',
//           fee: 'मुल्यांकनको आधारमा रु २५ देखि रु ५००० सम्म',
//           time: 'सोही दिन',
//           serviceProvider: 'वडा अध्यक्ष, वडा सचिव',
//           complainListen: 'प्रमुख प्रशासकीय अधिकृत',
//         );

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder:
//             (_) => Scaffold(
//               appBar: AppBar(
//                 title: Text(
//                   displayService.serviceTypeName,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: Responsive.fontSize(context, 16, 20),
//                   ),
//                 ),
//                 backgroundColor: appBarBg,
//                 iconTheme: const IconThemeData(color: Colors.white),
//                 bottom: const PreferredSize(
//                   preferredSize: Size.zero,
//                   child: SizedBox(),
//                 ),
//               ),
//               body: SafeArea(
//                 child: Container(
//                   color: rowBg,
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                         // Header
//                         Container(
//                           color: headerBg,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           child: Row(children: _buildHeaderRow(context)),
//                         ),
//                         // Data Row
//                         Container(
//                           color: rowBg,
//                           padding: const EdgeInsets.all(16),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: _buildDataRow(context, displayService),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         fullscreenDialog: true,
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(BuildContext context) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्ने अधिकारी',
//     ];
//     final flexes =
//         Responsive.isTV(context)
//             ? [1, 2, 3, 2, 2, 2, 2]
//             : [1, 2, 4, 2, 2, 2, 2];

//     return headers.asMap().entries.map((e) {
//       return Expanded(
//         flex: flexes[e.key],
//         child: Text(
//           e.value,
//           style: TextStyle(
//             color: textHeader,
//             fontWeight: FontWeight.bold,
//             fontSize: Responsive.fontSize(context, 13, 16),
//           ),
//           textAlign: TextAlign.center,
//         ),
//       );
//     }).toList();
//   }

//   List<Widget> _buildDataRow(BuildContext context, Service s) {
//     final values = [
//       s.code,
//       s.serviceTypeName,
//       s.serviceRecDetail,
//       s.fee,
//       s.time,
//       s.serviceProvider,
//       s.complainListen,
//     ];
//     final flexes =
//         Responsive.isTV(context)
//             ? [1, 2, 3, 2, 2, 2, 2]
//             : [1, 2, 4, 2, 2, 2, 2];

//     return values.asMap().entries.map((e) {
//       return Expanded(
//         flex: flexes[e.key],
//         child: Text(
//           e.value,
//           style: TextStyle(
//             fontSize: Responsive.fontSize(context, 13, 15),
//             color: textRow,
//           ),
//           softWrap: true,
//         ),
//       );
//     }).toList();
//   }

//   Future<Service?> _fetchServiceByCode(String code) async {
//     try {
//       final url = Uri.parse(
//         'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//       );
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List services = data['data'] ?? [];
//         final matched = services.cast<Map<String, dynamic>>().firstWhere(
//           (s) => s['code'].toString().trim() == code.trim(),
//           orElse: () => <String, dynamic>{},
//         );
//         if (matched.isNotEmpty) {
//           return Service.fromJson(matched);
//         }
//       }
//     } catch (e) {
//       debugPrint('Title fetch error: $e');
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final barWidth = isLandscape ? screenWidth * 0.75 : screenWidth;
//     final height = Responsive.isTV(context) ? 40.0 : 30.0;

//     return Container(
//       width: barWidth,
//       height: height,
//       margin: const EdgeInsets.only(top: 1),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(Responsive.isTV(context) ? 16 : 12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: Responsive.isTV(context) ? 4 : 3,
//             offset: Offset(0, Responsive.isTV(context) ? 2 : 1.5),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: widget.controller,
//         focusNode: widget.focusNode,
//         keyboardType: TextInputType.number,
//         inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9*]'))],
//         onChanged: widget.onChanged,
//         onSubmitted: (_) => widget.onSearch(),
//         style: TextStyle(fontSize: Responsive.fontSize(context, 12, 16)),
//         decoration: InputDecoration(
//           hintText: "(*) थिच्नुहोस् र नं. टाइप गर्नुहोस्",
//           hintStyle: TextStyle(
//             color: Colors.blue,
//             fontSize: Responsive.fontSize(context, 10, 14),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: Responsive.isTV(context) ? 16 : 10,
//             vertical: Responsive.isTV(context) ? 10 : 6,
//           ),
//           border: InputBorder.none,
//           isDense: true,
//           suffixIcon: IconButton(
//             icon: Icon(
//               Icons.search,
//               size: Responsive.isTV(context) ? 24 : 16,
//               color: Colors.blue,
//             ),
//             onPressed: widget.onSearch,
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// full screen test:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:bada_patra_task/wara_badapatra_table.dart';
// import 'package:bada_patra_task/models/service.dart';

// typedef SearchCallback = void Function(String value);
// typedef CodeTypedCallback = void Function(String code);

// // Responsive Constants
// class Responsive {
//   static const double mobileMaxWidth = 600;
//   static const double tvMinWidth = 1200;
//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < mobileMaxWidth;
//   static bool isTV(BuildContext context) =>
//       MediaQuery.of(context).size.width >= tvMinWidth;
//   static double fontSize(BuildContext context, double mobile, double tv) {
//     final width = MediaQuery.of(context).size.width;
//     if (width >= tvMinWidth) return tv;
//     if (width < mobileMaxWidth) return mobile;
//     return mobile +
//         (tv - mobile) *
//             (width - mobileMaxWidth) /
//             (tvMinWidth - mobileMaxWidth);
//   }
// }

// // Colors
// final Color headerBg = const Color(0xFFE45C53);
// final Color rowBg = const Color(0xFFF9D7D7);
// final Color appBarBg = Colors.blue;
// final Color textHeader = Colors.white;
// final Color textRow = Colors.black87;

// class CustomSearchBar extends StatefulWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final VoidCallback onSearch;
//   final SearchCallback? onChanged;
//   final CodeTypedCallback? onCodeTyped;

//   const CustomSearchBar({
//     super.key,
//     required this.controller,
//     required this.focusNode,
//     required this.onSearch,
//     this.onChanged,
//     this.onCodeTyped,
//   });

//   @override
//   _CustomSearchBarState createState() => _CustomSearchBarState();
// }

// class _CustomSearchBarState extends State<CustomSearchBar> {
//   String _typedCode = '';
//   Timer? _typingTimer;
//   Service? _lastSearchedService;

//   @override
//   void initState() {
//     super.initState();
//     HardwareKeyboard.instance.addHandler(_handleKeyPress);
//   }

//   @override
//   void dispose() {
//     HardwareKeyboard.instance.removeHandler(_handleKeyPress);
//     _typingTimer?.cancel();
//     super.dispose();
//   }

//   bool _handleKeyPress(KeyEvent event) {
//     if (event is KeyDownEvent) {
//       final keyChar = event.character;

//       if (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
//           keyChar == '*') {
//         widget.focusNode.requestFocus();
//         return true;
//       }

//       if (keyChar != null && RegExp(r'^[0-9]$').hasMatch(keyChar)) {
//         _typedCode += keyChar;
//         widget.controller.text = _typedCode;
//         widget.controller.selection = TextSelection.fromPosition(
//           TextPosition(offset: _typedCode.length),
//         );

//         _typingTimer?.cancel();
//         _typingTimer = Timer(const Duration(milliseconds: 1000), () async {
//           if (_typedCode.isNotEmpty) {
//             widget.onCodeTyped?.call(_typedCode);
//             final service = await _fetchServiceByCode(_typedCode);
//             if (service != null) {
//               _lastSearchedService = service;
//               if (mounted) _showFullScreenTable(context, service);
//             }
//             _typedCode = '';
//             widget.controller.clear();
//           }
//         });

//         return true;
//       }
//     }
//     return false;
//   }

//   void _showFullScreenTable(BuildContext context, Service service) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder:
//             (_) => OrientationBuilder(
//               builder: (context, orientation) {
//                 return Scaffold(
//                   appBar: AppBar(
//                     leading: IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () {
//                         // GO DIRECTLY TO MAIN TABLE — NO DOUBLE BACK
//                         Navigator.of(
//                           context,
//                         ).popUntil((route) => route.isFirst);
//                       },
//                     ),
//                     title: Text(
//                       service.serviceTypeName,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: Responsive.fontSize(context, 16, 20),
//                       ),
//                     ),
//                     backgroundColor: appBarBg,
//                     iconTheme: const IconThemeData(color: Colors.white),
//                   ),
//                   body: Container(
//                     color: rowBg,
//                     child: Column(
//                       children: [
//                         Container(
//                           color: headerBg,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           child: Row(children: _buildHeaderRow(context)),
//                         ),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             physics: const BouncingScrollPhysics(),
//                             child: Container(
//                               color: rowBg,
//                               padding: const EdgeInsets.all(16),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: _buildDataRow(context, service),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//         fullscreenDialog: true,
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(BuildContext context) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्ने अधिकारी',
//     ];
//     final flexes =
//         Responsive.isTV(context)
//             ? [1, 2, 3, 2, 2, 2, 2]
//             : [1, 2, 4, 2, 2, 2, 2];

//     return headers.asMap().entries.map((e) {
//       return Expanded(
//         flex: flexes[e.key],
//         child: Text(
//           e.value,
//           style: TextStyle(
//             color: textHeader,
//             fontWeight: FontWeight.bold,
//             fontSize: Responsive.fontSize(context, 13, 16),
//           ),
//           textAlign: TextAlign.center,
//         ),
//       );
//     }).toList();
//   }

//   List<Widget> _buildDataRow(BuildContext context, Service s) {
//     final values = [
//       s.code,
//       s.serviceTypeName,
//       s.serviceRecDetail,
//       s.fee,
//       s.time,
//       s.serviceProvider,
//       s.complainListen,
//     ];
//     final flexes =
//         Responsive.isTV(context)
//             ? [1, 2, 3, 2, 2, 2, 2]
//             : [1, 2, 4, 2, 2, 2, 2];

//     return values.asMap().entries.map((e) {
//       return Expanded(
//         flex: flexes[e.key],
//         child: Text(
//           e.value,
//           style: TextStyle(
//             fontSize: Responsive.fontSize(context, 13, 15),
//             color: textRow,
//           ),
//           softWrap: true,
//         ),
//       );
//     }).toList();
//   }

//   Future<Service?> _fetchServiceByCode(String code) async {
//     try {
//       final url = Uri.parse(
//         'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//       );
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List services = data['data'] ?? [];
//         final matched = services.cast<Map<String, dynamic>>().firstWhere(
//           (s) => s['code'].toString().trim() == code.trim(),
//           orElse: () => <String, dynamic>{},
//         );
//         if (matched.isNotEmpty) {
//           return Service.fromJson(matched);
//         }
//       }
//     } catch (e) {
//       debugPrint('Title fetch error: $e');
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final barWidth = isLandscape ? screenWidth * 0.75 : screenWidth;
//     final height = Responsive.isTV(context) ? 40.0 : 30.0;

//     return Container(
//       width: barWidth,
//       height: height,
//       margin: const EdgeInsets.only(top: 1),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(Responsive.isTV(context) ? 16 : 12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: Responsive.isTV(context) ? 4 : 3,
//             offset: Offset(0, Responsive.isTV(context) ? 2 : 1.5),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: widget.controller,
//         focusNode: widget.focusNode,
//         keyboardType: TextInputType.number,
//         inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9*]'))],
//         onChanged: widget.onChanged,
//         onSubmitted: (_) => widget.onSearch(),
//         style: TextStyle(fontSize: Responsive.fontSize(context, 12, 16)),
//         decoration: InputDecoration(
//           hintText: "(*) थिच्नुहोस् र नं. टाइप गर्नुहोस्",
//           hintStyle: TextStyle(
//             color: Colors.blue,
//             fontSize: Responsive.fontSize(context, 10, 14),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: Responsive.isTV(context) ? 16 : 10,
//             vertical: Responsive.isTV(context) ? 10 : 6,
//           ),
//           border: InputBorder.none,
//           isDense: true,
//           suffixIcon: IconButton(
//             icon: Icon(
//               Icons.search,
//               size: Responsive.isTV(context) ? 24 : 16,
//               color: Colors.blue,
//             ),
//             onPressed: widget.onSearch,
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:bada_patra_task/models/service.dart';

typedef SearchCallback = void Function(String value);
typedef CodeTypedCallback = void Function(String code);

// Responsive Constants
class Responsive {
  static const double mobileMaxWidth = 600;
  static const double tvMinWidth = 1200;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWidth;
  static bool isTV(BuildContext context) =>
      MediaQuery.of(context).size.width >= tvMinWidth;
  static double fontSize(BuildContext context, double mobile, double tv) {
    final width = MediaQuery.of(context).size.width;
    if (width >= tvMinWidth) return tv;
    if (width < mobileMaxWidth) return mobile;
    return mobile +
        (tv - mobile) *
            (width - mobileMaxWidth) /
            (tvMinWidth - mobileMaxWidth);
  }
}

// Colors
final Color headerBg = const Color(0xFFE45C53);
final Color rowBg = const Color(0xFFF9D7D7);
final Color appBarBg = Colors.blue;
final Color textHeader = Colors.white;
final Color textRow = Colors.black87;

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSearch;
  final SearchCallback? onChanged;
  final CodeTypedCallback? onCodeTyped;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSearch,
    this.onChanged,
    this.onCodeTyped,
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  String _typedCode = '';
  Timer? _typingTimer;
  Service? _lastSearchedService;

  // MATCH TABLE WIDTHS - Keep in sync with WaraBadapatraTable
  final List<double> columnWidthsPortrait = [80, 255, 355, 235, 215, 235, 255];
  final List<double> columnWidthsLandscape = [70, 235, 335, 215, 195, 215, 235];

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyPress);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyPress);
    _typingTimer?.cancel();
    super.dispose();
  }

  bool _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      final keyChar = event.character;

      if (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
          keyChar == '*') {
        widget.focusNode.requestFocus();
        return true;
      }

      if (keyChar != null && RegExp(r'^[0-9]$').hasMatch(keyChar)) {
        _typedCode += keyChar;
        widget.controller.text = _typedCode;
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _typedCode.length),
        );

        _typingTimer?.cancel();
        _typingTimer = Timer(const Duration(milliseconds: 1000), () async {
          if (_typedCode.isNotEmpty) {
            widget.onCodeTyped?.call(_typedCode);
            final service = await _fetchServiceByCode(_typedCode);
            if (service != null) {
              _lastSearchedService = service;
              if (mounted) _showFullScreenTable(context, service);
            }
            _typedCode = '';
            widget.controller.clear();
          }
        });

        return true;
      }
    }
    return false;
  }

  void _showFullScreenTable(BuildContext context, Service service) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => OrientationBuilder(
              builder: (context, orientation) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      },
                    ),
                    title: Text(
                      service.serviceTypeName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.fontSize(context, 16, 20),
                      ),
                    ),
                    backgroundColor: appBarBg,
                    iconTheme: const IconThemeData(color: Colors.white),
                  ),
                  body: Container(
                    color: rowBg,
                    child: Column(
                      children: [
                        Container(
                          color: headerBg,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(children: _buildHeaderRow(context)),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              color: rowBg,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildDataRow(context, service),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        fullscreenDialog: true,
      ),
    );
  }

  List<Widget> _buildHeaderRow(BuildContext context) {
    final headers = [
      'क्र.स',
      'सेवाको किसिम',
      'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
      'लाग्ने शुल्क',
      'लाग्ने समय',
      'सेवा दिने शाखा',
      'गुनासो सुन्ने अधिकारी',
    ];
    final flexes =
        Responsive.isTV(context)
            ? [1, 2, 3, 2, 2, 2, 2]
            : [1, 2, 4, 2, 2, 2, 2];

    return headers.asMap().entries.map((e) {
      return Expanded(
        flex: flexes[e.key],
        child: Text(
          e.value,
          style: TextStyle(
            color: textHeader,
            fontWeight: FontWeight.bold,
            fontSize: Responsive.fontSize(context, 13, 16),
          ),
          textAlign: TextAlign.center,
        ),
      );
    }).toList();
  }

  List<Widget> _buildDataRow(BuildContext context, Service s) {
    final values = [
      s.code,
      s.serviceTypeName,
      s.serviceRecDetail,
      s.fee,
      s.time,
      s.serviceProvider,
      s.complainListen,
    ];
    final flexes =
        Responsive.isTV(context)
            ? [1, 2, 3, 2, 2, 2, 2]
            : [1, 2, 4, 2, 2, 2, 2];

    return values.asMap().entries.map((e) {
      return Expanded(
        flex: flexes[e.key],
        child: Text(
          e.value,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 13, 15),
            color: textRow,
          ),
          softWrap: true,
        ),
      );
    }).toList();
  }

  Future<Service?> _fetchServiceByCode(String code) async {
    try {
      final url = Uri.parse(
        'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List services = data['data'] ?? [];
        final matched = services.cast<Map<String, dynamic>>().firstWhere(
          (s) => s['code'].toString().trim() == code.trim(),
          orElse: () => <String, dynamic>{},
        );
        if (matched.isNotEmpty) {
          return Service.fromJson(matched);
        }
      }
    } catch (e) {
      debugPrint('Title fetch error: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Calculate total table width to match
    final columnWidths =
        isPortrait ? columnWidthsPortrait : columnWidthsLandscape;
    final totalTableWidth = columnWidths.reduce((a, b) => a + b);

    final height = Responsive.isTV(context) ? 40.0 : 30.0;

    return Container(
      width: totalTableWidth, // MATCH TABLE WIDTH EXACTLY
      height: height,
      margin: const EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.isTV(context) ? 16 : 12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Responsive.isTV(context) ? 4 : 3,
            offset: Offset(0, Responsive.isTV(context) ? 2 : 1.5),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9*]'))],
        onChanged: widget.onChanged,
        onSubmitted: (_) => widget.onSearch(),
        style: TextStyle(fontSize: Responsive.fontSize(context, 12, 16)),
        decoration: InputDecoration(
          hintText: "(*) थिच्नुहोस् र नं. टाइप गर्नुहोस्",
          hintStyle: TextStyle(
            color: Colors.blue,
            fontSize: Responsive.fontSize(context, 10, 14),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Responsive.isTV(context) ? 16 : 10,
            vertical: Responsive.isTV(context) ? 10 : 6,
          ),
          border: InputBorder.none,
          isDense: true,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              size: Responsive.isTV(context) ? 24 : 16,
              color: Colors.blue,
            ),
            onPressed: widget.onSearch,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ),
    );
  }
}
