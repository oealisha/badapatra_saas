// import 'package:flutter/material.dart';
// import 'package:bada_patra_task/team_page.dart';
// import 'package:bada_patra_task/grid_button.dart'; // import GridButton page

// class FooterNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTap;

//   const FooterNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home, color: Colors.redAccent),
//           label: 'Home 🏠',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.people, color: Colors.redAccent),
//           label: 'Team 👥',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.receipt_long, color: Colors.redAccent),
//           label: 'Service 🧾',
//         ),
//       ],
//       currentIndex: selectedIndex,
//       selectedItemColor: Colors.redAccent,
//       onTap: (index) {
//         if (index == 1) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TeamPage()),
//           );
//         } else if (index == 2) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => GridButton()),
//           );
//         } else {
//           onTap(index);
//         }
//       },
//     );
//   }
// }
