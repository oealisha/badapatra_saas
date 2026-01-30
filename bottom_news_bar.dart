// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';

// class BottomNewsBar extends StatelessWidget {
//   const BottomNewsBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFFcd0711), Color(0xFFcd0711)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 90,
//             color: Color(0xFF2E64C7),
//             alignment: Alignment.center,
//             child: const Text(
//               "सुचनाहरु",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           // ✅ Marquee must NOT be const
//           Expanded(
//             child: Marquee(
//               text:
//                   "📢 Breaking News: Digital Bada Patra Launched | E-Governance improving services",
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//               velocity: 45.0,
//               blankSpace: 20.0,
//               pauseAfterRound: const Duration(seconds: 1),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//DYNAMIC:

// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';

// class BottomNewsBar extends StatelessWidget {
//   final List<dynamic> newsItems;
//   final String rssType;

//   const BottomNewsBar({
//     super.key,
//     required this.newsItems,
//     required this.rssType,
//   });

//   String _buildNewsText() {
//     if (newsItems.isEmpty) return "सूचना उपलब्ध छैन";
//     return newsItems.map((e) => e['title'] ?? '').join("     |     ");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       color: const Color(0xFFCD0711), // Full red base
//       child: Stack(
//         children: [
//           // White triangular label (exact shape + position)
//           CustomPaint(
//             painter: WhiteTriangleLabelPainter(),
//             size: const Size(240, 50),
//           ),

//           // Scrolling news text
//           Positioned.fill(
//             left: 200, // Starts exactly where triangle ends
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Marquee(
//                 text: _buildNewsText(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 19,
//                   fontWeight: FontWeight.bold,
//                   height: 1.4,
//                 ),
//                 velocity: 70,
//                 blankSpace: 120,
//                 pauseAfterRound: Duration(seconds: 1),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WhiteTriangleLabelPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.white;

//     final path =
//         Path()
//           ..moveTo(0, 0)
//           ..lineTo(size.width - 45, 0)
//           ..lineTo(size.width, size.height / 2)
//           ..lineTo(size.width - 45, size.height)
//           ..lineTo(0, size.height)
//           ..close();

//     canvas.drawPath(path, paint);

//     // "News24Nepal:" text perfectly centered inside the white triangle part
//     const text = "News24Nepal:";
//     final textStyle = const TextStyle(
//       color: Color(0xFFCD0711),
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     );
//     final textSpan = TextSpan(text: text, style: textStyle);
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();

//     textPainter.paint(
//       canvas,
//       Offset(22, (size.height - textPainter.height) / 2),
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }


import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class BottomNewsBar extends StatelessWidget {
  final List<dynamic> newsItems;
  final String rssType;

  const BottomNewsBar({
    super.key,
    required this.newsItems,
    required this.rssType,
  });

  String _buildNewsText() {
    if (newsItems.isEmpty) return "सूचना उपलब्ध छैन";
    return newsItems.map((e) => e['title'] ?? '').join("     |     ");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: Stack(
        children: [
          // Red background with truncated/tapered bottom
          CustomPaint(
            painter: TaperedRedBackgroundPainter(),
            size: const Size(double.infinity, 35),
          ),

          // White triangular label
          CustomPaint(
            painter: WhiteTriangleLabelPainter(),
            size: const Size(160, 35),
          ),

          // Scrolling news text
          Positioned.fill(
            left: 135,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Marquee(
                text: _buildNewsText(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
                velocity: 30,
                blankSpace: 120,
                pauseAfterRound: const Duration(seconds: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaperedRedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFCD0711);

    // Create tapered red background (narrower at bottom)
    final path =
        Path()
          ..moveTo(0, 0) // Top-left
          ..lineTo(size.width, 0) // Top-right
          ..lineTo(size.width, size.height - 5) // Bottom-right (slightly up)
          ..lineTo(0, size.height) // Bottom-left
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WhiteTriangleLabelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width - 30, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width - 30, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(path, paint);

    // "News24Nepal:" text
    const text = "News24Nepal:";
    final textStyle = const TextStyle(
      color: Color(0xFFCD0711),
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(15, (size.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
