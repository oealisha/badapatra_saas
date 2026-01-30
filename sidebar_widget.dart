// // sidebar_widget.dart
// import 'package:flutter/material.dart';

// class SidebarWidget extends StatelessWidget {
//   const SidebarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         children: [
//           _buildMayorCard(),
//           const SizedBox(height: 16),
//           _buildDeputyMayorCard(),
//           const SizedBox(height: 16),
//           _buildQRBox(),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   // ✅ Mayor Card
//   Widget _buildMayorCard() {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.red[50],
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(10),
//               ),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset('assets/images/logonepal.jpg', height: 50),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'भानु नगरपालिका',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.red[800],
//                           fontWeight: FontWeight.bold,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         'नगर कार्यपालिकाको कार्यालय',
//                         style: TextStyle(fontSize: 12, color: Colors.red[800]),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 const CircleAvatar(
//                   radius: 40,
//                   backgroundImage: AssetImage('assets/images/alisha.jpg'),
//                 ),
//                 const SizedBox(height: 12),
//                 const Text(
//                   'श्री धीरज सुवेदी',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 6),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Text(
//                     'मेयर',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildContactRow(Icons.phone, '९८७६५४३२१०'),
//                 const SizedBox(height: 6),
//                 _buildContactRow(Icons.email, 'mayor@bhanu.gov.np'),
//                 const SizedBox(height: 6),
//                 _buildContactRow(Icons.location_on, 'तनहुँ, नेपाल'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Deputy Mayor Card
//   Widget _buildDeputyMayorCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           const CircleAvatar(
//             radius: 35,
//             backgroundImage: AssetImage('assets/images/alisha.jpg'),
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'उप-मेयर',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           const Text(
//             'श्रीमती सुनिता खड्का',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Colors.blue, Colors.lightBlueAccent],
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'सम्पर्क: ९८५६०२०३०४',
//               style: TextStyle(color: Colors.white, fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ QR Box
//   Widget _buildQRBox() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           const Text(
//             'नागरिक बडापत्र कोड',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             height: 110,
//             width: 110,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue, width: 2),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             alignment: Alignment.center,
//             child: Image.asset(
//               'assets/images/qr_code.png',
//               height: 90,
//               width: 90,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 6),
//           const Text(
//             'स्क्यान गर्नुहोस्',
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.red,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Contact Row
//   Widget _buildContactRow(IconData icon, String text) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, size: 16, color: Colors.blue),
//         const SizedBox(width: 6),
//         Flexible(
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 12),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class SidebarWidget extends StatelessWidget {
//   const SidebarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildMayorCard(isLandscape),
//           const SizedBox(height: 12),
//           _buildDeputyMayorCard(isLandscape),
//           const SizedBox(height: 12),
//           _buildQRBox(isLandscape),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }

//   // ✅ Mayor Card
//   Widget _buildMayorCard(bool isLandscape) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(top: 4), // slightly reduced
//             padding: const EdgeInsets.all(10), // slightly reduced
//             decoration: BoxDecoration(
//               color: Colors.red[50],
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(10),
//               ),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Image.asset('assets/images/logonepal.jpg'),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Flexible(
//                   flex: 3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Tooltip(
//                         message: 'भानु नगरपालिका',
//                         child: Text(
//                           'भानु नगरपालिका',
//                           style: TextStyle(
//                             fontSize: isLandscape ? 14 : 16,
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: isLandscape ? 1 : null,
//                           overflow:
//                               isLandscape
//                                   ? TextOverflow.ellipsis
//                                   : TextOverflow.visible,
//                         ),
//                       ),
//                       const Text(
//                         'नगर कार्यपालिकाको कार्यालय',
//                         style: TextStyle(fontSize: 12, color: Colors.red),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12), // slightly reduced
//             child: Column(
//               children: [
//                 const CircleAvatar(
//                   radius: 40,
//                   backgroundImage: AssetImage('assets/images/alisha.jpg'),
//                 ),
//                 const SizedBox(height: 10),
//                 Tooltip(
//                   message: 'श्री धीरज सुवेदी',
//                   child: Text(
//                     'श्री धीरज सुवेदी',
//                     style: TextStyle(
//                       fontSize: isLandscape ? 14 : 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: isLandscape ? 1 : null,
//                     overflow:
//                         isLandscape
//                             ? TextOverflow.ellipsis
//                             : TextOverflow.visible,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 18,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Text(
//                     'मेयर',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 _buildContactRow(Icons.phone, '९८७६५४३२१०', isLandscape),
//                 const SizedBox(height: 6),
//                 _buildContactRow(
//                   Icons.email,
//                   'mayor@bhanu.gov.np',
//                   isLandscape,
//                 ),
//                 const SizedBox(height: 6),
//                 _buildContactRow(
//                   Icons.location_on,
//                   'तनहुँ, नेपाल',
//                   isLandscape,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Deputy Mayor Card
//   Widget _buildDeputyMayorCard(bool isLandscape) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12), // slightly reduced
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         children: [
//           const CircleAvatar(
//             radius: 35,
//             backgroundImage: AssetImage('assets/images/alisha.jpg'),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'उप-मेयर',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Tooltip(
//             message: 'श्रीमती सुनिता खड्का',
//             child: Text(
//               'श्रीमती सुनिता खड्का',
//               style: TextStyle(
//                 fontSize: isLandscape ? 14 : 14,
//                 fontWeight: FontWeight.w600,
//               ),
//               maxLines: isLandscape ? 1 : null,
//               overflow:
//                   isLandscape ? TextOverflow.ellipsis : TextOverflow.visible,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Colors.blue, Colors.lightBlueAccent],
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               'सम्पर्क: ९८५६०२०३०४',
//               style: const TextStyle(color: Colors.white, fontSize: 12),
//               maxLines: isLandscape ? 1 : null,
//               overflow:
//                   isLandscape ? TextOverflow.ellipsis : TextOverflow.visible,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ QR Box
//   Widget _buildQRBox(bool isLandscape) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(top: 6),
//       padding: EdgeInsets.symmetric(
//         vertical: isLandscape ? 16 : 12,
//         horizontal: isLandscape ? 18 : 14,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'नागरिक बडापत्र कोड',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             height: 120,
//             width: 120,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue, width: 2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(6),
//               child: Image.asset(
//                 'assets/images/qr_code.png',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'स्क्यान गर्नुहोस्',
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.red,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Contact Row
//   Widget _buildContactRow(IconData icon, String text, bool isLandscape) {
//     return Row(
//       mainAxisAlignment:
//           isLandscape ? MainAxisAlignment.start : MainAxisAlignment.center,
//       children: [
//         Icon(icon, size: 16, color: Colors.blue),
//         const SizedBox(width: 6),
//         Flexible(
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 12),
//             softWrap: true,
//           ),
//         ),
//       ],
//     );
//   }
// }

//######################################################################//

//ONLY OR: STATIC QR:
// import 'package:flutter/material.dart';

// class SidebarWidget extends StatelessWidget {
//   const SidebarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Check if device is in landscape mode
//     final bool isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Container(
//       width: isLandscape ? 250 : 200, // adaptive width
//       padding: const EdgeInsets.all(12),
//       color: Colors.grey[100],
//       child: SingleChildScrollView(
//         child: Column(children: [_buildQRBox(isLandscape)]),
//       ),
//     );
//   }

//   // ✅ QR Box
//   Widget _buildQRBox(bool isLandscape) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(top: 6),
//       padding: EdgeInsets.symmetric(
//         vertical: isLandscape ? 16 : 12,
//         horizontal: isLandscape ? 18 : 14,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'नागरिक बडापत्र कोड',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             height: 120,
//             width: 120,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue, width: 2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(6),
//               child: Image.asset(
//                 'assets/images/sprta_qr.png',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'स्क्यान गर्नुहोस्',
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.red,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//########################################################################//

// sidebar_widget.dart

// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class SidebarWidget extends StatelessWidget {
//   final String? qrUrl;

//   const SidebarWidget({super.key, this.qrUrl});

//   String get safeQrUrl {
//     if (qrUrl == null || qrUrl!.isEmpty) return "";

//     // Force-correct the URL if backend accidentally sends malformed links
//     return qrUrl!
//         .replaceAll("uploads/123/teams//", "") // remove wrong path
//         .replaceAll("badaptra", "badapatra") // fix spelling issue
//         .replaceAll("//badapatra", "/badapatra")
//         .trim();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Container(
//       width: isLandscape ? 250 : 200,
//       padding: const EdgeInsets.all(12),
//       color: Colors.grey[100],
//       child: _buildQRBox(isLandscape),
//     );
//   }

//   Widget _buildQRBox(bool isLandscape) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(top: 6),
//       padding: EdgeInsets.symmetric(
//         vertical: isLandscape ? 12 : 10,
//         horizontal: isLandscape ? 14 : 12,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             'नागरिक बडापत्र कोड',
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             height: 110,
//             width: 110,
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue, width: 2),
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.white,
//             ),
//             child:
//                 safeQrUrl.isEmpty
//                     ? const Center(
//                       child: Icon(
//                         Icons.qr_code_2,
//                         size: 50,
//                         color: Colors.grey,
//                       ),
//                     )
//                     : QrImageView(
//                       data: safeQrUrl,
//                       version: QrVersions.auto,
//                       size: 102,
//                       backgroundColor: Colors.white,
//                       errorCorrectionLevel: QrErrorCorrectLevel.M,
//                       padding: EdgeInsets.zero,
//                     ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'स्क्यान गर्नुहोस्',
//             style: TextStyle(
//               fontSize: 11,
//               color: Colors.red,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//RAMPUR:
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SidebarWidget extends StatelessWidget {
  final String? qrUrl;

  const SidebarWidget({super.key, this.qrUrl});

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      width: isLandscape ? 250 : 200,
      padding: const EdgeInsets.all(12),
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(children: [_buildQRBox(isLandscape)]),
      ),
    );
  }

  Widget _buildQRBox(bool isLandscape) {
    print("📱 QR URL: $qrUrl");

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 6),
      padding: EdgeInsets.symmetric(
        vertical: isLandscape ? 16 : 12,
        horizontal: isLandscape ? 18 : 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'नागरिक बडापत्र कोड',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child:
                  qrUrl != null && qrUrl!.isNotEmpty
                      ? QrImageView(
                        data: qrUrl!,
                        version: QrVersions.auto,
                        size: 108,
                        backgroundColor: Colors.white,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Colors.black,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Colors.black,
                        ),
                        errorStateBuilder: (context, error) {
                          print("❌ QR Code generation error: $error");
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 40,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'QR Error',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                        },
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'QR unavailable',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'स्क्यान गर्नुहोस्',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
