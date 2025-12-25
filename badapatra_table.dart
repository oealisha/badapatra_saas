import 'package:flutter/material.dart';

class BadapatraTable extends StatelessWidget {
  final List<Map<String, String>> services;
  final void Function(Map<String, String>) onRowTap;

  const BadapatraTable({
    Key? key,
    required this.services,
    required this.onRowTap,
  }) : super(key: key);

  Widget buildWrappedCell(String? text) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Text(
        text ?? '',
        softWrap: true,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Badapatra Table')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16,
            headingRowColor: MaterialStateProperty.all(const Color(0xFF233072)),
            columns: const [
              DataColumn(
                label: Text(
                  'कोड',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'सेवा प्रकार',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'आवश्यक कागजात',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'शुल्क',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'समय',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'सेवा प्रदायक',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'गुनासो सुनुवाई',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            rows:
                services.map((service) {
                  return DataRow(
                    onSelectChanged: (selected) {
                      if (selected ?? false) {
                        onRowTap(service);
                      }
                    },
                    cells: [
                      DataCell(buildWrappedCell(service['code'])),
                      DataCell(buildWrappedCell(service['serviceTypeName'])),
                      DataCell(buildWrappedCell(service['serviceRecDetail'])),
                      DataCell(buildWrappedCell(service['fee'])),
                      DataCell(buildWrappedCell(service['time'])),
                      DataCell(buildWrappedCell(service['serviceProvider'])),
                      DataCell(buildWrappedCell(service['complainListen'])),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

// ✅ This part runs the table separately for testing
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestBadapatraTable(),
    ),
  );
}

class TestBadapatraTable extends StatelessWidget {
  const TestBadapatraTable({super.key});

  @override
  Widget build(BuildContext context) {
    final mockServices = [
      {
        'code': '001',
        'serviceTypeName': 'नागरिकता प्रमाणपत्र',
        'serviceRecDetail': 'नागरिकता, फोटो',
        'fee': 'Free',
        'time': '1 दिन',
        'serviceProvider': 'Ward Office',
        'complainListen': 'गुनासो फारम',
      },
      {
        'code': '002',
        'serviceTypeName': 'बसोबास सिफारिस',
        'serviceRecDetail': 'घरको प्रमाण',
        'fee': 'Rs. 50',
        'time': '2 दिन',
        'serviceProvider': 'Ward Office',
        'complainListen': 'फोन वा निवेदन',
      },
    ];

    return BadapatraTable(
      services: mockServices,
      onRowTap: (service) {
        print('Tapped service: ${service['serviceTypeName']}');
      },
    );
  }
}
