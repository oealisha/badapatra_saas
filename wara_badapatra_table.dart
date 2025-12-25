// //DONE
// //API DATA FETCH IN A HOME PAGE TABLE

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import './models/service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     checkAndFetchLatestData();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void checkAndFetchLatestData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastFetchStr = prefs.getString('last_fetch_time');
//     final now = DateTime.now();

//     DateTime? lastFetchTime =
//         lastFetchStr != null ? DateTime.tryParse(lastFetchStr) : null;

//     if (lastFetchTime == null || now.difference(lastFetchTime).inMinutes >= 2) {
//       print('More than 2 minutes passed, fetching new data...');
//       await fetchFetchDataRecord(); // Call get_fetch_data_record
//       await prefs.setString('last_fetch_time', now.toIso8601String());
//       print(' NEW DATA IS FETCHED');
//     } else {
//       print(' Data is fresh, no need to fetch.');
//       print(' DATA IS NOT FETCHED');
//     }

//     setState(() {
//       futureServices = loadData();
//     });
//   }

//   Future<void> fetchFetchDataRecord() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_fetch_data_record',
//     );
//     try {
//       await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );
//     } catch (e) {
//       print(' Failed to sync fetch data record: $e');
//     }
//   }

//   Future<List<Service>> loadData() async {
//     try {
//       final data = await fetchWaraBadapatra();
//       await saveDataLocally(data);
//       return data;
//     } catch (e) {
//       return loadDataFromLocal();
//     }
//   }

//   Future<void> saveDataLocally(List<Service> services) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = jsonEncode(services.map((e) => e.toJson()).toList());
//     await prefs.setString('offline_data', jsonString);
//   }

//   Future<List<Service>> loadDataFromLocal() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('offline_data');
//     if (jsonString == null) return [];
//     final List decoded = jsonDecode(jsonString);
//     return decoded.map((e) => Service.fromJson(e)).toList();
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found');
//       }
//     } else {
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }

//   DataCell buildWrappedCell(String text) {
//     return DataCell(
//       ConstrainedBox(
//         constraints: const BoxConstraints(minWidth: 150, maxWidth: 300),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 14),
//             softWrap: true,
//             overflow: TextOverflow.visible,
//             maxLines: null,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('वडा सेवा तालिका')),
//       body: FutureBuilder<List<Service>>(
//         future: futureServices,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('त्रुटि: ${snapshot.error}'));
//           }

//           final services = snapshot.data ?? [];

//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (_scrollController.hasClients) {
//               _scrollController.animateTo(
//                 0,
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//               );
//             }
//           });

//           return Scrollbar(
//             thumbVisibility: true,
//             controller: _scrollController,
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               scrollDirection: Axis.vertical,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   columnSpacing: 20,
//                   dataRowMinHeight: 80,
//                   dataRowMaxHeight: double.infinity,
//                   columns: const [
//                     DataColumn(label: Text('कोड')),
//                     DataColumn(label: Text('सेवा प्रकार')),
//                     DataColumn(label: Text('आवश्यक कागजात')),
//                     DataColumn(label: Text('शुल्क')),
//                     DataColumn(label: Text('समय')),
//                     DataColumn(label: Text('सेवा प्रदायक')),
//                     DataColumn(label: Text('गुनासो सुनुवाई')),
//                   ],
//                   rows:
//                       services.map((service) {
//                         return DataRow(
//                           cells: [
//                             buildWrappedCell(service.code),
//                             buildWrappedCell(service.serviceTypeName),
//                             buildWrappedCell(service.serviceRecDetail),
//                             buildWrappedCell(service.fee),

//                             buildWrappedCell(service.time),
//                             buildWrappedCell(service.serviceProvider),
//                             buildWrappedCell(service.complainListen),
//                           ],
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//TEST: Verticle Mode

//Import necessary Dart and Flutter packages
// import 'dart:async'; // For Timer and asynchronous operations
// import 'dart:convert'; // For encoding/decoding JSON
// import 'package:flutter/material.dart'; // Flutter UI components
// import 'package:http/http.dart' as http; // For HTTP requests
// import 'package:shared_preferences/shared_preferences.dart'; // For storing small data locally
// import './models/service.dart'; // Import the Service model

// // The main widget that displays the Wara Badapatra (Ward Services Table)
// class WaraBadapatraTable extends StatefulWidget {
//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices; // Future to hold services
//   final ScrollController _scrollController =
//       ScrollController(); // Controller for vertical scrolling
//   Timer? _autoScrollTimer; // Timer for automatic vertical scroll

//   @override
//   void initState() {
//     super.initState();
//     checkAndFetchLatestData(); // Load data and sync if needed
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose(); // Clean up scroll controller
//     _autoScrollTimer?.cancel(); // Cancel scroll timer
//     super.dispose();
//   }

//   // Checks if 2 minutes have passed since last fetch; if yes, sync and fetch data
//   void checkAndFetchLatestData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastFetchStr = prefs.getString('last_fetch_time');
//     final now = DateTime.now();

//     DateTime? lastFetchTime =
//         lastFetchStr != null ? DateTime.tryParse(lastFetchStr) : null;

//     // If more than 2 minutes passed, fetch and store time
//     if (lastFetchTime == null || now.difference(lastFetchTime).inMinutes >= 2) {
//       await fetchFetchDataRecord(); // Call sync API
//       await prefs.setString('last_fetch_time', now.toIso8601String());
//     }

//     // Load data (online or fallback to offline)
//     setState(() {
//       futureServices = loadData();
//     });
//   }

//   // Hit a record API endpoint (to register fetch request)
//   Future<void> fetchFetchDataRecord() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_fetch_data_record',
//     );
//     try {
//       await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );
//     } catch (e) {
//       print('Failed to sync fetch data record: $e');
//     }
//   }

//   // Load data either from network or fallback to local cache
//   Future<List<Service>> loadData() async {
//     try {
//       final data = await fetchWaraBadapatra(); // Try network
//       await saveDataLocally(data); // Cache it
//       return data;
//     } catch (e) {
//       return loadDataFromLocal(); // Fallback to local
//     }
//   }

//   // Save list of services locally as JSON
//   Future<void> saveDataLocally(List<Service> services) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = jsonEncode(services.map((e) => e.toJson()).toList());
//     await prefs.setString('offline_data', jsonString);
//   }

//   // Load locally stored service list
//   Future<List<Service>> loadDataFromLocal() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('offline_data');
//     if (jsonString == null) return [];
//     final List decoded = jsonDecode(jsonString);
//     return decoded.map((e) => Service.fromJson(e)).toList();
//   }

//   // Fetch data from the main API
//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList(); // Convert JSON list to Service list
//       } else {
//         throw Exception('No data found');
//       }
//     } else {
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }

//   // UI for the widget
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth =
//         MediaQuery.of(context).size.width; // Get screen width for layout

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('वडा सेवा तालिका'),
//       ), // App title in Nepali
//       body: FutureBuilder<List<Service>>(
//         future: futureServices,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             ); // Show loading
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('त्रुटि: ${snapshot.error}'),
//             ); // Show error if any
//           }

//           final services = snapshot.data ?? [];

//           // Start auto-scroll once
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _autoScrollTimer ??= Timer.periodic(
//               const Duration(milliseconds: 50), // Smooth auto-scroll
//               (_) {
//                 if (_scrollController.hasClients) {
//                   final max = _scrollController.position.maxScrollExtent;
//                   final current = _scrollController.offset;
//                   if (current >= max) {
//                     _scrollController.jumpTo(
//                       0,
//                     ); // Reset scroll when bottom is reached
//                   } else {
//                     _scrollController.jumpTo(
//                       current + 0.5,
//                     ); // Scroll down slowly
//                   }
//                 }
//               },
//             );
//           });

//           return Column(
//             children: [
//               // Sticky header with horizontal scroll support
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Container(
//                   width: screenWidth * 2, // Make header wide enough
//                   child: Row(children: _buildHeaderRow()), // Header row
//                 ),
//               ),
//               Expanded(
//                 child: Scrollbar(
//                   controller: _scrollController,
//                   thumbVisibility: true,
//                   child: SingleChildScrollView(
//                     controller: _scrollController,
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Column(
//                         children:
//                             services.asMap().entries.map((entry) {
//                               int index = entry.key;
//                               final service = entry.value;

//                               // Alternate row coloring
//                               final bool isEven = index % 2 == 0;
//                               final bgColor =
//                                   isEven
//                                       ? Color(0xFFF9D7D7)
//                                       : Color(0xFF006699);
//                               final textColor =
//                                   isEven ? Color(0xFF006699) : Colors.white;

//                               return Container(
//                                 color: bgColor,
//                                 width: screenWidth * 2,
//                                 child: Row(
//                                   children: [
//                                     _buildDataCell(
//                                       service.code,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       service.serviceTypeName,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       service.serviceRecDetail,
//                                       flex: 3,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       service.fee,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       service.time,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       service.serviceProvider,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       service.complainListen,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Builds the header row with column titles and custom widths/colors
//   List<Widget> _buildHeaderRow() {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्‍ने शुल्क',
//       'लाग्‍ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;

//       final bool isEven = index % 2 == 1;
//       final bgColor =
//           isEven
//               ? Color(0xFFC40000)
//               : Color(0xFFE45C53); // Alternate header color

//       // Adjust width per column content
//       final flex = index == 2 ? 3 : (index == 1 || index >= 5 ? 2 : 1);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     }).toList();
//   }

//   // Reusable method for creating a data cell with padding and color
//   Widget _buildDataCell(
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 16, color: textColor),
//           softWrap: true,
//         ),
//       ),
//     );
//   }
// }

//############################################################################//
//TESTING: LANDSCAPE MODE

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // for orientation and fullscreen
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import './models/service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;

//   @override
//   void initState() {
//     super.initState();

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);

//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//     // Initialize the future here
//     futureServices = checkAndFetchLatestData();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _autoScrollTimer?.cancel();

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);

//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

//     super.dispose();
//   }

//   Future<List<Service>> checkAndFetchLatestData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastFetchStr = prefs.getString('last_fetch_time');
//     final now = DateTime.now();

//     DateTime? lastFetchTime =
//         lastFetchStr != null ? DateTime.tryParse(lastFetchStr) : null;

//     if (lastFetchTime == null || now.difference(lastFetchTime).inMinutes >= 2) {
//       await fetchFetchDataRecord();
//       await prefs.setString('last_fetch_time', now.toIso8601String());
//     }

//     return await loadData();
//   }

//   Future<void> fetchFetchDataRecord() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_fetch_data_record',
//     );
//     try {
//       await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );
//     } catch (e) {
//       print('Failed to sync fetch data record: $e');
//     }
//   }

//   Future<List<Service>> loadData() async {
//     try {
//       final data = await fetchWaraBadapatra();
//       await saveDataLocally(data);
//       return data;
//     } catch (e) {
//       return loadDataFromLocal();
//     }
//   }

//   Future<void> saveDataLocally(List<Service> services) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = jsonEncode(services.map((e) => e.toJson()).toList());
//     await prefs.setString('offline_data', jsonString);
//   }

//   Future<List<Service>> loadDataFromLocal() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('offline_data');
//     if (jsonString == null) return [];
//     final List decoded = jsonDecode(jsonString);
//     return decoded.map((e) => Service.fromJson(e)).toList();
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found');
//       }
//     } else {
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     // Adjust container width based on orientation
//     final tableWidth = isLandscape ? screenWidth * 1.8 : screenWidth * 1.0;

//     return Scaffold(
//       appBar: AppBar(title: const Text('वडा सेवा तालिका')),
//       body: FutureBuilder<List<Service>>(
//         future: futureServices,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('त्रुटि: ${snapshot.error}'));
//           }

//           final services = snapshot.data ?? [];

//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _autoScrollTimer ??= Timer.periodic(
//               const Duration(milliseconds: 50),
//               (_) {
//                 if (_scrollController.hasClients) {
//                   final max = _scrollController.position.maxScrollExtent;
//                   final current = _scrollController.offset;
//                   if (current >= max) {
//                     _scrollController.jumpTo(0);
//                   } else {
//                     _scrollController.jumpTo(current + 0.5);
//                   }
//                 }
//               },
//             );
//           });

//           return Column(
//             children: [
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Container(
//                   width: tableWidth, // dynamic width here
//                   child: Row(children: _buildHeaderRow(context)),
//                 ),
//               ),
//               Expanded(
//                 child: Scrollbar(
//                   controller: _scrollController,
//                   thumbVisibility: true,
//                   child: SingleChildScrollView(
//                     controller: _scrollController,
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Column(
//                         children:
//                             services.asMap().entries.map((entry) {
//                               int index = entry.key;
//                               final service = entry.value;
//                               final isEven = index % 2 == 0;
//                               final bgColor =
//                                   isEven
//                                       ? Color(0xFFF9D7D7)
//                                       : Color(0xFF006699);
//                               final textColor =
//                                   isEven ? Color(0xFF006699) : Colors.white;

//                               return Container(
//                                 color: bgColor,
//                                 width: tableWidth, // dynamic width here
//                                 child: Row(
//                                   children: [
//                                     _buildDataCell(
//                                       context,
//                                       service.code,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.serviceTypeName,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.serviceRecDetail,
//                                       flex: 3,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.fee,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.time,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.serviceProvider,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.complainListen,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्‍ने शुल्क',
//       'लाग्‍ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;
//       final isEven = index % 2 == 1;
//       final bgColor = isEven ? Color(0xFFC40000) : Color(0xFFE45C53);
//       final flex = index == 2 ? 3 : (index == 1 || index >= 5 ? 2 : 1);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           padding: EdgeInsets.all(isLandscape ? 8 : 12),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: isLandscape ? 14 : 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     }).toList();
//   }

//   Widget _buildDataCell(
//     BuildContext context,
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: EdgeInsets.all(isLandscape ? 8 : 12),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: isLandscape ? 14 : 16, color: textColor),
//           softWrap: true,
//         ),
//       ),
//     );
//   }
// }

//########################################################################//
// ignore_for_file: use_build_context_synchronously
//landscape mode:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode; // 🔍 Added for filtering by code

//   const WaraBadapatraTable({super.key, this.searchCode = ""});

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   // Scroll controllers
//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();

//   Timer? _autoScrollTimer;

//   @override
//   void initState() {
//     super.initState();

//     // Force landscape for wide table view
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//     futureServices = checkAndFetchLatestData();

//     // ✅ Sync header <-> body scrolls
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });

//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();

//     // Restore orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

//     super.dispose();
//   }

//   /// ✅ Fetch data from API and cache in Hive
//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isDataChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isDataChanged) {
//         print('🔄 New data detected — updating Hive cache.');
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toString());
//       } else {
//         print('✅ No new data — using existing cache.');
//       }

//       return newData;
//     } catch (e) {
//       final localData = await HiveService.getServices();
//       if (localData.isEmpty) {
//         throw Exception(
//           'Failed to load data from API and no cached data available.',
//         );
//       }
//       print('⚠️ Using offline cached data.');
//       return localData;
//     }
//   }

//   /// API fetch
//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );

//       if (response.statusCode == 200 && response.body.isNotEmpty) {
//         final data = jsonDecode(response.body);
//         if (data['data'] != null && data['data'] is List) {
//           return (data['data'] as List)
//               .map((jsonItem) => Service.fromJson(jsonItem))
//               .toList();
//         } else {
//           throw Exception('No data found in response');
//         }
//       } else {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching API: $e');
//       throw e;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final tableWidth = isLandscape ? screenWidth * 1.8 : screenWidth * 1.0;

//     return Scaffold(
//       appBar: AppBar(title: const Text('वडा सेवा तालिका')),
//       body: FutureBuilder<List<Service>>(
//         future: futureServices,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('त्रुटि: ${snapshot.error}'));
//           }

//           final services = snapshot.data ?? [];

//           // 🔍 Filter by code (from search bar)
//           final filteredServices =
//               widget.searchCode.isEmpty
//                   ? services
//                   : services
//                       .where(
//                         (s) =>
//                             s.code.toString().trim() ==
//                             widget.searchCode.trim(),
//                       )
//                       .toList();

//           // 🟡 Show message if no matches
//           if (filteredServices.isEmpty && widget.searchCode.isNotEmpty) {
//             return const Center(child: Text('कुनै नतिजा भेटिएन।'));
//           }

//           // 🌀 Auto-scroll setup
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _autoScrollTimer ??= Timer.periodic(
//               const Duration(milliseconds: 50),
//               (_) {
//                 if (_verticalController.hasClients) {
//                   final max = _verticalController.position.maxScrollExtent;
//                   final current = _verticalController.offset;
//                   if (current >= max) {
//                     _verticalController.jumpTo(0);
//                   } else {
//                     _verticalController.jumpTo(current + 0.5);
//                   }
//                 }
//               },
//             );
//           });

//           return Column(
//             children: [
//               // Table Header
//               SingleChildScrollView(
//                 controller: _horizontalHeaderController,
//                 scrollDirection: Axis.horizontal,
//                 child: Container(
//                   width: tableWidth,
//                   child: Row(children: _buildHeaderRow(context)),
//                 ),
//               ),

//               // Table Body
//               Expanded(
//                 child: Scrollbar(
//                   controller: _verticalController,
//                   thumbVisibility: true,
//                   child: SingleChildScrollView(
//                     controller: _verticalController,
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       controller: _horizontalBodyController,
//                       scrollDirection: Axis.horizontal,
//                       child: Column(
//                         children:
//                             filteredServices.asMap().entries.map((entry) {
//                               int index = entry.key;
//                               final service = entry.value;
//                               final isEven = index % 2 == 0;
//                               final bgColor =
//                                   isEven
//                                       ? const Color(0xFFF9D7D7)
//                                       : const Color(0xFF006699);
//                               final textColor =
//                                   isEven
//                                       ? const Color(0xFF006699)
//                                       : Colors.white;

//                               return Container(
//                                 color: bgColor,
//                                 width: tableWidth,
//                                 child: Row(
//                                   children: [
//                                     _buildDataCell(
//                                       context,
//                                       service.code,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.serviceTypeName,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.serviceRecDetail,
//                                       flex: 3,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.fee,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.time,
//                                       flex: 1,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.serviceProvider,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                     _buildDataCell(
//                                       context,
//                                       service.complainListen,
//                                       flex: 2,
//                                       textColor: textColor,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   /// 🔹 Table Header
//   List<Widget> _buildHeaderRow(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्‍ने शुल्क',
//       'लाग्‍ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;
//       final isEven = index % 2 == 1;
//       final bgColor =
//           isEven ? const Color(0xFFC40000) : const Color(0xFFE45C53);
//       final flex = index == 2 ? 3 : (index == 1 || index >= 5 ? 2 : 1);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           padding: EdgeInsets.all(isLandscape ? 8 : 12),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: isLandscape ? 14 : 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     }).toList();
//   }

//   /// 🔹 Table Cell
//   Widget _buildDataCell(
//     BuildContext context,
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: EdgeInsets.all(isLandscape ? 8 : 12),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: isLandscape ? 14 : 16, color: textColor),
//           softWrap: true,
//         ),
//       ),
//     );
//   }
// }

//#################################################################################//

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({super.key, this.searchCode = "", this.onCodeTap});

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;

//   final int _visibleRows = 73;

//   @override
//   void initState() {
//     super.initState();
//     futureServices = checkAndFetchLatestData();

//     // Sync horizontal scroll
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });

//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   /// Fetch + Cache
//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isDataChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isDataChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toString());
//       }

//       return newData;
//     } catch (e) {
//       final localData = await HiveService.getServices();
//       if (localData.isEmpty)
//         throw Exception('Failed to load and no cache found.');
//       return localData;
//     }
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200 && response.body.isNotEmpty) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found.');
//       }
//     } else {
//       throw Exception('Failed: ${response.statusCode}');
//     }
//   }

//   /// Smooth auto-scroll
//   void _startAutoScroll() {
//     const double scrollSpeed = 20; // pixels per second
//     const Duration tick = Duration(milliseconds: 50);

//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;

//       final maxScroll = _verticalController.position.maxScrollExtent;
//       final current = _verticalController.offset;

//       final increment = scrollSpeed * tick.inMilliseconds / 1000;

//       if (current + increment >= maxScroll) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + increment);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tableWidth = screenWidth * 2.0;

//     return Container(
//       color: Colors.white,
//       child: FutureBuilder<List<Service>>(
//         future: futureServices,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('त्रुटि: ${snapshot.error}'));
//           }

//           final services = snapshot.data ?? [];
//           final filteredServices =
//               widget.searchCode.isEmpty
//                   ? services
//                   : services
//                       .where(
//                         (s) =>
//                             s.code.toString().trim() ==
//                             widget.searchCode.trim(),
//                       )
//                       .toList();

//           if (filteredServices.isEmpty && widget.searchCode.isNotEmpty) {
//             return const Center(child: Text('कुनै नतिजा भेटिएन।'));
//           }

//           final displayedServices =
//               filteredServices.length > _visibleRows
//                   ? filteredServices.sublist(0, _visibleRows)
//                   : filteredServices;

//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (_autoScrollTimer == null) _startAutoScroll();
//           });

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // STATIC header
//               SingleChildScrollView(
//                 controller: _horizontalHeaderController,
//                 scrollDirection: Axis.horizontal,
//                 child: SizedBox(
//                   width: tableWidth,
//                   child: Row(children: _buildHeaderRow(context)),
//                 ),
//               ),
//               const Divider(height: 1, color: Colors.black),

//               // Scrollable body
//               SizedBox(
//                 height: 1500, //TABLE HEIGHT ONLY
//                 child: SingleChildScrollView(
//                   controller: _verticalController,
//                   scrollDirection: Axis.vertical,
//                   child: SingleChildScrollView(
//                     controller: _horizontalBodyController,
//                     scrollDirection: Axis.horizontal,
//                     child: SizedBox(
//                       width: tableWidth,
//                       child: Column(
//                         children:
//                             displayedServices.asMap().entries.map((entry) {
//                               int index = entry.key;
//                               final service = entry.value;
//                               final isEven = index % 2 == 0;
//                               final bgColor =
//                                   isEven
//                                       ? const Color(0xFFF9D7D7)
//                                       : const Color(0xFF006699);
//                               final textColor =
//                                   isEven
//                                       ? const Color(0xFF006699)
//                                       : Colors.white;

//                               return InkWell(
//                                 onTap: () {
//                                   if (widget.onCodeTap != null)
//                                     widget.onCodeTap!(service);
//                                 },
//                                 child: Container(
//                                   color: bgColor,
//                                   child: Row(
//                                     children: [
//                                       _buildDataCell(
//                                         context,
//                                         service.code,
//                                         flex: 1,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.serviceTypeName,
//                                         flex: 2,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.serviceRecDetail,
//                                         flex: 3,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.fee,
//                                         flex: 1,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.time,
//                                         flex: 1,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.serviceProvider,
//                                         flex: 2,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.complainListen,
//                                         flex: 2,
//                                         textColor: textColor,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Header row
//   List<Widget> _buildHeaderRow(BuildContext context) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];
//     const double headerHeight = 80;

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;
//       final flex = index == 2 ? 3 : (index == 1 || index >= 5 ? 2 : 1);
//       final bgColor =
//           index % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     }).toList();
//   }

//   // Data cell
//   Widget _buildDataCell(
//     BuildContext context,
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 13, color: textColor),
//           softWrap: true,
//         ),
//       ),
//     );
//   }
// }

// DONE BOTH:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({super.key, this.searchCode = "", this.onCodeTap});

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;

//   final int _visibleRows = 73;

//   @override
//   void initState() {
//     super.initState();
//     futureServices = checkAndFetchLatestData();

//     // Sync horizontal scroll
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });

//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   /// Fetch + Cache
//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isDataChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isDataChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toString());
//       }

//       return newData;
//     } catch (e) {
//       final localData = await HiveService.getServices();
//       if (localData.isEmpty)
//         throw Exception('Failed to load and no cache found.');
//       return localData;
//     }
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200 && response.body.isNotEmpty) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found.');
//       }
//     } else {
//       throw Exception('Failed: ${response.statusCode}');
//     }
//   }

//   /// Smooth auto-scroll
//   void _startAutoScroll() {
//     const double scrollSpeed = 20; // pixels per second
//     const Duration tick = Duration(milliseconds: 50);

//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;

//       final maxScroll = _verticalController.position.maxScrollExtent;
//       final current = _verticalController.offset;

//       final increment = scrollSpeed * tick.inMilliseconds / 1000;

//       if (current + increment >= maxScroll) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + increment);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tableWidth = screenWidth * 2.0;

//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final double headerHeight =
//         isPortrait ? 80 : 60; // portrait taller, landscape shorter

//     return Container(
//       color: Colors.white,
//       child: FutureBuilder<List<Service>>(
//         future: futureServices,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('त्रुटि: ${snapshot.error}'));
//           }

//           final services = snapshot.data ?? [];
//           final filteredServices =
//               widget.searchCode.isEmpty
//                   ? services
//                   : services
//                       .where(
//                         (s) =>
//                             s.code.toString().trim() ==
//                             widget.searchCode.trim(),
//                       )
//                       .toList();

//           if (filteredServices.isEmpty && widget.searchCode.isNotEmpty) {
//             return const Center(child: Text('कुनै नतिजा भेटिएन।'));
//           }

//           final displayedServices =
//               filteredServices.length > _visibleRows
//                   ? filteredServices.sublist(0, _visibleRows)
//                   : filteredServices;

//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (_autoScrollTimer == null) _startAutoScroll();
//           });

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // STATIC header
//               SingleChildScrollView(
//                 controller: _horizontalHeaderController,
//                 scrollDirection: Axis.horizontal,
//                 child: SizedBox(
//                   width: tableWidth,
//                   child: Row(children: _buildHeaderRow(context, headerHeight)),
//                 ),
//               ),
//               const Divider(height: 1, color: Colors.black),

//               // Scrollable body
//               SizedBox(
//                 height: 1500, //TABLE HEIGHT ONLY
//                 child: SingleChildScrollView(
//                   controller: _verticalController,
//                   scrollDirection: Axis.vertical,
//                   child: SingleChildScrollView(
//                     controller: _horizontalBodyController,
//                     scrollDirection: Axis.horizontal,
//                     child: SizedBox(
//                       width: tableWidth,
//                       child: Column(
//                         children:
//                             displayedServices.asMap().entries.map((entry) {
//                               int index = entry.key;
//                               final service = entry.value;
//                               final isEven = index % 2 == 0;
//                               final bgColor =
//                                   isEven
//                                       ? const Color(0xFFF9D7D7)
//                                       : const Color(0xFF006699);
//                               final textColor =
//                                   isEven
//                                       ? const Color(0xFF006699)
//                                       : Colors.white;

//                               return InkWell(
//                                 onTap: () {
//                                   if (widget.onCodeTap != null)
//                                     widget.onCodeTap!(service);
//                                 },
//                                 child: Container(
//                                   color: bgColor,
//                                   child: Row(
//                                     children: [
//                                       _buildDataCell(
//                                         context,
//                                         service.code,
//                                         flex: 1,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.serviceTypeName,
//                                         flex: 2,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.serviceRecDetail,
//                                         flex: 3,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.fee,
//                                         flex: 1,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.time,
//                                         flex: 1,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.serviceProvider,
//                                         flex: 2,
//                                         textColor: textColor,
//                                       ),
//                                       _buildDataCell(
//                                         context,
//                                         service.complainListen,
//                                         flex: 2,
//                                         textColor: textColor,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Header row with fixed height
//   List<Widget> _buildHeaderRow(BuildContext context, double headerHeight) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;
//       final flex = index == 2 ? 3 : (index == 1 || index >= 5 ? 2 : 1);
//       final bgColor =
//           index % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           height: headerHeight,
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   // Data cell
//   Widget _buildDataCell(
//     BuildContext context,
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 13, color: textColor),
//           softWrap: true,
//         ),
//       ),
//     );
//   }
// }

//##################################################################################//
//TIMER:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({super.key, this.searchCode = "", this.onCodeTap});

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;

//   final int _visibleRows = 73;

//   Service? _selectedService;
//   Timer? _hideTimer;

//   @override
//   void initState() {
//     super.initState();
//     futureServices = checkAndFetchLatestData();

//     // Sync horizontal scroll
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });

//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hideTimer?.cancel();
//     super.dispose();
//   }

//   /// Fetch + Cache
//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isDataChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isDataChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toString());
//       }

//       return newData;
//     } catch (e) {
//       final localData = await HiveService.getServices();
//       if (localData.isEmpty)
//         throw Exception('Failed to load and no cache found.');
//       return localData;
//     }
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200 && response.body.isNotEmpty) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found.');
//       }
//     } else {
//       throw Exception('Failed: ${response.statusCode}');
//     }
//   }

//   /// Smooth auto-scroll
//   void _startAutoScroll() {
//     const double scrollSpeed = 20; // pixels per second
//     const Duration tick = Duration(milliseconds: 50);

//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;

//       final maxScroll = _verticalController.position.maxScrollExtent;
//       final current = _verticalController.offset;

//       final increment = scrollSpeed * tick.inMilliseconds / 1000;

//       if (current + increment >= maxScroll) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + increment);
//       }
//     });
//   }

//   void handleStarKeyPress() {
//     // Close overlay if * is pressed
//     if (_selectedService != null) {
//       setState(() {
//         _selectedService = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tableWidth = screenWidth * 2.0;

//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final double headerHeight = isPortrait ? 80 : 60;

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (RawKeyEvent event) {
//         if (event is RawKeyDownEvent && event.logicalKey.keyLabel == '*') {
//           handleStarKeyPress();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Center(child: Text('त्रुटि: ${snapshot.error}'));
//             }

//             final services = snapshot.data ?? [];
//             final filteredServices =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where(
//                           (s) =>
//                               s.code.toString().trim() ==
//                               widget.searchCode.trim(),
//                         )
//                         .toList();

//             if (filteredServices.isEmpty && widget.searchCode.isNotEmpty) {
//               return const Center(child: Text('कुनै नतिजा भेटिएन।'));
//             }

//             final displayedServices =
//                 filteredServices.length > _visibleRows
//                     ? filteredServices.sublist(0, _visibleRows)
//                     : filteredServices;

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header
//                     SingleChildScrollView(
//                       controller: _horizontalHeaderController,
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: tableWidth,
//                         child: Row(
//                           children: _buildHeaderRow(context, headerHeight),
//                         ),
//                       ),
//                     ),
//                     const Divider(height: 1, color: Colors.black),

//                     // Table body
//                     SizedBox(
//                       height: 1500,
//                       child: SingleChildScrollView(
//                         controller: _verticalController,
//                         scrollDirection: Axis.vertical,
//                         child: SingleChildScrollView(
//                           controller: _horizontalBodyController,
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: tableWidth,
//                             child: Column(
//                               children:
//                                   displayedServices.asMap().entries.map((
//                                     entry,
//                                   ) {
//                                     int index = entry.key;
//                                     final service = entry.value;
//                                     final isEven = index % 2 == 0;
//                                     final bgColor =
//                                         isEven
//                                             ? const Color(0xFFF9D7D7)
//                                             : const Color(0xFF006699);
//                                     final textColor =
//                                         isEven
//                                             ? const Color(0xFF006699)
//                                             : Colors.white;

//                                     return InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           _selectedService = service;
//                                           _hideTimer?.cancel();
//                                           _hideTimer = Timer(
//                                             const Duration(seconds: 5),
//                                             () {
//                                               if (mounted)
//                                                 setState(
//                                                   () => _selectedService = null,
//                                                 );
//                                             },
//                                           );
//                                         });
//                                         if (widget.onCodeTap != null)
//                                           widget.onCodeTap!(service);
//                                       },
//                                       child: Container(
//                                         color: bgColor,
//                                         child: Row(
//                                           children: [
//                                             _buildDataCell(
//                                               context,
//                                               service.code,
//                                               flex: 1,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceTypeName,
//                                               flex: 2,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceRecDetail,
//                                               flex: 3,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.fee,
//                                               flex: 1,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.time,
//                                               flex: 1,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceProvider,
//                                               flex: 2,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.complainListen,
//                                               flex: 2,
//                                               textColor: textColor,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Overlay
//                 if (_selectedService != null)
//                   Positioned.fill(
//                     child: Material(
//                       color: Colors.black87.withOpacity(0.9),
//                       child: Center(
//                         child: SingleChildScrollView(
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.95,
//                             padding: const EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'कोड: ${_selectedService!.code}',
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'विवरण: ${_selectedService!.serviceRecDetail}',
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text('शुल्क: ${_selectedService!.fee}'),
//                                 const SizedBox(height: 12),
//                                 Text('समय: ${_selectedService!.time}'),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(BuildContext context, double headerHeight) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     final columnFlexes = [0.6, 2, 3, 1, 1, 2, 2];

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;
//       final flex = columnFlexes[index];
//       final bgColor =
//           index % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: (flex * 10).toInt(),
//         child: Container(
//           height: headerHeight,
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   Widget _buildDataCell(
//     BuildContext context,
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 13, color: textColor),
//           softWrap: true,
//         ),
//       ),
//     );
//   }
// }

//#####################################################################//

//BEFORE WIDTH :

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'services/socket_table_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({super.key, this.searchCode = "", this.onCodeTap});

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;

//   final int _visibleRows = 73;

//   Service? _selectedService;
//   Timer? _hideTimer;

//   final SocketTableService socketService = SocketTableService();

//   @override
//   void initState() {
//     super.initState();
//     futureServices = checkAndFetchLatestData();

//     // Socket connection
//     socketService.connect(
//       url: "https://digitalbadapatra.com:3000",
//     ); // production URL
//     socketService.onTableUpdate((data) async {
//       if (data is List) {
//         final updatedServices = data.map((e) => Service.fromJson(e)).toList();
//         setState(() {
//           futureServices = Future.value(
//             updatedServices,
//           ); // update UI immediately
//         });

//         // Cache update throttled to 10 minutes
//         final box = await Hive.openBox('metaBox');
//         final lastUpdatedStr = box.get('lastUpdated') as String?;
//         final lastUpdated =
//             lastUpdatedStr != null ? DateTime.tryParse(lastUpdatedStr) : null;
//         final now = DateTime.now();

//         if (lastUpdated == null ||
//             now.difference(lastUpdated) >= Duration(minutes: 10)) {
//           await HiveService.saveServices(updatedServices);
//           await box.put('lastUpdated', now.toIso8601String());
//           print("✅ Cache updated at $now");
//         } else {
//           print("⚠️ Cache update skipped. Last update: $lastUpdated");
//         }
//       }
//     });

//     // Sync horizontal scroll
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });

//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     socketService.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hideTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isDataChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isDataChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toIso8601String());
//       }

//       return newData;
//     } catch (e) {
//       final localData = await HiveService.getServices();
//       if (localData.isEmpty)
//         throw Exception('Failed to load and no cache found.');
//       return localData;
//     }
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200 && response.body.isNotEmpty) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found.');
//       }
//     } else {
//       throw Exception('Failed: ${response.statusCode}');
//     }
//   }

//   void _startAutoScroll() {
//     const double scrollSpeed = 20;
//     const Duration tick = Duration(milliseconds: 50);

//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;

//       final maxScroll = _verticalController.position.maxScrollExtent;
//       final current = _verticalController.offset;
//       final increment = scrollSpeed * tick.inMilliseconds / 1000;

//       if (current + increment >= maxScroll) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + increment);
//       }
//     });
//   }

//   void handleStarKeyPress() {
//     if (_selectedService != null) {
//       setState(() {
//         _selectedService = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tableWidth = screenWidth * 2.0;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final double headerHeight = isPortrait ? 80 : 60;

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (RawKeyEvent event) {
//         if (event is RawKeyDownEvent && event.logicalKey.keyLabel == '*') {
//           handleStarKeyPress();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Center(child: Text('त्रुटि: ${snapshot.error}'));
//             }

//             final services = snapshot.data ?? [];
//             final filteredServices =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where(
//                           (s) =>
//                               s.code.toString().trim() ==
//                               widget.searchCode.trim(),
//                         )
//                         .toList();

//             if (filteredServices.isEmpty && widget.searchCode.isNotEmpty) {
//               return const Center(child: Text('कुनै नतिजा भेटिएन।'));
//             }

//             final displayedServices =
//                 filteredServices.length > _visibleRows
//                     ? filteredServices.sublist(0, _visibleRows)
//                     : filteredServices;

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header
//                     SingleChildScrollView(
//                       controller: _horizontalHeaderController,
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: tableWidth,
//                         child: Row(
//                           children: _buildHeaderRow(context, headerHeight),
//                         ),
//                       ),
//                     ),
//                     const Divider(height: 1, color: Colors.black),

//                     // Table body
//                     SizedBox(
//                       height: 1500,
//                       child: SingleChildScrollView(
//                         controller: _verticalController,
//                         scrollDirection: Axis.vertical,
//                         child: SingleChildScrollView(
//                           controller: _horizontalBodyController,
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: tableWidth,
//                             child: Column(
//                               children:
//                                   displayedServices.asMap().entries.map((
//                                     entry,
//                                   ) {
//                                     int index = entry.key;
//                                     final service = entry.value;
//                                     final isEven = index % 2 == 0;
//                                     final bgColor =
//                                         isEven
//                                             ? const Color(0xFFF9D7D7)
//                                             : const Color(0xFF006699);
//                                     final textColor =
//                                         isEven
//                                             ? const Color(0xFF006699)
//                                             : Colors.white;

//                                     return InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           _selectedService = service;
//                                           _hideTimer?.cancel();
//                                           _hideTimer = Timer(
//                                             const Duration(seconds: 5),
//                                             () {
//                                               if (mounted)
//                                                 setState(
//                                                   () => _selectedService = null,
//                                                 );
//                                             },
//                                           );
//                                         });
//                                         if (widget.onCodeTap != null)
//                                           widget.onCodeTap!(service);
//                                       },
//                                       child: Container(
//                                         color: bgColor,
//                                         child: Row(
//                                           children: [
//                                             _buildDataCell(
//                                               context,
//                                               service.code,
//                                               flex: 1,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceTypeName,
//                                               flex: 2,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceRecDetail,
//                                               flex: 3,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.fee,
//                                               flex: 1,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.time,
//                                               flex: 1,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceProvider,
//                                               flex: 2,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.complainListen,
//                                               flex: 2,
//                                               textColor: textColor,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Overlay
//                 if (_selectedService != null)
//                   Positioned.fill(
//                     child: Material(
//                       color: Colors.black87.withOpacity(0.9),
//                       child: Center(
//                         child: SingleChildScrollView(
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.95,
//                             padding: const EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'कोड: ${_selectedService!.code}',
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'सेवा किसिम: ${_selectedService!.serviceTypeName}',
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'विवरण: ${_selectedService!.serviceRecDetail}',
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text('शुल्क: ${_selectedService!.fee}'),
//                                 const SizedBox(height: 12),
//                                 Text('समय: ${_selectedService!.time}'),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'सेवा दिने शाखा: ${_selectedService!.serviceProvider}',
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   'गुनासो अधिकारी: ${_selectedService!.complainListen}',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(BuildContext context, double headerHeight) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     final columnFlexes = [0.6, 2, 3, 1, 1, 2, 2];

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;
//       final flex = columnFlexes[index];
//       final bgColor =
//           index % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: (flex * 10).toInt(),
//         child: Container(
//           height: headerHeight,
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   Widget _buildDataCell(
//     BuildContext context,
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 13, color: textColor),
//           softWrap: true,
//         ),
//       ),
//     );
//   }
// }

//#############################################################################//

//AFTER WIDTH FIX DO HERE:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'services/socket_table_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({super.key, this.searchCode = "", this.onCodeTap});

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;

//   final int _visibleRows = 73;
//   Service? _selectedService;
//   Timer? _hideTimer;
//   final SocketTableService socketService = SocketTableService();

//   @override
//   void initState() {
//     super.initState();
//     futureServices = checkAndFetchLatestData();

//     socketService.connect(url: "https://digitalbadapatra.com:3000");

//     socketService.onTableUpdate((data) async {
//       if (data is List) {
//         final updatedServices = data.map((e) => Service.fromJson(e)).toList();
//         setState(() => futureServices = Future.value(updatedServices));

//         final box = await Hive.openBox('metaBox');
//         final lastUpdatedStr = box.get('lastUpdated') as String?;
//         final lastUpdated =
//             lastUpdatedStr != null ? DateTime.tryParse(lastUpdatedStr) : null;
//         final now = DateTime.now();

//         if (lastUpdated == null ||
//             now.difference(lastUpdated) >= const Duration(minutes: 10)) {
//           await HiveService.saveServices(updatedServices);
//           await box.put('lastUpdated', now.toIso8601String());
//         }
//       }
//     });

//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });

//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     socketService.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hideTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isDataChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isDataChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toIso8601String());
//       }

//       return newData;
//     } catch (e) {
//       final localData = await HiveService.getServices();
//       if (localData.isEmpty)
//         throw Exception('Failed to load and no cache found.');
//       return localData;
//     }
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200 && response.body.isNotEmpty) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found.');
//       }
//     } else {
//       throw Exception('Failed: ${response.statusCode}');
//     }
//   }

//   void _startAutoScroll() {
//     const double scrollSpeed = 20;
//     const Duration tick = Duration(milliseconds: 50);

//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;
//       final maxScroll = _verticalController.position.maxScrollExtent;
//       final current = _verticalController.offset;
//       final increment = scrollSpeed * tick.inMilliseconds / 1000;

//       if (current + increment >= maxScroll) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + increment);
//       }
//     });
//   }

//   void handleStarKeyPress() {
//     if (_selectedService != null) {
//       setState(() => _selectedService = null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;

//     final tableWidth = screenWidth * (isPortrait ? 1.2 : 1.4);
//     final double headerHeight = isPortrait ? 80 : 60;

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (RawKeyEvent event) {
//         if (event is RawKeyDownEvent && event.logicalKey.keyLabel == '*') {
//           handleStarKeyPress();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Center(child: Text('त्रुटि: ${snapshot.error}'));
//             }

//             final services = snapshot.data ?? [];
//             final filteredServices =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where(
//                           (s) =>
//                               s.code.toString().trim() ==
//                               widget.searchCode.trim(),
//                         )
//                         .toList();

//             if (filteredServices.isEmpty && widget.searchCode.isNotEmpty) {
//               return const Center(child: Text('कुनै नतिजा भेटिएन।'));
//             }

//             final displayedServices =
//                 filteredServices.length > _visibleRows
//                     ? filteredServices.sublist(0, _visibleRows)
//                     : filteredServices;

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // HEADER
//                     SingleChildScrollView(
//                       controller: _horizontalHeaderController,
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: tableWidth,
//                         child: Row(
//                           children: _buildHeaderRow(
//                             context,
//                             headerHeight,
//                             isPortrait,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Divider(height: 1, color: Colors.black),

//                     // TABLE BODY
//                     SizedBox(
//                       height: 1600,
//                       child: SingleChildScrollView(
//                         controller: _verticalController,
//                         scrollDirection: Axis.vertical,
//                         child: SingleChildScrollView(
//                           controller: _horizontalBodyController,
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: tableWidth,
//                             child: Column(
//                               children:
//                                   displayedServices.asMap().entries.map((
//                                     entry,
//                                   ) {
//                                     int index = entry.key;
//                                     final service = entry.value;
//                                     final isEven = index % 2 == 0;
//                                     final bgColor =
//                                         isEven
//                                             ? const Color(0xFFF9D7D7)
//                                             : const Color(0xFF006699);
//                                     final textColor =
//                                         isEven
//                                             ? const Color(0xFF006699)
//                                             : Colors.white;

//                                     return InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           _selectedService = service;
//                                           _hideTimer?.cancel();
//                                           _hideTimer = Timer(
//                                             const Duration(seconds: 5),
//                                             () {
//                                               if (mounted)
//                                                 setState(
//                                                   () => _selectedService = null,
//                                                 );
//                                             },
//                                           );
//                                         });
//                                         if (widget.onCodeTap != null) {
//                                           widget.onCodeTap!(service);
//                                         }
//                                       },
//                                       child: Container(
//                                         color: bgColor,
//                                         child: Row(
//                                           children: [
//                                             _buildDataCell(
//                                               context,
//                                               service.code,
//                                               flex: 2,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceTypeName,
//                                               flex: isPortrait ? 10 : 6,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceRecDetail,
//                                               flex:
//                                                   isPortrait
//                                                       ? 12
//                                                       : 10, // ✅ reduced 3rd column
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.fee,
//                                               flex: 6,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.time,
//                                               flex: 6,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.serviceProvider,
//                                               flex: isPortrait ? 10 : 5,
//                                               textColor: textColor,
//                                             ),
//                                             _buildDataCell(
//                                               context,
//                                               service.complainListen,
//                                               flex: isPortrait ? 10 : 5,
//                                               textColor: textColor,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(
//     BuildContext context,
//     double headerHeight,
//     bool isPortrait,
//   ) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     final columnFlexes =
//         isPortrait
//             ? [2, 10, 12, 6, 6, 10, 10] // ✅ 3rd column reduced to 12
//             : [2, 6, 10, 6, 6, 5, 5];

//     return headers.asMap().entries.map((entry) {
//       final index = entry.key;
//       final title = entry.value;
//       final flex = columnFlexes[index];
//       final bgColor =
//           index % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           height: headerHeight,
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//           alignment: Alignment.center,
//           color: bgColor,
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//             softWrap: true, // ✅ wrap if doesn't fit
//           ),
//         ),
//       );
//     }).toList();
//   }

//   Widget _buildDataCell(
//     BuildContext context,
//     String text, {
//     int flex = 1,
//     Color textColor = Colors.white,
//   }) {
//     return Expanded(
//       flex: flex,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         alignment: Alignment.topLeft,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 13, color: textColor),
//           softWrap: true, // ✅ wrap text
//         ),
//       ),
//     );
//   }
// }

// dont change

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({Key? key, this.searchCode = "", this.onCodeTap})
//     : super(key: key);

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;
//   Timer? _hidePopupTimer;

//   final int _visibleRows = 73;
//   Service? _selectedService;

//   // Pusher instance
//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     futureServices = checkAndFetchLatestData();
//     _initSocketListener();

//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });
//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   Future<void> _initSocketListener() async {
//     try {
//       await _pusher.init(
//         apiKey: 'f5e0f21674d914753049', // your Pusher API Key
//         cluster: 'ap2', // your cluster
//         // You can also add onConnectionStateChange, onError, etc if needed
//         onEvent: (PusherEvent event) {
//           if (event.data == null) return;
//           dynamic rawData = event.data;
//           Map<String, dynamic>? dataMap;
//           if (rawData is String) {
//             try {
//               final decoded = json.decode(rawData);
//               if (decoded is Map<String, dynamic>) {
//                 dataMap = decoded;
//               }
//             } catch (e) {
//               // ignore parsing error
//             }
//           } else if (rawData is Map) {
//             try {
//               dataMap = Map<String, dynamic>.from(rawData);
//             } catch (e) {
//               // ignore
//             }
//           }
//           if (dataMap == null) return;

//           if (dataMap['services'] != null && dataMap['services'] is List) {
//             final updatedList =
//                 (dataMap['services'] as List)
//                     .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
//                     .toList();

//             setState(() {
//               futureServices = Future.value(updatedList);
//             });

//             Hive.openBox('metaBox').then((box) async {
//               await HiveService.saveServices(updatedList);
//               await box.put('lastUpdated', DateTime.now().toIso8601String());
//             });
//           }
//         },
//       );
//       await _pusher.connect();
//       await _pusher.subscribe(channelName: 'table‑updates‑channel');
//       // ← replace with your actual backend channel name
//     } catch (e) {
//       debugPrint('Socket init error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _pusher.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hidePopupTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isDataChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isDataChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toIso8601String());
//       }
//       return newData;
//     } catch (e) {
//       final localData = await HiveService.getServices();
//       if (localData.isEmpty)
//         throw Exception('Failed to load and no cache found.');
//       return localData;
//     }
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200 && response.body.isNotEmpty) {
//       final data = jsonDecode(response.body);
//       if (data['data'] != null && data['data'] is List) {
//         return (data['data'] as List)
//             .map((jsonItem) => Service.fromJson(jsonItem))
//             .toList();
//       } else {
//         throw Exception('No data found.');
//       }
//     } else {
//       throw Exception('Failed: ${response.statusCode}');
//     }
//   }

//   void _startAutoScroll() {
//     const double scrollSpeed = 20.0;
//     const Duration tick = Duration(milliseconds: 50);

//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;
//       final maxScroll = _verticalController.position.maxScrollExtent;
//       if (maxScroll <= 0) return;

//       final current = _verticalController.offset;
//       final double increment = scrollSpeed * tick.inMilliseconds / 1000.0;

//       if (current + increment >= maxScroll) {
//         _verticalController.jumpTo(0.0);
//       } else {
//         _verticalController.jumpTo(current + increment);
//       }
//     });
//   }

//   void showFullScreenPopup(Service service) {
//     setState(() => _selectedService = service);
//     _hidePopupTimer?.cancel();
//     _hidePopupTimer = Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void handleStarKeyPress() {
//     if (_selectedService != null) {
//       setState(() => _selectedService = null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final bool isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final double tableWidth = screenWidth * (isPortrait ? 1.2 : 1.4);
//     final double headerHeight = isPortrait ? 80.0 : 60.0;

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (RawKeyEvent event) {
//         if (event is RawKeyDownEvent && event.logicalKey.keyLabel == '*') {
//           handleStarKeyPress();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(child: Text('त्रुटि: ${snapshot.error}'));
//             }

//             final services = snapshot.data ?? [];
//             final filtered =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where(
//                           (s) =>
//                               s.code.toString().trim() ==
//                               widget.searchCode.trim(),
//                         )
//                         .toList();

//             final displayed =
//                 filtered.length > _visibleRows
//                     ? filtered.sublist(0, _visibleRows)
//                     : filtered;

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SingleChildScrollView(
//                       controller: _horizontalHeaderController,
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: tableWidth,
//                         child: Row(
//                           children: _buildHeaderRow(headerHeight, isPortrait),
//                         ),
//                       ),
//                     ),
//                     const Divider(height: 1, color: Colors.black),
//                     SizedBox(
//                       height: 1600.0,
//                       child: SingleChildScrollView(
//                         controller: _verticalController,
//                         scrollDirection: Axis.vertical,
//                         child: SingleChildScrollView(
//                           controller: _horizontalBodyController,
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: tableWidth,
//                             child: Column(
//                               children:
//                                   displayed.asMap().entries.map((entry) {
//                                     final idx = entry.key;
//                                     final service = entry.value;
//                                     final bool isEven = idx % 2 == 0;
//                                     final Color bgColor =
//                                         isEven
//                                             ? const Color(0xFFF9D7D7)
//                                             : const Color(0xFF006699);
//                                     final Color textColor =
//                                         isEven
//                                             ? const Color(0xFF006699)
//                                             : Colors.white;

//                                     return InkWell(
//                                       onTap: () {
//                                         showFullScreenPopup(service);
//                                         widget.onCodeTap?.call(service);
//                                       },
//                                       child: Container(
//                                         color: bgColor,
//                                         child: Row(
//                                           children: _buildRowCells(
//                                             service,
//                                             textColor,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (_selectedService != null)
//                   Positioned.fill(
//                     child: GestureDetector(
//                       onTap: () => setState(() => _selectedService = null),
//                       child: Container(
//                         color: Colors.white,
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(32.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   _selectedService!.code,
//                                   style: const TextStyle(
//                                     fontSize: 80,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   _selectedService!.serviceTypeName,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   _selectedService!.serviceRecDetail,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 40),
//                                 const Text(
//                                   "Press * to return",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(double headerHeight, bool isPortrait) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];

//     final columnFlexes =
//         isPortrait ? [2, 10, 12, 6, 6, 10, 10] : [2, 6, 10, 6, 6, 5, 5];

//     return headers.asMap().entries.map((entry) {
//       final idx = entry.key;
//       final title = entry.value;
//       final flex = columnFlexes[idx];
//       final Color bg =
//           idx % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           height: headerHeight,
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//           alignment: Alignment.center,
//           color: bg,
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//             softWrap: true,
//           ),
//         ),
//       );
//     }).toList();
//   }

//   List<Widget> _buildRowCells(Service s, Color textColor) {
//     final List<String> values = [
//       s.code,
//       s.serviceTypeName,
//       s.serviceRecDetail,
//       s.fee,
//       s.time,
//       s.serviceProvider,
//       s.complainListen,
//     ];

//     final bool isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final columnFlexes =
//         isPortrait ? [2, 10, 12, 6, 6, 10, 10] : [2, 6, 10, 6, 6, 5, 5];

//     return values.asMap().entries.map((entry) {
//       final idx = entry.key;
//       final text = entry.value;
//       final flex = columnFlexes[idx];

//       return Expanded(
//         flex: flex,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.topLeft,
//           child: Text(
//             text,
//             style: TextStyle(fontSize: 13, color: textColor),
//             softWrap: true,
//           ),
//         ),
//       );
//     }).toList();
//   }
// }

// LOCAL CACHE
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({Key? key, this.searchCode = "", this.onCodeTap})
//     : super(key: key);

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;
//   Timer? _hidePopupTimer;

//   final int _visibleRows = 73;
//   Service? _selectedService;

//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     futureServices = checkAndFetchLatestData();
//     _initSocketListener();

//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });
//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   // ──────────────────────────────────────────────────────────────
//   // Pusher: Listen + Clear Cache on Admin Delete
//   Future<void> _initSocketListener() async {
//     try {
//       await _pusher.init(
//         apiKey: 'f5e0f21674d914753049',
//         cluster: 'ap2',
//         onEvent: (PusherEvent event) async {
//           if (event.data == null) return;

//           // Parse data
//           Map<String, dynamic>? dataMap;
//           try {
//             final raw =
//                 event.data is String ? json.decode(event.data) : event.data;
//             if (raw is Map<String, dynamic>) dataMap = raw;
//           } catch (e) {
//             return;
//           }
//           if (dataMap == null) return;

//           // TABLE UPDATE
//           if (dataMap['services'] != null && dataMap['services'] is List) {
//             final updatedList =
//                 (dataMap['services'] as List)
//                     .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
//                     .toList();

//             setState(() {
//               futureServices = Future.value(updatedList);
//             });

//             await HiveService.saveServices(updatedList);
//             final metaBox = await Hive.openBox('metaBox');
//             await metaBox.put('lastUpdated', DateTime.now().toIso8601String());
//           }
//           // ADMIN DELETE → CLEAR LOCAL CACHE
//           else if (event.channelName == 'admin-clear-channel' &&
//               event.eventName == 'clear-table') {
//             final data = dataMap;
//             if (data['orgId'] == '22') {
//               await _clearLocalCache();
//             }
//           }
//         },
//       );

//       await _pusher.connect();
//       await _pusher.subscribe(channelName: 'table-updates-channel');
//       await _pusher.subscribe(channelName: 'admin-clear-channel');
//     } catch (e) {
//       debugPrint('Socket init error: $e');
//     }
//   }

//   // ──────────────────────────────────────────────────────────────
//   // Clear Local Cache (Services + Meta)
//   Future<void> _clearLocalCache() async {
//     try {
//       await HiveService.clearServices();
//       final metaBox = await Hive.openBox('metaBox');
//       await metaBox.clear();
//       debugPrint("Local table cache cleared by admin");

//       setState(() {
//         futureServices = Future.value([]);
//       });
//     } catch (e) {
//       debugPrint("Clear cache failed: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _pusher.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hidePopupTimer?.cancel();
//     super.dispose();
//   }

//   // ──────────────────────────────────────────────────────────────
//   // Fetch + Cache Logic
//   Future<List<Service>> checkAndFetchLatestData() async {
//     try {
//       final newData = await fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isChanged =
//           jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toIso8601String());
//       }
//       return newData;
//     } catch (e) {
//       final local = await HiveService.getServices();
//       if (local.isEmpty) throw Exception('No data & no cache');
//       return local;
//     }
//   }

//   Future<List<Service>> fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['data'] is List) {
//         return (data['data'] as List).map((e) => Service.fromJson(e)).toList();
//       }
//     }
//     throw Exception('Failed to load');
//   }

//   // ──────────────────────────────────────────────────────────────
//   // Auto Scroll
//   void _startAutoScroll() {
//     const speed = 20.0;
//     const tick = Duration(milliseconds: 50);
//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;
//       final max = _verticalController.position.maxScrollExtent;
//       if (max <= 0) return;
//       final current = _verticalController.offset;
//       final inc = speed * tick.inMilliseconds / 1000.0;
//       if (current + inc >= max) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + inc);
//       }
//     });
//   }

//   void showFullScreenPopup(Service service) {
//     setState(() => _selectedService = service);
//     _hidePopupTimer?.cancel();
//     _hidePopupTimer = Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void handleStarKeyPress() {
//     if (_selectedService != null) {
//       setState(() => _selectedService = null);
//     }
//   }

//   // ──────────────────────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final tableWidth = width * (isPortrait ? 1.2 : 1.4);
//     final headerHeight = isPortrait ? 80.0 : 60.0;

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (event) {
//         if (event is RawKeyDownEvent && event.logicalKey.keyLabel == '*') {
//           handleStarKeyPress();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(child: Text('त्रुटि: ${snapshot.error}'));
//             }

//             final services = snapshot.data ?? [];
//             final filtered =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where(
//                           (s) =>
//                               s.code.toString().trim() ==
//                               widget.searchCode.trim(),
//                         )
//                         .toList();

//             final displayed =
//                 filtered.length > _visibleRows
//                     ? filtered.sublist(0, _visibleRows)
//                     : filtered;

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SingleChildScrollView(
//                       controller: _horizontalHeaderController,
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: tableWidth,
//                         child: Row(
//                           children: _buildHeaderRow(headerHeight, isPortrait),
//                         ),
//                       ),
//                     ),
//                     const Divider(height: 1, color: Colors.black),
//                     SizedBox(
//                       height: 1600.0,
//                       child: SingleChildScrollView(
//                         controller: _verticalController,
//                         child: SingleChildScrollView(
//                           controller: _horizontalBodyController,
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: tableWidth,
//                             child: Column(
//                               children:
//                                   displayed.asMap().entries.map((e) {
//                                     final idx = e.key;
//                                     final service = e.value;
//                                     final isEven = idx % 2 == 0;
//                                     final bg =
//                                         isEven
//                                             ? const Color(0xFFF9D7D7)
//                                             : const Color(0xFF006699);
//                                     final textColor =
//                                         isEven
//                                             ? const Color(0xFF006699)
//                                             : Colors.white;

//                                     return InkWell(
//                                       onTap: () {
//                                         showFullScreenPopup(service);
//                                         widget.onCodeTap?.call(service);
//                                       },
//                                       child: Container(
//                                         color: bg,
//                                         child: Row(
//                                           children: _buildRowCells(
//                                             service,
//                                             textColor,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (_selectedService != null)
//                   Positioned.fill(
//                     child: GestureDetector(
//                       onTap: () => setState(() => _selectedService = null),
//                       child: Container(
//                         color: Colors.white,
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(32.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   _selectedService!.code,
//                                   style: const TextStyle(
//                                     fontSize: 80,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   _selectedService!.serviceTypeName,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   _selectedService!.serviceRecDetail,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 40),
//                                 const Text(
//                                   "Press * to return",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // ──────────────────────────────────────────────────────────────
//   List<Widget> _buildHeaderRow(double height, bool isPortrait) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];
//     final flexes =
//         isPortrait ? [2, 10, 12, 6, 6, 10, 10] : [2, 6, 10, 6, 6, 5, 5];

//     return headers.asMap().entries.map((e) {
//       final idx = e.key;
//       final title = e.value;
//       final flex = flexes[idx];
//       final bg =
//           idx % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           height: height,
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//           alignment: Alignment.center,
//           color: bg,
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//             softWrap: true,
//           ),
//         ),
//       );
//     }).toList();
//   }

//   List<Widget> _buildRowCells(Service s, Color textColor) {
//     final values = [
//       s.code,
//       s.serviceTypeName,
//       s.serviceRecDetail,
//       s.fee,
//       s.time,
//       s.serviceProvider,
//       s.complainListen,
//     ];
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final flexes =
//         isPortrait ? [2, 10, 12, 6, 6, 10, 10] : [2, 6, 10, 6, 6, 5, 5];

//     return values.asMap().entries.map((e) {
//       final idx = e.key;
//       final text = e.value;
//       final flex = flexes[idx];

//       return Expanded(
//         flex: flex,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.topLeft,
//           child: Text(
//             text,
//             style: TextStyle(fontSize: 13, color: textColor),
//             softWrap: true,
//           ),
//         ),
//       );
//     }).toList();
//   }
// }

//OLD CODE:
//TV RESPONSIVE:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart'; // kIsWeb
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;

//   const WaraBadapatraTable({Key? key, this.searchCode = "", this.onCodeTap})
//       : super(key: key);

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;
//   Timer? _hidePopupTimer;

//   Service? _selectedService;

//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     futureServices = _checkAndFetchLatestData();
//     _initSocketListener();

//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });
//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   Future<void> _initSocketListener() async {
//     try {
//       await _pusher.init(
//         apiKey: 'f5e0f21674d914753049',
//         cluster: 'ap2',
//         onEvent: (PusherEvent event) async {
//           if (event.data == null) return;
//           Map<String, dynamic>? dataMap;
//           try {
//             final raw =
//                 event.data is String ? json.decode(event.data) : event.data;
//             if (raw is Map<String, dynamic>) dataMap = raw;
//           } catch (_) {}
//           if (dataMap == null) return;

//           if (dataMap['services'] != null && dataMap['services'] is List) {
//             final updatedList = (dataMap['services'] as List)
//                 .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
//                 .toList();

//             setState(() {
//               futureServices = Future.value(updatedList);
//             });

//             await HiveService.saveServices(updatedList);
//             final metaBox = await Hive.openBox('metaBox');
//             await metaBox.put('lastUpdated', DateTime.now().toIso8601String());
//           } else if (event.channelName == 'admin-clear-channel' &&
//               event.eventName == 'clear-table') {
//             if (dataMap['orgId'] == '22') {
//               await _clearLocalCache();
//             }
//           }
//         },
//       );

//       await _pusher.connect();
//       await _pusher.subscribe(channelName: 'table-updates-channel');
//       await _pusher.subscribe(channelName: 'admin-clear-channel');
//     } catch (e) {
//       debugPrint('Socket init error: $e');
//     }
//   }

//   Future<void> _clearLocalCache() async {
//     try {
//       await HiveService.clearServices();
//       final metaBox = await Hive.openBox('metaBox');
//       await metaBox.clear();
//       setState(() {
//         futureServices = Future.value([]);
//       });
//     } catch (e) {
//       debugPrint("Clear cache failed: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _pusher.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hidePopupTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> _checkAndFetchLatestData() async {
//     try {
//       final newData = await _fetchWaraBadapatra();
//       final oldData = await HiveService.getServices();

//       final isChanged = jsonEncode(newData.map((e) => e.toJson()).toList()) !=
//           jsonEncode(oldData.map((e) => e.toJson()).toList());

//       if (isChanged) {
//         await HiveService.saveServices(newData);
//         final box = await Hive.openBox('metaBox');
//         await box.put('lastUpdated', DateTime.now().toIso8601String());
//       }

//       return newData;
//     } catch (e) {
//       final local = await HiveService.getServices();
//       if (local.isEmpty) return [];
//       return local;
//     }
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     Uri url;

//     if (kIsWeb) {
//       // Use CORS proxy for Web
//       url = Uri.parse(
//           'https://cors-anywhere.herokuapp.com/http://digitalbadapatra.com/api/v1/get_wara_badapatra');
//     } else {
//       url = Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra');
//     }

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['data'] is List) {
//         return (data['data'] as List)
//             .map((e) => Service.fromJson(e))
//             .toList();
//       }
//     }

//     throw Exception('Failed to load table data');
//   }

//   void _startAutoScroll() {
//     const speed = 20.0;
//     const tick = Duration(milliseconds: 50);
//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;
//       final max = _verticalController.position.maxScrollExtent;
//       if (max <= 0) return;
//       final current = _verticalController.offset;
//       final inc = speed * tick.inMilliseconds / 1000.0;
//       if (current + inc >= max) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + inc);
//       }
//     });
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     _hidePopupTimer?.cancel();
//     _hidePopupTimer = Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleStarKey() {
//     if (_selectedService != null) setState(() => _selectedService = null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final tableWidth = width * (isPortrait ? 1.2 : 1.4);
//     final headerHeight = isPortrait ? 80.0 : 60.0;

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (event) {
//         if (event is RawKeyDownEvent && event.logicalKey.keyLabel == '*') {
//           _handleStarKey();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Center(
//                   child: Text(
//                 snapshot.error.toString(),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 16, color: Colors.red),
//               ));
//             }

//             final services = snapshot.data ?? [];
//             if (services.isEmpty) {
//               return const Center(child: Text('डेटा उपलब्ध छैन।'));
//             }

//             final filtered = widget.searchCode.isEmpty
//                 ? services
//                 : services
//                     .where((s) =>
//                         s.code.trim() == widget.searchCode.trim())
//                     .toList();

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SingleChildScrollView(
//                       controller: _horizontalHeaderController,
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: tableWidth,
//                         child: Row(
//                           children: _buildHeaderRow(headerHeight, isPortrait),
//                         ),
//                       ),
//                     ),
//                     const Divider(height: 1, color: Colors.black),
//                     SizedBox(
//                       height: 1600,
//                       child: SingleChildScrollView(
//                         controller: _verticalController,
//                         child: SingleChildScrollView(
//                           controller: _horizontalBodyController,
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: tableWidth,
//                             child: Column(
//                               children: filtered.map((service) {
//                                 final idx = filtered.indexOf(service);
//                                 final isEven = idx % 2 == 0;
//                                 final bg = isEven
//                                     ? const Color(0xFFF9D7D7)
//                                     : const Color(0xFF006699);
//                                 final textColor =
//                                     isEven ? const Color(0xFF006699) : Colors.white;

//                                 return InkWell(
//                                   onTap: () {
//                                     _showFullScreen(service);
//                                     widget.onCodeTap?.call(service);
//                                   },
//                                   child: Container(
//                                     color: bg,
//                                     child: Row(
//                                       children:
//                                           _buildRowCells(service, textColor),
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (_selectedService != null)
//                   Positioned.fill(
//                     child: GestureDetector(
//                       onTap: () => setState(() => _selectedService = null),
//                       child: Container(
//                         color: Colors.white,
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(32.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   _selectedService!.code,
//                                   style: const TextStyle(
//                                     fontSize: 80,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   _selectedService!.serviceTypeName,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   _selectedService!.serviceRecDetail,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 40),
//                                 const Text(
//                                   "Press * to return",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildHeaderRow(double height, bool isPortrait) {
//     final headers = [
//       'क्र.स',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्‍ने अधिकारी',
//     ];
//     final flexes =
//         isPortrait ? [2, 10, 12, 6, 6, 10, 10] : [2, 6, 10, 6, 6, 5, 5];

//     return headers.asMap().entries.map((e) {
//       final idx = e.key;
//       final title = e.value;
//       final flex = flexes[idx];
//       final bg =
//           idx % 2 == 1 ? const Color(0xFFC40000) : const Color(0xFFE45C53);

//       return Expanded(
//         flex: flex,
//         child: Container(
//           height: height,
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//           alignment: Alignment.center,
//           color: bg,
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//             softWrap: true,
//           ),
//         ),
//       );
//     }).toList();
//   }

//   List<Widget> _buildRowCells(Service s, Color textColor) {
//     final values = [
//       s.code,
//       s.serviceTypeName,
//       s.serviceRecDetail,
//       s.fee,
//       s.time,
//       s.serviceProvider,
//       s.complainListen,
//     ];
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final flexes =
//         isPortrait ? [2, 10, 12, 6, 6, 10, 10] : [2, 6, 10, 6, 6, 5, 5];

//     return values.asMap().entries.map((e) {
//       final idx = e.key;
//       final text = e.value;
//       final flex = flexes[idx];

//       return Expanded(
//         flex: flex,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.topLeft,
//           child: Text(
//             text,
//             style: TextStyle(fontSize: 13, color: textColor),
//             softWrap: true,
//           ),
//         ),
//       );
//     }).toList();
//   }
// }

//########################################################################//
//NEW:

//TABLE CONTENT DONE:

//import 'dart:async';
//import 'dart:convert';
//import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const WaraBadapatraTable({
//     Key? key,
//     this.searchCode = "",
//     this.onCodeTap,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices = Future.value([]);
//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;
//   Timer? _hidePopupTimer;

//   Service? _selectedService;
//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     _clearLocalCache().then((_) {
//       futureServices = _fetchWaraBadapatra();
//       setState(() {});
//     });
//     _initSocketListener();

//     // Sync horizontal scrolls
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });
//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   Future<void> _initSocketListener() async {
//     try {
//       await _pusher.init(
//         apiKey: 'f5e0f21674d914753049',
//         cluster: 'ap2',
//         onEvent: (PusherEvent event) async {
//           if (event.data == null) return;
//           Map<String, dynamic>? dataMap;
//           try {
//             final raw =
//                 event.data is String ? json.decode(event.data) : event.data;
//             if (raw is Map<String, dynamic>) dataMap = raw;
//           } catch (_) {}
//           if (dataMap == null) return;

//           if (dataMap['services'] != null && dataMap['services'] is List) {
//             final updatedList =
//                 (dataMap['services'] as List)
//                     .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
//                     .toList();

//             setState(() {
//               futureServices = Future.value(updatedList);
//             });

//             await HiveService.saveServices(updatedList);
//           } else if (event.channelName == 'admin-clear-channel' &&
//               event.eventName == 'clear-table') {
//             if (dataMap['orgId'] == widget.orgid) {
//               await _clearLocalCache();
//             }
//           }
//         },
//       );

//       await _pusher.connect();
//       await _pusher.subscribe(channelName: 'table-updates-channel');
//       await _pusher.subscribe(channelName: 'admin-clear-channel');
//     } catch (e) {
//       debugPrint('Socket init error: $e');
//     }
//   }

//   Future<void> _clearLocalCache() async {
//     try {
//       await HiveService.clearServices();
//       final metaBox = await Hive.openBox('metaBox');
//       await metaBox.clear();
//       setState(() {
//         futureServices = Future.value([]);
//       });
//     } catch (e) {
//       debugPrint("Clear cache failed: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _pusher.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hidePopupTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       kIsWeb
//           ? 'https://cors-anywhere.herokuapp.com/https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra'
//           : 'https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     final body = {
//       'userid': widget.userid.toString(),
//       'orgid': widget.orgid.toString(),
//       'org_code': widget.orgCode,
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: body,
//       );

//       debugPrint('Request body: $body');
//       debugPrint('Response status: ${response.statusCode}');
//       debugPrint('Response body: ${response.body}');

//       final decoded = jsonDecode(response.body);

//       List<dynamic> serviceList;

//       // handle new API wrapping
//       if (decoded['data'] != null && decoded['data'] is List) {
//         serviceList = decoded['data'];
//       } else if (decoded['payload']?['services'] != null &&
//           decoded['payload']['services'] is List) {
//         serviceList = decoded['payload']['services'];
//       } else {
//         serviceList = [];
//       }

//       final services = serviceList.map((e) => Service.fromJson(e)).toList();

//       await HiveService.saveServices(services);
//       return services;
//     } catch (e) {
//       debugPrint('Fetch error: $e');
//       return [];
//     }
//   }

//   void _startAutoScroll() {
//     const speed = 20.0;
//     const tick = Duration(milliseconds: 50);
//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;
//       final max = _verticalController.position.maxScrollExtent;
//       if (max <= 0) return;
//       final current = _verticalController.offset;
//       final inc = speed * tick.inMilliseconds / 1000.0;
//       if (current + inc >= max) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + inc);
//       }
//     });
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     _hidePopupTimer?.cancel();
//     _hidePopupTimer = Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleStarKey() {
//     if (_selectedService != null) setState(() => _selectedService = null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final tableWidth = width * (isPortrait ? 1.2 : 1.4);

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (event) {
//         if (event.logicalKey.keyLabel == '*') {
//           _handleStarKey();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   snapshot.error.toString(),
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 16, color: Colors.red),
//                 ),
//               );
//             }

//             final services = snapshot.data ?? [];
//             if (services.isEmpty) {
//               return const Center(child: Text('डेटा उपलब्ध छैन।'));
//             }

//             final filtered =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where((s) => s.code.trim() == widget.searchCode.trim())
//                         .toList();

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SizedBox(
//                 width: tableWidth,
//                 child: Column(
//                   children:
//                       filtered.map((service) {
//                         final idx = filtered.indexOf(service);
//                         final isEven = idx % 2 == 0;
//                         final bg =
//                             isEven
//                                 ? const Color(0xFFF9D7D7)
//                                 : const Color(0xFF006699);
//                         final textColor =
//                             isEven ? const Color(0xFF006699) : Colors.white;

//                         return InkWell(
//                           onTap: () {
//                             _showFullScreen(service);
//                             widget.onCodeTap?.call(service);
//                           },
//                           child: Container(
//                             color: bg,
//                             padding: const EdgeInsets.all(8),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     service.code,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 10,
//                                   child: Text(
//                                     service.serviceTypeName,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 12,
//                                   child: Text(
//                                     service.serviceRecDetail,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 6,
//                                   child: Text(
//                                     service.fee,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 6,
//                                   child: Text(
//                                     service.time,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 10,
//                                   child: Text(
//                                     service.serviceProvider,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 10,
//                                   child: Text(
//                                     service.complainListen,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//##################################################################################//

//TABLE HEADER DONE:
//2050:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const WaraBadapatraTable({
//     Key? key,
//     this.searchCode = "",
//     this.onCodeTap,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices = Future.value([]);
//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;
//   Timer? _hidePopupTimer;

//   Service? _selectedService;
//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     _clearLocalCache().then((_) {
//       futureServices = _fetchWaraBadapatra();
//       setState(() {});
//     });
//     _initSocketListener();

//     // Sync horizontal scrolls
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });
//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   Future<void> _initSocketListener() async {
//     try {
//       await _pusher.init(
//         apiKey: 'f5e0f21674d914753049',
//         cluster: 'ap2',
//         onEvent: (PusherEvent event) async {
//           if (event.data == null) return;
//           Map<String, dynamic>? dataMap;
//           try {
//             final raw =
//                 event.data is String ? json.decode(event.data) : event.data;
//             if (raw is Map<String, dynamic>) dataMap = raw;
//           } catch (_) {}
//           if (dataMap == null) return;

//           if (dataMap['services'] != null && dataMap['services'] is List) {
//             final updatedList =
//                 (dataMap['services'] as List)
//                     .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
//                     .toList();

//             setState(() {
//               futureServices = Future.value(updatedList);
//             });

//             await HiveService.saveServices(updatedList);
//           } else if (event.channelName == 'admin-clear-channel' &&
//               event.eventName == 'clear-table') {
//             if (dataMap['orgId'] == widget.orgid) {
//               await _clearLocalCache();
//             }
//           }
//         },
//       );

//       await _pusher.connect();
//       await _pusher.subscribe(channelName: 'table-updates-channel');
//       await _pusher.subscribe(channelName: 'admin-clear-channel');
//     } catch (e) {
//       debugPrint('Socket init error: $e');
//     }
//   }

//   Future<void> _clearLocalCache() async {
//     try {
//       await HiveService.clearServices();
//       final metaBox = await Hive.openBox('metaBox');
//       await metaBox.clear();
//       setState(() {
//         futureServices = Future.value([]);
//       });
//     } catch (e) {
//       debugPrint("Clear cache failed: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _pusher.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hidePopupTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       kIsWeb
//           ? 'https://cors-anywhere.herokuapp.com/https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra'
//           : 'https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     final body = {
//       'userid': widget.userid.toString(),
//       'orgid': widget.orgid.toString(),
//       'org_code': widget.orgCode,
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: body,
//       );

//       debugPrint('Request body: $body');
//       debugPrint('Response status: ${response.statusCode}');
//       debugPrint('Response body: ${response.body}');

//       final decoded = jsonDecode(response.body);

//       List<dynamic> serviceList;

//       // handle new API wrapping
//       if (decoded['data'] != null && decoded['data'] is List) {
//         serviceList = decoded['data'];
//       } else if (decoded['payload']?['services'] != null &&
//           decoded['payload']['services'] is List) {
//         serviceList = decoded['payload']['services'];
//       } else {
//         serviceList = [];
//       }

//       final services = serviceList.map((e) => Service.fromJson(e)).toList();

//       await HiveService.saveServices(services);
//       return services;
//     } catch (e) {
//       debugPrint('Fetch error: $e');
//       return [];
//     }
//   }

//   void _startAutoScroll() {
//     const speed = 20.0;
//     const tick = Duration(milliseconds: 50);
//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;
//       final max = _verticalController.position.maxScrollExtent;
//       if (max <= 0) return;
//       final current = _verticalController.offset;
//       final inc = speed * tick.inMilliseconds / 1000.0;
//       if (current + inc >= max) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + inc);
//       }
//     });
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     _hidePopupTimer?.cancel();
//     _hidePopupTimer = Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleStarKey() {
//     if (_selectedService != null) setState(() => _selectedService = null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final tableWidth = width * (isPortrait ? 1.2 : 1.4);

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (event) {
//         if (event.logicalKey.keyLabel == '*') {
//           _handleStarKey();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   snapshot.error.toString(),
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 16, color: Colors.red),
//                 ),
//               );
//             }

//             final services = snapshot.data ?? [];
//             if (services.isEmpty) {
//               return const Center(child: Text('डेटा उपलब्ध छैन।'));
//             }

//             final filtered =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where((s) => s.code.trim() == widget.searchCode.trim())
//                         .toList();

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SizedBox(
//                 width: tableWidth,
//                 child: Column(
//                   children:
//                       filtered.map((service) {
//                         final idx = filtered.indexOf(service);
//                         final isEven = idx % 2 == 0;
//                         final bg =
//                             isEven
//                                 ? const Color(0xFFF9D7D7)
//                                 : const Color(0xFF006699);
//                         final textColor =
//                             isEven ? const Color(0xFF006699) : Colors.white;

//                         return InkWell(
//                           onTap: () {
//                             _showFullScreen(service);
//                             widget.onCodeTap?.call(service);
//                           },
//                           child: Container(
//                             color: bg,
//                             padding: const EdgeInsets.all(8),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     service.code,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 10,
//                                   child: Text(
//                                     service.serviceTypeName,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 12,
//                                   child: Text(
//                                     service.serviceRecDetail,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 6,
//                                   child: Text(
//                                     service.fee,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 6,
//                                   child: Text(
//                                     service.time,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 10,
//                                   child: Text(
//                                     service.serviceProvider,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 10,
//                                   child: Text(
//                                     service.complainListen,
//                                     style: TextStyle(color: textColor),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//2051:

// //table data: table header fetched :
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const WaraBadapatraTable({
//     Key? key,
//     this.searchCode = "",
//     this.onCodeTap,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   _WaraBadapatraTableState createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices = Future.value([]);
//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;
//   Timer? _hidePopupTimer;

//   Service? _selectedService;
//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   final List<Map<String, String>> headers = [
//     {'key': 'col1', 'title': "क्र.स"},
//     {'key': 'col2', 'title': "सावधानीक उत्तरदायित्व तथा जवाफदेहीता"},
//     {'key': 'col3', 'title': "सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण"},
//     {'key': 'col4', 'title': "लैङ्गिक समानता तथा सामाजिक समावेशीकरण"},
//     {'key': 'col5', 'title': "स्थानीय तह सञ्चालन तथा व्यवस्थापन"},
//     {'key': 'col6', 'title': "सूचनाको हक"},
//     {'key': 'col7', 'title': "सुशासन र सदाचार"},
//   ];

//   int _getFlex(String key) {
//     switch (key) {
//       case 'col1':
//         return 2;
//       case 'col2':
//         return 10;
//       case 'col3':
//         return 12;
//       case 'col4':
//         return 6;
//       case 'col5':
//         return 6;
//       case 'col6':
//         return 10;
//       case 'col7':
//         return 10;
//       default:
//         return 6;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _clearLocalCache().then((_) {
//       futureServices = _fetchWaraBadapatra();
//       setState(() {});
//     });
//     _initSocketListener();

//     // Sync horizontal scrolls
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients &&
//           _horizontalHeaderController.offset !=
//               _horizontalBodyController.offset) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });
//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients &&
//           _horizontalBodyController.offset !=
//               _horizontalHeaderController.offset) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   Future<void> _initSocketListener() async {
//     try {
//       await _pusher.init(
//         apiKey: 'f5e0f21674d914753049',
//         cluster: 'ap2',
//         onEvent: (PusherEvent event) async {
//           if (event.data == null) return;
//           Map<String, dynamic>? dataMap;
//           try {
//             final raw =
//                 event.data is String ? json.decode(event.data) : event.data;
//             if (raw is Map<String, dynamic>) dataMap = raw;
//           } catch (_) {}
//           if (dataMap == null) return;

//           if (dataMap['services'] != null && dataMap['services'] is List) {
//             final updatedList =
//                 (dataMap['services'] as List)
//                     .map((e) => Service.fromJson(Map<String, dynamic>.from(e)))
//                     .toList();

//             setState(() {
//               futureServices = Future.value(updatedList);
//             });

//             await HiveService.saveServices(updatedList);
//           } else if (event.channelName == 'admin-clear-channel' &&
//               event.eventName == 'clear-table') {
//             if (dataMap['orgId'] == widget.orgid) {
//               await _clearLocalCache();
//             }
//           }
//         },
//       );

//       await _pusher.connect();
//       await _pusher.subscribe(channelName: 'table-updates-channel');
//       await _pusher.subscribe(channelName: 'admin-clear-channel');
//     } catch (e) {
//       debugPrint('Socket init error: $e');
//     }
//   }

//   Future<void> _clearLocalCache() async {
//     try {
//       await HiveService.clearServices();
//       final metaBox = await Hive.openBox('metaBox');
//       await metaBox.clear();
//       setState(() {
//         futureServices = Future.value([]);
//       });
//     } catch (e) {
//       debugPrint("Clear cache failed: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _pusher.disconnect();
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     _hidePopupTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       kIsWeb
//           ? 'https://cors-anywhere.herokuapp.com/https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra'
//           : 'https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     final body = {
//       'userid': widget.userid.toString(),
//       'orgid': widget.orgid.toString(),
//       'org_code': widget.orgCode,
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: body,
//       );

//       debugPrint('Request body: $body');
//       debugPrint('Response status: ${response.statusCode}');
//       debugPrint('Response body: ${response.body}');

//       final decoded = jsonDecode(response.body);

//       List<dynamic> serviceList;

//       // handle new API wrapping
//       if (decoded['data'] != null && decoded['data'] is List) {
//         serviceList = decoded['data'];
//       } else if (decoded['payload']?['services'] != null &&
//           decoded['payload']['services'] is List) {
//         serviceList = decoded['payload']['services'];
//       } else {
//         serviceList = [];
//       }

//       final services = serviceList.map((e) => Service.fromJson(e)).toList();

//       await HiveService.saveServices(services);
//       return services;
//     } catch (e) {
//       debugPrint('Fetch error: $e');
//       return [];
//     }
//   }

//   void _startAutoScroll() {
//     const speed = 20.0;
//     const tick = Duration(milliseconds: 50);
//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = Timer.periodic(tick, (_) {
//       if (!_verticalController.hasClients) return;
//       final max = _verticalController.position.maxScrollExtent;
//       if (max <= 0) return;
//       final current = _verticalController.offset;
//       final inc = speed * tick.inMilliseconds / 1000.0;
//       if (current + inc >= max) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.jumpTo(current + inc);
//       }
//     });
//   }

//   void _showFullScreen(Service service) {
//     setState(() => _selectedService = service);
//     _hidePopupTimer?.cancel();
//     _hidePopupTimer = Timer(const Duration(seconds: 10), () {
//       if (mounted) setState(() => _selectedService = null);
//     });
//   }

//   void _handleStarKey() {
//     if (_selectedService != null) setState(() => _selectedService = null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final tableWidth = width * (isPortrait ? 1.2 : 1.4);

//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       autofocus: true,
//       onKey: (event) {
//         if (event.logicalKey.keyLabel == '*') {
//           _handleStarKey();
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: FutureBuilder<List<Service>>(
//           future: futureServices,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   snapshot.error.toString(),
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 16, color: Colors.red),
//                 ),
//               );
//             }

//             final services = snapshot.data ?? [];
//             if (services.isEmpty) {
//               return const Center(child: Text('डेटा उपलब्ध छैन।'));
//             }

//             final filtered =
//                 widget.searchCode.isEmpty
//                     ? services
//                     : services
//                         .where((s) => s.code.trim() == widget.searchCode.trim())
//                         .toList();

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (_autoScrollTimer == null) _startAutoScroll();
//             });

//             return Column(
//               children: [
//                 // Header row
//                 SingleChildScrollView(
//                   controller: _horizontalHeaderController,
//                   scrollDirection: Axis.horizontal,
//                   child: Container(
//                     width: tableWidth,
//                     color: Colors.blueGrey,
//                     child: Row(
//                       children:
//                           headers.map((h) {
//                             return Expanded(
//                               flex: _getFlex(h['key']!),
//                               child: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   h['title']!,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                     ),
//                   ),
//                 ),

//                 // Table body
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.7,
//                   child: SingleChildScrollView(
//                     controller: _verticalController,
//                     child: SingleChildScrollView(
//                       controller: _horizontalBodyController,
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: tableWidth,
//                         child: Column(
//                           children:
//                               filtered.map((service) {
//                                 final idx = filtered.indexOf(service);
//                                 final isEven = idx % 2 == 0;
//                                 final bg =
//                                     isEven
//                                         ? const Color(0xFFF9D7D7)
//                                         : const Color(0xFF006699);
//                                 final textColor =
//                                     isEven
//                                         ? const Color(0xFF006699)
//                                         : Colors.white;

//                                 return InkWell(
//                                   onTap: () {
//                                     _showFullScreen(service);
//                                     widget.onCodeTap?.call(service);
//                                   },
//                                   child: Container(
//                                     color: bg,
//                                     padding: const EdgeInsets.all(8),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           flex: 2,
//                                           child: Text(
//                                             service.code,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 10,
//                                           child: Text(
//                                             service.serviceTypeName,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 12,
//                                           child: Text(
//                                             service.serviceRecDetail,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 6,
//                                           child: Text(
//                                             service.fee,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 6,
//                                           child: Text(
//                                             service.time,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 10,
//                                           child: Text(
//                                             service.serviceProvider,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 10,
//                                           child: Text(
//                                             service.complainListen,
//                                             style: TextStyle(color: textColor),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//AAZZ

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const WaraBadapatraTable({
//     Key? key,
//     this.searchCode = "",
//     this.onCodeTap,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   State<WaraBadapatraTable> createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;
//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalHeaderController = ScrollController();
//   final ScrollController _horizontalBodyController = ScrollController();
//   Timer? _autoScrollTimer;
//   Service? _selectedService;

//   final List<String> headerTitles = [
//     "क्र.स",
//     "सावधानीक उत्तरदायित्व तथा जवाफदेहीता",
//     "सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण",
//     "लैङ्गिक समानता तथा सामाजिक समावेशीकरण",
//     "स्थानीय तह सञ्चालन तथा व्यवस्थापन",
//     "सूचनाको हक",
//     "सुशासन र सदाचार",
//   ];

//   final List<int> flexValues = [2, 10, 12, 6, 6, 10, 10];

//   @override
//   void initState() {
//     super.initState();
//     futureServices = _fetchWaraBadapatra();
//     _syncHorizontalScroll();
//   }

//   void _syncHorizontalScroll() {
//     _horizontalBodyController.addListener(() {
//       if (_horizontalHeaderController.hasClients) {
//         _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
//       }
//     });
//     _horizontalHeaderController.addListener(() {
//       if (_horizontalBodyController.hasClients) {
//         _horizontalBodyController.jumpTo(_horizontalHeaderController.offset);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalHeaderController.dispose();
//     _horizontalBodyController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       kIsWeb
//           ? 'https://cors-anywhere.herokuapp.com/https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra'
//           : 'https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     final body = {
//       'userid': widget.userid,
//       'orgid': widget.orgid,
//       'org_code': widget.orgCode,
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: body,
//       );
//       final decoded = jsonDecode(response.body);
//       final list = decoded['data'] ?? decoded['payload']?['services'] ?? [];
//       final services = (list as List).map((e) => Service.fromJson(e)).toList();
//       await HiveService.saveServices(services);
//       return services;
//     } catch (e) {
//       return [];
//     }
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer?.cancel();
//     const speed = 20.0;
//     const duration = Duration(milliseconds: 80);
//     _autoScrollTimer = Timer.periodic(duration, (_) {
//       if (!_verticalController.hasClients) return;
//       final pos = _verticalController.position;
//       if (pos.maxScrollExtent <= 0) return;
//       final next = (pos.pixels + speed).clamp(0.0, pos.maxScrollExtent);
//       if (next >= pos.maxScrollExtent - 1) {
//         _verticalController.jumpTo(0);
//       } else {
//         _verticalController.animateTo(
//           next,
//           duration: duration,
//           curve: Curves.linear,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final tableWidth =
//         MediaQuery.of(context).size.width * (isPortrait ? 1.2 : 1.4);
//     final headerHeight = isPortrait ? 90.0 : 70.0;

//     return FutureBuilder<List<Service>>(
//       future: futureServices,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text('डेटा उपलब्ध छैन।', style: TextStyle(fontSize: 28)),
//           );
//         }

//         final filtered =
//             widget.searchCode.isEmpty
//                 ? snapshot.data!
//                 : snapshot.data!
//                     .where((s) => s.code.trim() == widget.searchCode.trim())
//                     .toList();

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (_autoScrollTimer == null && filtered.length > 2)
//             _startAutoScroll();
//         });

//         return Column(
//           children: [
//             // RED STICKY HEADER
//             Container(
//               height: headerHeight,
//               color: const Color(0xFFC40000),
//               child: SingleChildScrollView(
//                 controller: _horizontalHeaderController,
//                 scrollDirection: Axis.horizontal,
//                 child: SizedBox(
//                   width: tableWidth,
//                   child: Row(
//                     children:
//                         headerTitles.asMap().entries.map((e) {
//                           final i = e.key;
//                           return Expanded(
//                             flex: flexValues[i],
//                             child: Container(
//                               color:
//                                   i % 2 == 0
//                                       ? const Color(0xFFC40000)
//                                       : const Color(0xFFE45C53),
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.all(8),
//                               child: Text(
//                                 e.value,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 softWrap: true,
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                   ),
//                 ),
//               ),
//             ),

//             // BODY
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _verticalController,
//                 child: SingleChildScrollView(
//                   controller: _horizontalBodyController,
//                   scrollDirection: Axis.horizontal,
//                   child: SizedBox(
//                     width: tableWidth,
//                     child: Column(
//                       children:
//                           filtered.map((service) {
//                             final index = filtered.indexOf(service);
//                             final isEven = index % 2 == 0;
//                             final bg =
//                                 isEven
//                                     ? const Color(0xFFF9D7D7)
//                                     : const Color(0xFF006699);
//                             final textColor =
//                                 isEven ? const Color(0xFF006699) : Colors.white;

//                             return InkWell(
//                               onTap: () => widget.onCodeTap?.call(service),
//                               child: Container(
//                                 color: bg,
//                                 padding: const EdgeInsets.all(14),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         service.code,
//                                         style: TextStyle(
//                                           color: textColor,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 10,
//                                       child: Text(
//                                         service.serviceTypeName,
//                                         style: TextStyle(color: textColor),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 12,
//                                       child: Text(
//                                         service.serviceRecDetail,
//                                         style: TextStyle(color: textColor),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 6,
//                                       child: Text(
//                                         service.fee,
//                                         style: TextStyle(color: textColor),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 6,
//                                       child: Text(
//                                         service.time,
//                                         style: TextStyle(color: textColor),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 10,
//                                       child: Text(
//                                         service.serviceProvider,
//                                         style: TextStyle(color: textColor),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 10,
//                                       child: Text(
//                                         service.complainListen,
//                                         style: TextStyle(color: textColor),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

//1234: noo smooth scroll

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const WaraBadapatraTable({
//     Key? key,
//     this.searchCode = "",
//     this.onCodeTap,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   State<WaraBadapatraTable> createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;
//   final ScrollController _hController = ScrollController();
//   final ScrollController _vController = ScrollController();
//   Timer? _autoScrollTimer;

//   final List<String> headerTitles = [
//     "क्र.स",
//     "सावधानीक उत्तरदायित्व तथा जवाफदेहीता",
//     "सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण",
//     "लैङ्गिक समानता तथा सामाजिक समावेशीकरण",
//     "स्थानीय तह सञ्चालन तथा व्यवस्थापन",
//     "सूचनाको हक",
//     "सुशासन र सदाचार",
//   ];

//   // Slightly reduced widths to avoid overflow
//   final List<double> columnWidthsPortrait = [80, 255, 355, 235, 215, 235, 255];
//   final List<double> columnWidthsLandscape = [70, 235, 335, 215, 195, 215, 235];

//   @override
//   void initState() {
//     super.initState();
//     futureServices = _fetchWaraBadapatra();
//   }

//   @override
//   void dispose() {
//     _hController.dispose();
//     _vController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       kIsWeb
//           ? 'https://cors-anywhere.herokuapp.com/https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra'
//           : 'https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//         final list = decoded['data'] ?? [];
//         final services =
//             (list as List).map((e) => Service.fromJson(e)).toList();
//         await HiveService.saveServices(services);
//         return services;
//       }
//     } catch (e) {
//       debugPrint("Fetch error: $e");
//     }
//     return await HiveService.getServices();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer?.cancel();
//     const speed = 0.9;
//     _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
//       if (!_vController.hasClients) return;
//       final pos = _vController.position;
//       if (pos.pixels >= pos.maxScrollExtent - 1) {
//         _vController.jumpTo(0);
//       } else {
//         _vController.animateTo(
//           pos.pixels + speed,
//           duration: const Duration(milliseconds: 50),
//           curve: Curves.linear,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final columnWidths =
//         isPortrait ? columnWidthsPortrait : columnWidthsLandscape;

//     return FutureBuilder<List<Service>>(
//       future: futureServices,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text('डेटा उपलब्ध छैन।', style: TextStyle(fontSize: 28)),
//           );
//         }

//         final filtered =
//             widget.searchCode.isEmpty
//                 ? snapshot.data!
//                 : snapshot.data!
//                     .where((s) => s.code.trim() == widget.searchCode.trim())
//                     .toList();

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (_autoScrollTimer == null && filtered.length > 2) {
//             _startAutoScroll();
//           }
//         });

//         // MAIN CONTAINER — full width, no overflow
//         return Column(
//           children: [
//             // RED HEADER — sticky + synced
//             Container(
//               height: isPortrait ? 58 : 52,
//               color: const Color(0xFFC40000),
//               child: NotificationListener<ScrollNotification>(
//                 onNotification: (notification) {
//                   if (notification is ScrollUpdateNotification) {
//                     _hController.jumpTo(notification.metrics.pixels);
//                   }
//                   return false;
//                 },
//                 child: SingleChildScrollView(
//                   controller: _hController,
//                   scrollDirection: Axis.horizontal,
//                   physics: const ClampingScrollPhysics(),
//                   child: Row(
//                     children: List.generate(headerTitles.length, (i) {
//                       return Container(
//                         width: columnWidths[i],
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         color:
//                             i.isEven
//                                 ? const Color(0xFFE45C53)
//                                 : const Color(0xFFC40000),
//                         child: Text(
//                           headerTitles[i],
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                           textAlign: TextAlign.center,
//                           softWrap: true,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),

//             // BODY — full width, perfect sync with header
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _vController,
//                 child: NotificationListener<ScrollNotification>(
//                   onNotification: (notification) {
//                     if (notification is ScrollUpdateNotification) {
//                       _hController.jumpTo(notification.metrics.pixels);
//                     }
//                     return false;
//                   },
//                   child: SingleChildScrollView(
//                     controller: _hController,
//                     scrollDirection: Axis.horizontal,
//                     physics: const ClampingScrollPhysics(),
//                     child: Column(
//                       children:
//                           filtered.asMap().entries.map((e) {
//                             final service = e.value;
//                             final index = e.key;
//                             final isEven = index % 2 == 0;
//                             final bg =
//                                 isEven
//                                     ? const Color(0xFFF9D7D7)
//                                     : const Color(0xFF006699);
//                             final textColor =
//                                 isEven ? const Color(0xFF006699) : Colors.white;

//                             return InkWell(
//                               onTap: () => widget.onCodeTap?.call(service),
//                               child: Container(
//                                 color: bg,
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 15,
//                                   horizontal: 8,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     _cell(
//                                       columnWidths[0],
//                                       service.code,
//                                       textColor,
//                                       bold: true,
//                                     ),
//                                     _cell(
//                                       columnWidths[1],
//                                       service.serviceTypeName ?? '',
//                                       textColor,
//                                     ),
//                                     _cell(
//                                       columnWidths[2],
//                                       service.serviceRecDetail ?? '',
//                                       textColor,
//                                     ),
//                                     _cell(
//                                       columnWidths[3],
//                                       service.fee ?? '',
//                                       textColor,
//                                     ),
//                                     _cell(
//                                       columnWidths[4],
//                                       service.time ?? '',
//                                       textColor,
//                                     ),
//                                     _cell(
//                                       columnWidths[5],
//                                       service.serviceProvider ?? '',
//                                       textColor,
//                                     ),
//                                     _cell(
//                                       columnWidths[6],
//                                       service.complainListen ?? '',
//                                       textColor,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _cell(double width, String text, Color color, {bool bold = false}) {
//     return SizedBox(
//       width: width,
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 13.8,
//           height: 1.5,
//           fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//         ),
//         softWrap: true,
//         overflow: TextOverflow.visible,
//       ),
//     );
//   }
// }

//working:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const WaraBadapatraTable({
//     Key? key,
//     this.searchCode = "",
//     this.onCodeTap,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   State<WaraBadapatraTable> createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;
//   final ScrollController _headerController = ScrollController();
//   final ScrollController _bodyController = ScrollController();
//   final ScrollController _vController = ScrollController();
//   Timer? _autoScrollTimer;

//   // Flag to prevent infinite loop of scroll notifications
//   bool _isSyncingScroll = false;

//   final List<String> headerTitles = [
//     "क्र.स",
//     "सावधानीक उत्तरदायित्व तथा जवाफदेहीता",
//     "सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण",
//     "लैङ्गिक समानता तथा सामाजिक समावेशीकरण",
//     "स्थानीय तह सञ्चालन तथा व्यवस्थापन",
//     "सूचनाको हक",
//     "सुशासन र सदाचार",
//   ];

//   // MUST MATCH CustomSearchBar column widths
//   final List<double> columnWidthsPortrait = [80, 255, 355, 235, 215, 235, 255];
//   final List<double> columnWidthsLandscape = [70, 235, 335, 215, 195, 215, 235];

//   @override
//   void initState() {
//     super.initState();
//     futureServices = _fetchWaraBadapatra();

//     // Add listeners for smooth syncing
//     _headerController.addListener(_onHeaderScroll);
//     _bodyController.addListener(_onBodyScroll);
//   }

//   @override
//   void dispose() {
//     _headerController.removeListener(_onHeaderScroll);
//     _bodyController.removeListener(_onBodyScroll);
//     _headerController.dispose();
//     _bodyController.dispose();
//     _vController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   void _onHeaderScroll() {
//     if (_isSyncingScroll) return;
//     _isSyncingScroll = true;
//     if (_bodyController.hasClients) {
//       _bodyController.jumpTo(_headerController.offset);
//     }
//     _isSyncingScroll = false;
//   }

//   void _onBodyScroll() {
//     if (_isSyncingScroll) return;
//     _isSyncingScroll = true;
//     if (_headerController.hasClients) {
//       _headerController.jumpTo(_bodyController.offset);
//     }
//     _isSyncingScroll = false;
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       kIsWeb
//           ? 'https://cors-anywhere.herokuapp.com/https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra'
//           : 'https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//         final list = decoded['data'] ?? [];
//         final services =
//             (list as List).map((e) => Service.fromJson(e)).toList();
//         await HiveService.saveServices(services);
//         return services;
//       }
//     } catch (e) {
//       debugPrint("Fetch error: $e");
//     }
//     return await HiveService.getServices();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer?.cancel();
//     const speed = 0.9;
//     _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
//       if (!_vController.hasClients) return;
//       final pos = _vController.position;
//       if (pos.pixels >= pos.maxScrollExtent - 1) {
//         _vController.jumpTo(0);
//       } else {
//         _vController.animateTo(
//           pos.pixels + speed,
//           duration: const Duration(milliseconds: 50),
//           curve: Curves.linear,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final columnWidths =
//         isPortrait ? columnWidthsPortrait : columnWidthsLandscape;

//     return FutureBuilder<List<Service>>(
//       future: futureServices,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text('डेटा उपलब्ध छैन।', style: TextStyle(fontSize: 28)),
//           );
//         }

//         final filtered =
//             widget.searchCode.isEmpty
//                 ? snapshot.data!
//                 : snapshot.data!
//                     .where((s) => s.code.trim() == widget.searchCode.trim())
//                     .toList();

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (_autoScrollTimer == null && filtered.length > 2) {
//             _startAutoScroll();
//           }
//         });

//         return Column(
//           children: [
//             // RED HEADER — sticky + smoothly synced
//             Container(
//               height: isPortrait ? 58 : 52,
//               color: const Color(0xFFC40000),
//               child: SingleChildScrollView(
//                 controller: _headerController,
//                 scrollDirection: Axis.horizontal,
//                 physics: const ClampingScrollPhysics(),
//                 child: Row(
//                   children: List.generate(headerTitles.length, (i) {
//                     return Container(
//                       width: columnWidths[i],
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       color:
//                           i.isEven
//                               ? const Color(0xFFE45C53)
//                               : const Color(0xFFC40000),
//                       child: Text(
//                         headerTitles[i],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                         textAlign: TextAlign.center,
//                         softWrap: true,
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),

//             // BODY — smoothly synced with header
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _vController,
//                 child: SingleChildScrollView(
//                   controller: _bodyController,
//                   scrollDirection: Axis.horizontal,
//                   physics: const ClampingScrollPhysics(),
//                   child: Column(
//                     children:
//                         filtered.asMap().entries.map((e) {
//                           final service = e.value;
//                           final index = e.key;
//                           final isEven = index % 2 == 0;
//                           final bg =
//                               isEven
//                                   ? const Color(0xFFF9D7D7)
//                                   : const Color(0xFF006699);
//                           final textColor =
//                               isEven ? const Color(0xFF006699) : Colors.white;

//                           return InkWell(
//                             onTap: () => widget.onCodeTap?.call(service),
//                             child: Container(
//                               color: bg,
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 15,
//                                 horizontal: 8,
//                               ),
//                               child: Row(
//                                 children: [
//                                   _cell(
//                                     columnWidths[0],
//                                     service.code,
//                                     textColor,
//                                     bold: true,
//                                   ),
//                                   _cell(
//                                     columnWidths[1],
//                                     service.serviceTypeName ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[2],
//                                     service.serviceRecDetail ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[3],
//                                     service.fee ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[4],
//                                     service.time ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[5],
//                                     service.serviceProvider ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[6],
//                                     service.complainListen ?? '',
//                                     textColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _cell(double width, String text, Color color, {bool bold = false}) {
//     return SizedBox(
//       width: width,
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 13.8,
//           height: 1.5,
//           fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//         ),
//         softWrap: true,
//         overflow: TextOverflow.visible,
//       ),
//     );
//   }
// }

//landscape layout correcting:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/service.dart';
// import 'services/hive_service.dart';

// class WaraBadapatraTable extends StatefulWidget {
//   final String searchCode;
//   final Function(Service)? onCodeTap;
//   final String userid;
//   final String orgid;
//   final String orgCode;

//   const WaraBadapatraTable({
//     Key? key,
//     this.searchCode = "",
//     this.onCodeTap,
//     required this.userid,
//     required this.orgid,
//     required this.orgCode,
//   }) : super(key: key);

//   @override
//   State<WaraBadapatraTable> createState() => _WaraBadapatraTableState();
// }

// class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
//   late Future<List<Service>> futureServices;
//   final ScrollController _headerController = ScrollController();
//   final ScrollController _bodyController = ScrollController();
//   final ScrollController _vController = ScrollController();
//   Timer? _autoScrollTimer;

//   // Flag to prevent infinite loop of scroll notifications
//   bool _isSyncingScroll = false;

//   final List<String> headerTitles = [
//     "क्र.स",
//     "सावधानीक उत्तरदायित्व तथा जवाफदेहीता",
//     "सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण",
//     "लैङ्गिक समानता तथा सामाजिक समावेशीकरण",
//     "स्थानीय तह सञ्चालन तथा व्यवस्थापन",
//     "सूचनाको हक",
//     "सुशासन र सदाचार",
//   ];

//   // MUST MATCH CustomSearchBar column widths
//   final List<double> columnWidthsPortrait = [80, 255, 355, 235, 215, 235, 255];
//   final List<double> columnWidthsLandscape = [70, 235, 335, 215, 195, 215, 235];

//   @override
//   void initState() {
//     super.initState();
//     futureServices = _fetchWaraBadapatra();

//     // Add listeners for smooth syncing
//     _headerController.addListener(_onHeaderScroll);
//     _bodyController.addListener(_onBodyScroll);
//   }

//   @override
//   void dispose() {
//     _headerController.removeListener(_onHeaderScroll);
//     _bodyController.removeListener(_onBodyScroll);
//     _headerController.dispose();
//     _bodyController.dispose();
//     _vController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   void _onHeaderScroll() {
//     if (_isSyncingScroll) return;
//     _isSyncingScroll = true;
//     if (_bodyController.hasClients) {
//       _bodyController.jumpTo(_headerController.offset);
//     }
//     _isSyncingScroll = false;
//   }

//   void _onBodyScroll() {
//     if (_isSyncingScroll) return;
//     _isSyncingScroll = true;
//     if (_headerController.hasClients) {
//       _headerController.jumpTo(_bodyController.offset);
//     }
//     _isSyncingScroll = false;
//   }

//   Future<List<Service>> _fetchWaraBadapatra() async {
//     final url = Uri.parse(
//       kIsWeb
//           ? 'https://cors-anywhere.herokuapp.com/https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra'
//           : 'https://sprta.digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {
//           'userid': widget.userid,
//           'orgid': widget.orgid,
//           'org_code': widget.orgCode,
//         },
//       );

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//         final list = decoded['data'] ?? [];
//         final services =
//             (list as List).map((e) => Service.fromJson(e)).toList();
//         await HiveService.saveServices(services);
//         return services;
//       }
//     } catch (e) {
//       debugPrint("Fetch error: $e");
//     }
//     return await HiveService.getServices();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer?.cancel();
//     const speed = 0.9;
//     _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
//       if (!_vController.hasClients) return;
//       final pos = _vController.position;
//       if (pos.pixels >= pos.maxScrollExtent - 1) {
//         _vController.jumpTo(0);
//       } else {
//         _vController.animateTo(
//           pos.pixels + speed,
//           duration: const Duration(milliseconds: 50),
//           curve: Curves.linear,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     final columnWidths =
//         isPortrait ? columnWidthsPortrait : columnWidthsLandscape;

//     return FutureBuilder<List<Service>>(
//       future: futureServices,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text('डेटा उपलब्ध छैन।', style: TextStyle(fontSize: 28)),
//           );
//         }

//         final filtered =
//             widget.searchCode.isEmpty
//                 ? snapshot.data!
//                 : snapshot.data!
//                     .where((s) => s.code.trim() == widget.searchCode.trim())
//                     .toList();

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (_autoScrollTimer == null && filtered.length > 2) {
//             _startAutoScroll();
//           }
//         });

//         return Column(
//           children: [
//             // RED HEADER — sticky + smoothly synced
//             Container(
//               height: isPortrait ? 58 : 52,
//               color: const Color(0xFFC40000),
//               child: SingleChildScrollView(
//                 controller: _headerController,
//                 scrollDirection: Axis.horizontal,
//                 physics: const ClampingScrollPhysics(),
//                 child: Row(
//                   children: List.generate(headerTitles.length, (i) {
//                     return Container(
//                       width: columnWidths[i],
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       color:
//                           i.isEven
//                               ? const Color(0xFFE45C53)
//                               : const Color(0xFFC40000),
//                       child: Text(
//                         headerTitles[i],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                         textAlign: TextAlign.center,
//                         softWrap: true,
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),

//             // BODY — smoothly synced with header
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _vController,
//                 child: SingleChildScrollView(
//                   controller: _bodyController,
//                   scrollDirection: Axis.horizontal,
//                   physics: const ClampingScrollPhysics(),
//                   child: Column(
//                     children:
//                         filtered.asMap().entries.map((e) {
//                           final service = e.value;
//                           final index = e.key;
//                           final isEven = index % 2 == 0;
//                           final bg =
//                               isEven
//                                   ? const Color(0xFFF9D7D7)
//                                   : const Color(0xFF006699);
//                           final textColor =
//                               isEven ? const Color(0xFF006699) : Colors.white;

//                           return InkWell(
//                             onTap: () => widget.onCodeTap?.call(service),
//                             child: Container(
//                               color: bg,
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 15,
//                                 horizontal: 8,
//                               ),
//                               child: Row(
//                                 children: [
//                                   _cell(
//                                     columnWidths[0],
//                                     service.code,
//                                     textColor,
//                                     bold: true,
//                                   ),
//                                   _cell(
//                                     columnWidths[1],
//                                     service.serviceTypeName ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[2],
//                                     service.serviceRecDetail ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[3],
//                                     service.fee ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[4],
//                                     service.time ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[5],
//                                     service.serviceProvider ?? '',
//                                     textColor,
//                                   ),
//                                   _cell(
//                                     columnWidths[6],
//                                     service.complainListen ?? '',
//                                     textColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _cell(double width, String text, Color color, {bool bold = false}) {
//     return SizedBox(
//       width: width,
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 13.8,
//           height: 1.5,
//           fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//         ),
//         softWrap: true,
//         overflow: TextOverflow.visible,
//       ),
//     );
//   }
// }

//#####################################################################################################//

//RAMPUR:
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'models/service.dart';
import 'services/hive_service.dart';

class WaraBadapatraTable extends StatefulWidget {
  final String searchCode;
  final Function(Service)? onCodeTap;
  final String userid;
  final String orgid;
  final String orgCode;

  const WaraBadapatraTable({
    Key? key,
    this.searchCode = "",
    this.onCodeTap,
    required this.userid,
    required this.orgid,
    required this.orgCode,
  }) : super(key: key);

  @override
  State<WaraBadapatraTable> createState() => _WaraBadapatraTableState();
}

class _WaraBadapatraTableState extends State<WaraBadapatraTable> {
  late Future<List<Service>> futureServices;
  final ScrollController _headerController = ScrollController();
  final ScrollController _bodyController = ScrollController();
  final ScrollController _vController = ScrollController();
  Timer? _autoScrollTimer;

  bool _isSyncingScroll = false;

  final List<String> headerTitles = [
    "क्र.स",
    "सावधानीक उत्तरदायित्व तथा जवाफदेहीता",
    "सेवा प्राप्त गर्न पेश गर्नुपर्ने बिबरण",
    "लैङ्गिक समानता तथा सामाजिक समावेशीकरण",
    "स्थानीय तह सञ्चालन तथा व्यवस्थापन",
    "सूचनाको हक",
    "सुशासन र सदाचार",
  ];

  final List<double> columnWidthsPortrait = [80, 255, 355, 235, 215, 235, 255];
  final List<double> columnWidthsLandscape = [70, 235, 335, 215, 195, 215, 235];

  @override
  void initState() {
    super.initState();
    futureServices = _fetchWaraBadapatra();

    _headerController.addListener(_onHeaderScroll);
    _bodyController.addListener(_onBodyScroll);
  }

  @override
  void dispose() {
    _headerController.removeListener(_onHeaderScroll);
    _bodyController.removeListener(_onBodyScroll);
    _headerController.dispose();
    _bodyController.dispose();
    _vController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _onHeaderScroll() {
    if (_isSyncingScroll) return;
    _isSyncingScroll = true;
    if (_bodyController.hasClients) {
      _bodyController.jumpTo(_headerController.offset);
    }
    _isSyncingScroll = false;
  }

  void _onBodyScroll() {
    if (_isSyncingScroll) return;
    _isSyncingScroll = true;
    if (_headerController.hasClients) {
      _headerController.jumpTo(_bodyController.offset);
    }
    _isSyncingScroll = false;
  }

  Future<List<Service>> _fetchWaraBadapatra() async {
    // ✅ NEW API ENDPOINT
    final url = Uri.parse(
      kIsWeb
          ? 'https://cors-anywhere.herokuapp.com/https://digitalbadapatra.com/api/v1/get_wara_badapatra'
          : 'https://digitalbadapatra.com/api/v1/get_wara_badapatra',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'userid': widget.userid,
          'orgid': widget.orgid,
          'org_code': widget.orgCode,
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final list = decoded['data'] ?? [];
        final services =
            (list as List).map((e) => Service.fromJson(e)).toList();
        await HiveService.saveServices(services);
        return services;
      }
    } catch (e) {
      debugPrint("Fetch error: $e");
    }
    return await HiveService.getServices();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    const speed = 0.9;
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!_vController.hasClients) return;
      final pos = _vController.position;
      if (pos.pixels >= pos.maxScrollExtent - 1) {
        _vController.jumpTo(0);
      } else {
        _vController.animateTo(
          pos.pixels + speed,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final columnWidths =
        isPortrait ? columnWidthsPortrait : columnWidthsLandscape;

    return FutureBuilder<List<Service>>(
      future: futureServices,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('डेटा उपलब्ध छैन।', style: TextStyle(fontSize: 28)),
          );
        }

        final filtered =
            widget.searchCode.isEmpty
                ? snapshot.data!
                : snapshot.data!
                    .where((s) => s.code.trim() == widget.searchCode.trim())
                    .toList();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_autoScrollTimer == null && filtered.length > 2) {
            _startAutoScroll();
          }
        });

        return Column(
          children: [
            // RED HEADER
            Container(
              height: isPortrait ? 58 : 52,
              color: const Color(0xFFC40000),
              child: SingleChildScrollView(
                controller: _headerController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: Row(
                  children: List.generate(headerTitles.length, (i) {
                    return Container(
                      width: columnWidths[i],
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color:
                          i.isEven
                              ? const Color(0xFFE45C53)
                              : const Color(0xFFC40000),
                      child: Text(
                        headerTitles[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    );
                  }),
                ),
              ),
            ),

            // BODY
            Expanded(
              child: SingleChildScrollView(
                controller: _vController,
                child: SingleChildScrollView(
                  controller: _bodyController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children:
                        filtered.asMap().entries.map((e) {
                          final service = e.value;
                          final index = e.key;
                          final isEven = index % 2 == 0;
                          final bg =
                              isEven
                                  ? const Color(0xFFF9D7D7)
                                  : const Color(0xFF006699);
                          final textColor =
                              isEven ? const Color(0xFF006699) : Colors.white;

                          return InkWell(
                            onTap: () => widget.onCodeTap?.call(service),
                            child: Container(
                              color: bg,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 8,
                              ),
                              child: Row(
                                children: [
                                  _cell(
                                    columnWidths[0],
                                    service.code,
                                    textColor,
                                    bold: true,
                                  ),
                                  _cell(
                                    columnWidths[1],
                                    service.serviceTypeName ?? '',
                                    textColor,
                                  ),
                                  _cell(
                                    columnWidths[2],
                                    service.serviceRecDetail ?? '',
                                    textColor,
                                  ),
                                  _cell(
                                    columnWidths[3],
                                    service.fee ?? '',
                                    textColor,
                                  ),
                                  _cell(
                                    columnWidths[4],
                                    service.time ?? '',
                                    textColor,
                                  ),
                                  _cell(
                                    columnWidths[5],
                                    service.serviceProvider ?? '',
                                    textColor,
                                  ),
                                  _cell(
                                    columnWidths[6],
                                    service.complainListen ?? '',
                                    textColor,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _cell(double width, String text, Color color, {bool bold = false}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 13.8,
          height: 1.5,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
        softWrap: true,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
