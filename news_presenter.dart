// //DONE*
// // THIS IS NEWS TABLE PAGE WHICH RENDERS AFTER CLICKING GRID BUTTON PAGE
//ORIGINAL:

// import 'package:flutter/material.dart';

// class NewsPresenterPage extends StatelessWidget {
//   final int serialNumber;

//   const NewsPresenterPage({super.key, required this.serialNumber});

//   @override
//   Widget build(BuildContext context) {
//     final headers = [
//       'क्र.सं',
//       'सेवाको किसिम',
//       'सेवा प्राप्त गर्न पेश गर्नुपर्ने विवरण',
//       'लाग्ने शुल्क',
//       'लाग्ने समय',
//       'सेवा दिने शाखा',
//       'गुनासो सुन्ने अधिकारी',
//     ];

//     final data = [
//       [
//         '१',
//         'योजना कार्यान्वयन पश्चात भुक्तानी प्रक्रिया',
//         '''१) प्राविधिकबाट कार्य सम्पन्न प्रतिवेदन, अनुगमन, मूल्यांकन ।
// २) उ.स.को सार्वजनिक परीक्षण प्रतिवेदन ।
// ३) अनुगमन समितिको सिफारिश, कार्य सम्पन्न फोटो
// ४) सडकको ढल, भराइ, आवश्यक कागजात सहित वडाबाट भुक्तानीका लागि सिफारिश पश्चात नियमअनुसार गा.पा./टा.बाट भुक्तानी,
// बोलपत्र आह्वान गरी संचालन हुने आयोजना नियमअनुसार कार्यान्वयन हुने ।''',
//         'निःशुल्क',
//         'प्रक्रिया तथा प्रमाण पुगेपछि तत्काल',
//         'प्रमुख प्रशासनिक अधिकृत,\nयोजना शाखा, पूर्वाधार विकास शाखा',
//         '-',
//       ],
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF002D72),
//         title: Text(
//           'योजना कार्यान्वयन पश्चात भुक्तानी प्रक्रिया (S.N. $serialNumber)',
//           style: const TextStyle(color: Colors.white),
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.close, color: Colors.white),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: const Color(0xFFF3ECF3), // Page background
//         child: Scrollbar(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SizedBox(
//               width: 1600, // Adjusted total width to eliminate gap
//               child: SingleChildScrollView(
//                 child: Table(
//                   border: TableBorder.all(color: Colors.white, width: 1),
//                   columnWidths: const {
//                     0: FixedColumnWidth(80),
//                     1: FixedColumnWidth(160),
//                     2: FixedColumnWidth(480), // Increased width here
//                     3: FixedColumnWidth(120),
//                     4: FixedColumnWidth(200),
//                     5: FixedColumnWidth(240),
//                     6: FixedColumnWidth(320), // Slightly extended
//                   },
//                   children: [
//                     // Table Header
//                     TableRow(
//                       children: List.generate(headers.length, (index) {
//                         final bgColor =
//                             index.isEven
//                                 ? const Color(0xFFEF5350) // Light red
//                                 : const Color(0xFFD32F2F); // Dark red
//                         return Container(
//                           padding: const EdgeInsets.all(12),
//                           color: bgColor,
//                           height: 60,
//                           alignment: Alignment.center,
//                           child: Text(
//                             headers[index],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         );
//                       }),
//                     ),
//                     // Table Body
//                     ...data.map((row) {
//                       return TableRow(
//                         children: List.generate(row.length, (index) {
//                           final bgColor =
//                               index.isEven
//                                   ? const Color(0xFFF8D9D6) // Light pink
//                                   : const Color(0xFFF2BEBE); // Dark pink
//                           return Container(
//                             padding: const EdgeInsets.all(12),
//                             height: MediaQuery.of(context).size.height - 120,
//                             color: bgColor,
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               row[index],
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Color(0xFF002D72), // Blue font
//                               ),
//                             ),
//                           );
//                         }),
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//API INTEGRATION:
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class NewsPresenterPage extends StatefulWidget {
//   final String serviceTypeName;

//   const NewsPresenterPage({Key? key, required this.serviceTypeName})
//     : super(key: key);

//   @override
//   _NewsPresenterPageState createState() => _NewsPresenterPageState();
// }

// class _NewsPresenterPageState extends State<NewsPresenterPage> {
//   List<Map<String, dynamic>> tableData = [];
//   bool isLoading = true;
//   bool hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchServiceDetails();
//   }

//   Future<void> fetchServiceDetails() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
//         headers: {'userid': '7', 'org_code': 'Bhanu8'},
//         body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
//       );

//       if (response.statusCode == 200) {
//         final List data = jsonDecode(response.body)['data'];

//         // Filter by serviceTypeName passed from Grid
//         final filtered =
//             data
//                 .where(
//                   (item) => item['service_typename'] == widget.serviceTypeName,
//                 )
//                 .toList();

//         setState(() {
//           tableData =
//               filtered.map<Map<String, dynamic>>((item) {
//                 return {
//                   'code': item['code']?.toString() ?? '',
//                   'service_typename': item['service_typename'] ?? '',
//                   'service_recdetail': item['service_recdetail'] ?? '',
//                   'fee': item['fee'] ?? '',
//                   'time': item['time'] ?? '',
//                   'service_provider': item['service_provider'] ?? '',
//                   'complain_listen': item['complain_listen'] ?? '',
//                 };
//               }).toList();

//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching service details: $e');
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.serviceTypeName,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFF2E64C7),
//         foregroundColor: Colors.white,
//       ),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : hasError
//               ? const Center(
//                 child: Text('Error loading data. Please try again.'),
//               )
//               : tableData.isEmpty
//               ? const Center(child: Text('No data found for this service.'))
//               : SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     border: TableBorder.all(color: Colors.grey),
//                     headingRowColor: WidgetStateProperty.all(Colors.blue[100]),
//                     columns: const [
//                       DataColumn(label: Text('Code')),
//                       DataColumn(label: Text('Service Name')),
//                       DataColumn(label: Text('Required Documents')),
//                       DataColumn(label: Text('Fee')),
//                       DataColumn(label: Text('Time')),
//                       DataColumn(label: Text('Provider')),
//                       DataColumn(label: Text('Complain Listen By')),
//                     ],
//                     rows:
//                         tableData.map((item) {
//                           return DataRow(
//                             cells: [
//                               DataCell(Text(item['code'] ?? '')),
//                               DataCell(Text(item['service_typename'] ?? '')),
//                               DataCell(
//                                 SizedBox(
//                                   width: 300,
//                                   child: Text(
//                                     item['service_recdetail'] ?? '',
//                                     softWrap: true,
//                                   ),
//                                 ),
//                               ),
//                               DataCell(Text(item['fee'] ?? '')),
//                               DataCell(Text(item['time'] ?? '')),
//                               DataCell(Text(item['service_provider'] ?? '')),
//                               DataCell(Text(item['complain_listen'] ?? '')),
//                             ],
//                           );
//                         }).toList(),
//                   ),
//                 ),
//               ),
//     );
//   }
// }

//TEST:
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/service.dart';
import '../services/hive_service.dart';

class NewsPresenterPage extends StatefulWidget {
  final String serviceTypeName;

  const NewsPresenterPage({super.key, required this.serviceTypeName});

  @override
  State<NewsPresenterPage> createState() => _NewsPresenterPageState();
}

class _NewsPresenterPageState extends State<NewsPresenterPage> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;
  final FlutterTts flutterTts = FlutterTts();

  final List<String> headers = [
    'क्र.सं',
    'सेवाको किसिम',
    'सेवा प्राप्त गर्न पेश गर्नुपर्ने विवरण',
    'लाग्ने शुल्क',
    'लाग्ने समय',
    'सेवा दिने शाखा',
    'गुनासो सुन्ने अधिकारी',
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  /// MAIN: fetch from API or fallback to Hive cache
  Future<void> fetchData() async {
    setState(() => isLoading = true);

    final connectivity = await Connectivity().checkConnectivity();
    final bool isOnline = connectivity != ConnectivityResult.none;

    if (isOnline) {
      await fetchFromApi();
    } else {
      await loadFromCache();
    }

    setState(() => isLoading = false);

    if (data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        speakTableData();
      });
    }
  }

  /// Fetch from API and update Hive only if new/changed data exists
  Future<void> fetchFromApi() async {
    try {
      final response = await http.post(
        Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'userid': '7', 'orgid': '22', 'org_code': 'Bhanu8'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        final List<Service> apiServices =
            responseData.map((item) => Service.fromJson(item)).toList();

        // Compare with cached data
        final cachedServices = HiveService.getServices();
        bool hasChanges = false;

        for (var apiService in apiServices) {
          final match = cachedServices.firstWhere(
            (s) => s.code == apiService.code,
            orElse:
                () => Service(
                  code: '',
                  serviceTypeName: '',
                  serviceRecDetail: '',
                  fee: '',
                  time: '',
                  serviceProvider: '',
                  complainListen: '',
                ),
          );

          if (match.code.isEmpty ||
              match.toJson().toString() != apiService.toJson().toString()) {
            hasChanges = true;
            break;
          }
        }

        if (hasChanges) {
          await HiveService.saveServices(apiServices);
        }

        // Filter only for current grid
        final filtered =
            apiServices
                .where((s) => s.serviceTypeName == widget.serviceTypeName)
                .toList();

        // Map to displayable table
        data =
            filtered.map((s) {
              return {
                'क्र.सं': s.code,
                'सेवाको किसिम': s.serviceTypeName,
                'सेवा प्राप्त गर्न पेश गर्नुपर्ने विवरण': s.serviceRecDetail,
                'लाग्ने शुल्क': s.fee,
                'लाग्ने समय': s.time,
                'सेवा दिने शाखा': s.serviceProvider,
                'गुनासो सुन्ने अधिकारी': s.complainListen,
              };
            }).toList();
      } else {
        await loadFromCache(); // fallback if request fails
      }
    } catch (e) {
      print("Error fetching data: $e");
      await loadFromCache();
    }
  }

  /// Load cached data from Hive for the current grid
  Future<void> loadFromCache() async {
    final cached = HiveService.getServices();
    final filtered =
        cached
            .where((s) => s.serviceTypeName == widget.serviceTypeName)
            .toList();

    data =
        filtered.map((s) {
          return {
            'क्र.सं': s.code,
            'सेवाको किसिम': s.serviceTypeName,
            'सेवा प्राप्त गर्न पेश गर्नुपर्ने विवरण': s.serviceRecDetail,
            'लाग्ने शुल्क': s.fee,
            'लाग्ने समय': s.time,
            'सेवा दिने शाखा': s.serviceProvider,
            'गुनासो सुन्ने अधिकारी': s.complainListen,
          };
        }).toList();

    if (data.isEmpty) {
      print('No offline data available for "${widget.serviceTypeName}"');
    }
  }

  /// Speak data using TTS, skipping 'क्र.सं'
  Future<void> speakTableData() async {
    await flutterTts.stop();

    String textToRead = '';
    for (var row in data) {
      for (int i = 1; i < headers.length; i++) {
        textToRead += '${headers[i]}: ${row[headers[i]]}. ';
      }
    }

    if (textToRead.isNotEmpty) {
      await flutterTts.setLanguage("ne-NP");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(textToRead);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002D72),
        title: Text(
          widget.serviceTypeName,
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              flutterTts.stop();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF3ECF3),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : data.isEmpty
                ? Center(
                  child: Text(
                    'No data available for "${widget.serviceTypeName}"',
                    style: const TextStyle(
                      color: Color(0xFF002D72),
                      fontSize: 16,
                    ),
                  ),
                )
                : Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1600,
                      child: SingleChildScrollView(
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(80),
                            1: FixedColumnWidth(160),
                            2: FixedColumnWidth(480),
                            3: FixedColumnWidth(120),
                            4: FixedColumnWidth(200),
                            5: FixedColumnWidth(240),
                            6: FixedColumnWidth(320),
                          },
                          children: [
                            // Header
                            TableRow(
                              children: List.generate(headers.length, (index) {
                                final bgColor =
                                    index.isEven
                                        ? const Color(0xFFEF5350)
                                        : const Color(0xFFD32F2F);
                                return Container(
                                  padding: const EdgeInsets.all(12),
                                  color: bgColor,
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: Text(
                                    headers[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }),
                            ),
                            // Rows
                            ...data.map((row) {
                              return TableRow(
                                children:
                                    headers.map((header) {
                                      final isEvenColumn =
                                          headers.indexOf(header) % 2 == 0;
                                      return _buildCell(
                                        row[header] ?? '',
                                        isEvenColumn,
                                      );
                                    }).toList(),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }

  Widget _buildCell(String text, bool isEvenColumn) {
    final bgColor =
        isEvenColumn ? const Color(0xFFF8D9D6) : const Color(0xFFF2BEBE);
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height - 120,
      color: bgColor,
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Color(0xFF002D72)),
      ),
    );
  }
}
