// // DONE*
// // THIS IS TEAM PAGE HIERARCHY
// import 'package:flutter/material.dart'; // Flutter UI ko lagi import gareko

// void main() => runApp(
//   MaterialApp(home: TeamPage()),
// ); // App start huney thau, TeamPage load garxa

// class TeamPage extends StatelessWidget {
//   // Team members ko list define gareko
//   final List<TeamMember> teamMembers = [
//     TeamMember(
//       name: 'Jane Smith',
//       position: 'Chairperson',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Leads municipal policy.', // K kaam garxa bhanera chhoto intro
//       contact: '9841234567',
//       address: 'Bhaktapur, Nepal',
//     ),
//     TeamMember(
//       name: 'Emily Davis',
//       position: 'Secretary',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Handles records and communications.',
//       contact: '9812345678',
//       address: 'Pokhara, Nepal',
//     ),
//     TeamMember(
//       name: 'Michael Wilson',
//       position: 'Treasurer',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Manages budget.',
//       contact: '9823456789',
//       address: 'Chitwan, Nepal',
//     ),
//     TeamMember(
//       name: 'Robert Johnson',
//       position: 'Vice-Chairperson',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Assists the chairperson.',
//       contact: '9807654321',
//       address: 'Lalitpur, Nepal',
//     ),
//     TeamMember(
//       name: 'Alice Brown',
//       position: 'Member',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Ward representative.',
//       contact: '9856741234',
//       address: 'Biratnagar, Nepal',
//     ),
//     TeamMember(
//       name: 'John Carter',
//       position: 'Member',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Ward representative.',
//       contact: '9801234567',
//       address: 'Dharan, Nepal',
//     ),
//   ];

//   // Mayor ko data alag define gareko
//   final TeamMember mayor = TeamMember(
//     name: 'Shree Dhiraj Subedi',
//     position: 'Mayor',
//     imageUrl: 'assets/images/profile.jpeg',
//     bio: 'Responsible for overall administration of the municipality.',
//     contact: '9876543210',
//     address: 'Kathmandu, Nepal',
//   );

//   @override
//   Widget build(BuildContext context) {
//     // Device ko screen width anusar card ko size define garincha
//     double screenWidth = MediaQuery.of(context).size.width;
//     double cardWidth = screenWidth < 600 ? screenWidth * 0.9 : 400;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Team Hierarchy'), // App bar ma title dekhauxa
//         backgroundColor: Colors.redAccent,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           Center(
//             child: SizedBox(
//               width: cardWidth,
//               height: 480,
//               child: TeamMemberCard(
//                 member: mayor,
//                 isMayor: true,
//               ), // Mayor ko card
//             ),
//           ),
//           SizedBox(height: 24), // Space dincha
//           buildGrid(
//             context,
//             teamMembers,
//           ), // Aru team members ko grid build huncha
//         ],
//       ),
//     );
//   }

//   // Team member haru horizontal wrap ma show garna wrap widget use gareko
//   Widget buildGrid(BuildContext context, List<TeamMember> members) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double cardWidth = screenWidth < 600 ? screenWidth * 0.9 : 400;

//     return Wrap(
//       spacing: 16, // Horizontal space between cards
//       runSpacing: 16, // Vertical space
//       alignment: WrapAlignment.center, // Center aligned
//       children:
//           members.map((member) {
//             return SizedBox(
//               width: cardWidth,
//               height: 480,
//               child: TeamMemberCard(member: member), // Member ko card banaune
//             );
//           }).toList(),
//     );
//   }
// }

// // TeamMember class le ek jana ko sabai info hold garxa
// class TeamMember {
//   final String name, position, imageUrl, bio, contact, address;

//   TeamMember({
//     required this.name,
//     required this.position,
//     required this.imageUrl,
//     required this.bio,
//     required this.contact,
//     required this.address,
//   });
// }

// // Yo widget le ek jana team member ko info card ma display garxa
// class TeamMemberCard extends StatelessWidget {
//   final TeamMember member;
//   final bool isMayor;

//   const TeamMemberCard({required this.member, this.isMayor = false});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: isMayor ? 6 : 4, // Mayor ho vane ali ucha elevation
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color:
//                   isMayor
//                       ? Colors.red[50]
//                       : Colors.white, // Mayor ho vane background halka red
//               border: Border(bottom: BorderSide(color: Colors.red, width: 2)),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset(
//                   'assets/images/logonepal.jpg',
//                   height: 60,
//                 ), // Left ma logo
//                 Column(
//                   children: [
//                     Text(
//                       'भानु नगरपालिका', // Organization ko naam
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.red[800],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'नगर कार्यपालिकाको कार्यालय',
//                       style: TextStyle(fontSize: 14, color: Colors.red[800]),
//                     ),
//                     Text(
//                       'तनहुँ',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Image.asset(
//                   'assets/images/flag.png',
//                   height: 60,
//                 ), // Right ma flag
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: isMayor ? 60 : 50, // Mayor ho vane photo thulo
//                     backgroundImage: AssetImage(member.imageUrl), // Photo
//                   ),
//                   SizedBox(height: 14),
//                   Text(
//                     member.name, // Naam
//                     style: TextStyle(
//                       fontSize: isMayor ? 20 : 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 6),
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                     decoration: BoxDecoration(
//                       color:
//                           isMayor
//                               ? Colors.red
//                               : Colors.blue, // Post ko background color
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       member.position, // Post
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: isMayor ? 15 : 13,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     member.bio, // Short intro
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     '📞 ${member.contact}', // Phone number
//                     style: TextStyle(fontSize: 14, color: Colors.green[800]),
//                   ),
//                   Text(
//                     '📍 ${member.address}', // Address
//                     style: TextStyle(fontSize: 14, color: Colors.deepPurple),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//WORKING:
// import 'package:flutter/material.dart';

// class TeamPage extends StatelessWidget {
//   final bool scrollable;
//   TeamPage({this.scrollable = true});

//   final List<TeamMember> teamMembers = [
//     TeamMember(
//       name: 'Jane Smith',
//       position: 'Chairperson',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Leads municipal policy.',
//       contact: '9841234567',
//       address: 'Bhaktapur, Nepal',
//     ),
//     // ... other team members
//   ];

//   final TeamMember mayor = TeamMember(
//     name: 'Shree Dhiraj Subedi',
//     position: 'Mayor',
//     imageUrl: 'assets/images/profile.jpeg',
//     bio: 'Responsible for overall administration of the municipality.',
//     contact: '9876543210',
//     address: 'Kathmandu, Nepal',
//   );

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double cardWidth = screenWidth < 600 ? screenWidth * 0.9 : 400;

//     final content = Column(
//       children: [
//         Center(
//           child: SizedBox(
//             width: cardWidth,
//             height: 480,
//             child: TeamMemberCard(member: mayor, isMayor: true),
//           ),
//         ),
//         SizedBox(height: 24),
//         buildGrid(context, teamMembers),
//       ],
//     );

//     if (scrollable) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Team Hierarchy'),
//           backgroundColor: Colors.redAccent,
//         ),
//         body: ListView(padding: const EdgeInsets.all(16), children: [content]),
//       );
//     } else {
//       return content; // For embedding in FinalHomePage
//     }
//   }

//   Widget buildGrid(BuildContext context, List<TeamMember> members) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double cardWidth = screenWidth < 600 ? screenWidth * 0.9 : 400;

//     return Wrap(
//       spacing: 16,
//       runSpacing: 16,
//       alignment: WrapAlignment.center,
//       children:
//           members
//               .map(
//                 (member) => SizedBox(
//                   width: cardWidth,
//                   height: 480,
//                   child: TeamMemberCard(member: member),
//                 ),
//               )
//               .toList(),
//     );
//   }
// }

// class TeamMember {
//   final String name, position, imageUrl, bio, contact, address;

//   TeamMember({
//     required this.name,
//     required this.position,
//     required this.imageUrl,
//     required this.bio,
//     required this.contact,
//     required this.address,
//   });
// }

// class TeamMemberCard extends StatelessWidget {
//   final TeamMember member;
//   final bool isMayor;

//   const TeamMemberCard({required this.member, this.isMayor = false});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: isMayor ? 6 : 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: isMayor ? Colors.red[50] : Colors.white,
//               border: const Border(
//                 bottom: BorderSide(color: Colors.red, width: 2),
//               ),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset('assets/images/logonepal.jpg', height: 60),
//                 Column(
//                   children: [
//                     Text(
//                       'भानु नगरपालिका',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.red[800],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'नगर कार्यपालिकाको कार्यालय',
//                       style: TextStyle(fontSize: 14, color: Colors.red[800]),
//                     ),
//                     Text(
//                       'तनहुँ',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Image.asset('assets/images/flag.png', height: 60),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: isMayor ? 60 : 50,
//                     backgroundImage: AssetImage(member.imageUrl),
//                   ),
//                   const SizedBox(height: 14),
//                   Text(
//                     member.name,
//                     style: TextStyle(
//                       fontSize: isMayor ? 20 : 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: isMayor ? Colors.red : Colors.blue,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       member.position,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: isMayor ? 15 : 13,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     member.bio,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     '📞 ${member.contact}',
//                     style: TextStyle(fontSize: 14, color: Colors.green[800]),
//                   ),
//                   Text(
//                     '📍 ${member.address}',
//                     style: TextStyle(fontSize: 14, color: Colors.deepPurple),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//DEADLINE:

// import 'package:flutter/material.dart';

// class TeamPage extends StatelessWidget {
//   final bool scrollable;

//   const TeamPage({this.scrollable = true, super.key});

//   final List<TeamMember> teamMembers = const [
//     TeamMember(
//       name: 'Jane Smith',
//       position: 'Chairperson',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Leads municipal policy.',
//       contact: '9841234567',
//       address: 'Bhaktapur, Nepal',
//     ),
//     TeamMember(
//       name: 'John Doe',
//       position: 'Deputy Chairperson',
//       imageUrl: 'assets/images/profile.jpeg',
//       bio: 'Supports municipal operations.',
//       contact: '9845678901',
//       address: 'Kathmandu, Nepal',
//     ),
//   ];

//   final TeamMember mayor = const TeamMember(
//     name: 'Shree Dhiraj Subedi',
//     position: 'Mayor',
//     imageUrl: 'assets/images/profile.jpeg',
//     bio: 'Responsible for overall administration of the municipality.',
//     contact: '9876543210',
//     address: 'Kathmandu, Nepal',
//   );

//   @override
//   Widget build(BuildContext context) {
//     final content = Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Mayor Card
//         TeamMemberCard(member: mayor, isMayor: true),
//         const SizedBox(height: 24),

//         // Other team members
//         ...teamMembers.map(
//           (member) => Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: TeamMemberCard(member: member),
//           ),
//         ),
//       ],
//     );

//     return scrollable
//         ? SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 4),
//           child: content,
//         )
//         : content;
//   }
// }

// class TeamMember {
//   final String name;
//   final String position;
//   final String imageUrl;
//   final String bio;
//   final String contact;
//   final String address;

//   const TeamMember({
//     required this.name,
//     required this.position,
//     required this.imageUrl,
//     required this.bio,
//     required this.contact,
//     required this.address,
//   });
// }

// class TeamMemberCard extends StatelessWidget {
//   final TeamMember member;
//   final bool isMayor;

//   const TeamMemberCard({required this.member, this.isMayor = false, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: isMayor ? 6 : 3,
//       shadowColor: Colors.grey.shade300,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: isMayor ? 35 : 28,
//               backgroundImage: AssetImage(member.imageUrl),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               member.name,
//               style: TextStyle(
//                 fontSize: isMayor ? 16 : 14,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               member.position,
//               style: TextStyle(
//                 fontSize: isMayor ? 14 : 12,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.blue,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               member.bio,
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//DYNAMIC:

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TeamPage extends StatefulWidget {
//   final bool scrollable;

//   const TeamPage({this.scrollable = true, super.key});

//   @override
//   State<TeamPage> createState() => _TeamPageState();
// }

// class _TeamPageState extends State<TeamPage> {
//   late Future<List<TeamMember>> _teamFuture;

//   @override
//   void initState() {
//     super.initState();
//     _teamFuture = fetchTeamData();
//   }

//   Future<List<TeamMember>> fetchTeamData() async {
//     final response = await http.get(
//       Uri.parse('https://digitalbadapatra.com/api/teams'),
//     );
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> teams = data['teams'];
//       return teams.map((json) => TeamMember.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load team data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<TeamMember>>(
//       future: _teamFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No team members found.'));
//         }

//         final teamMembers = snapshot.data!;
//         final mayor =
//             teamMembers.isNotEmpty
//                 ? teamMembers.first
//                 : null; // Assuming first is Mayor
//         final otherMembers =
//             teamMembers.length > 1 ? teamMembers.sublist(1) : [];

//         final content = Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             if (mayor != null) TeamMemberCard(member: mayor, isMayor: true),
//             const SizedBox(height: 24),
//             ...otherMembers.map(
//               (member) => Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: TeamMemberCard(member: member),
//               ),
//             ),
//           ],
//         );

//         return widget.scrollable
//             ? SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: content,
//             )
//             : content;
//       },
//     );
//   }
// }

// class TeamMember {
//   final String id;
//   final String name;
//   final String designation;
//   final String attachment;
//   final String? phone;
//   final String? address;

//   TeamMember({
//     required this.id,
//     required this.name,
//     required this.designation,
//     required this.attachment,
//     this.phone,
//     this.address,
//   });

//   factory TeamMember.fromJson(Map<String, dynamic> json) {
//     return TeamMember(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       designation: json['designation'] ?? '',
//       attachment: json['attachment'] ?? '',
//       phone: json['phone'],
//       address: json['address'],
//     );
//   }
// }

// class TeamMemberCard extends StatelessWidget {
//   final TeamMember member;
//   final bool isMayor;

//   const TeamMemberCard({required this.member, this.isMayor = false, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: isMayor ? 6 : 3,
//       shadowColor: Colors.grey.shade300,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: isMayor ? 35 : 28,
//               backgroundImage: NetworkImage(member.attachment),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               member.name,
//               style: TextStyle(
//                 fontSize: isMayor ? 16 : 14,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               member.designation,
//               style: TextStyle(
//                 fontSize: isMayor ? 14 : 12,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.blue,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             if (member.phone != null)
//               Text('📞 ${member.phone}', style: const TextStyle(fontSize: 12)),
//             if (member.address != null)
//               Text(
//                 '🏠 ${member.address}',
//                 style: const TextStyle(fontSize: 12),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class TeamPage extends StatelessWidget {
//   final List<dynamic> teams; // dynamic list from API
//   final bool scrollable;

//   const TeamPage({Key? key, required this.teams, this.scrollable = true})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (teams.isEmpty) {
//       return const Center(child: Text('No team members found.'));
//     }

//     final displayedTeam = teams.length > 7 ? teams.sublist(0, 7) : teams;

//     return Column(
//       children:
//           displayedTeam
//               .map(
//                 (e) => Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: TeamMemberCard(
//                     member: TeamMember(
//                       id: e['id'] ?? '',
//                       name: e['name'] ?? '',
//                       designation: e['designation'] ?? '',
//                       imageUrl: e['attachment'] ?? '',
//                       phone: e['phone'] ?? '',
//                       email: e['email'] ?? '',
//                       address: e['address'] ?? '',
//                       orgName: e['org_name'] ?? 'Organization',
//                       orgUnit: e['org_unit'] ?? '',
//                       logoUrl: e['logo'] ?? '', // ✅ dynamic logo
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//     );
//   }
// }

// class TeamMember {
//   final String id;
//   final String name;
//   final String designation;
//   final String imageUrl;
//   final String phone;
//   final String email;
//   final String address;
//   final String orgName;
//   final String orgUnit;
//   final String logoUrl; // ✅ added

//   TeamMember({
//     required this.id,
//     required this.name,
//     required this.designation,
//     required this.imageUrl,
//     required this.phone,
//     required this.email,
//     required this.address,
//     required this.orgName,
//     required this.orgUnit,
//     required this.logoUrl, // ✅ added
//   });
// }

// class TeamMemberCard extends StatelessWidget {
//   final TeamMember member;

//   const TeamMemberCard({Key? key, required this.member}) : super(key: key);

//   Widget _buildContactRow(IconData icon, String? text) {
//     if (text == null || text.isEmpty) return const SizedBox.shrink();
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 16, color: Colors.grey[700]),
//         const SizedBox(width: 6),
//         Flexible(
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 12, color: Colors.grey),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

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
//           // 🔥 Header with DYNAMIC logo
//           Container(
//             margin: const EdgeInsets.only(top: 4),
//             padding: const EdgeInsets.all(10),
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
//                     child:
//                         (member.logoUrl.isNotEmpty)
//                             ? Image.network(
//                               member.logoUrl,
//                               height: 40,
//                               errorBuilder:
//                                   (c, e, s) => Image.asset(
//                                     'assets/images/logonepal.jpg',
//                                     height: 40,
//                                   ),
//                             )
//                             : Image.asset(
//                               'assets/images/logonepal.jpg',
//                               height: 40,
//                             ),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Flexible(
//                   flex: 3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Tooltip(
//                         message: member.orgName,
//                         child: Text(
//                           member.orgName,
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
//                       Text(
//                         member.orgUnit,
//                         style: const TextStyle(fontSize: 12, color: Colors.red),
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
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundImage:
//                       (member.imageUrl.isNotEmpty)
//                           ? NetworkImage(member.imageUrl)
//                           : null,
//                   child:
//                       member.imageUrl.isEmpty
//                           ? const Icon(Icons.person, size: 40)
//                           : null,
//                 ),
//                 const SizedBox(height: 10),
//                 Tooltip(
//                   message: member.name,
//                   child: Text(
//                     member.name,
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

//                 // 🔥 Designation badge
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 18,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     member.designation,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 10),
//                 _buildContactRow(Icons.phone, member.phone),
//                 const SizedBox(height: 6),
//                 _buildContactRow(Icons.email, member.email),
//                 const SizedBox(height: 6),
//                 _buildContactRow(Icons.location_on, member.address),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//

import 'package:flutter/material.dart';

class TeamMember {
  final String id;
  final String name;
  final String designation;
  final String imageUrl;
  final String phone;
  final String email;
  final String address;
  final String orgName;
  final String orgUnit;
  final String logoUrl;

  TeamMember({
    required this.id,
    required this.name,
    required this.designation,
    required this.imageUrl,
    required this.phone,
    required this.email,
    required this.address,
    required this.orgName,
    required this.orgUnit,
    required this.logoUrl,
  });
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember member;

  const TeamMemberCard({Key? key, required this.member}) : super(key: key);

  Widget _buildContactRow(IconData icon, String? text) {
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // 🔥 Header with DYNAMIC logo
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child:
                        (member.logoUrl.isNotEmpty)
                            ? Image.network(
                              member.logoUrl,
                              height: 40,
                              errorBuilder:
                                  (c, e, s) => Image.asset(
                                    'assets/images/logonepal.jpg',
                                    height: 40,
                                  ),
                            )
                            : Image.asset(
                              'assets/images/logonepal.jpg',
                              height: 40,
                            ),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: member.orgName,
                        child: Text(
                          member.orgName,
                          style: TextStyle(
                            fontSize: isLandscape ? 14 : 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: isLandscape ? 1 : null,
                          overflow:
                              isLandscape
                                  ? TextOverflow.ellipsis
                                  : TextOverflow.visible,
                        ),
                      ),
                      Text(
                        member.orgUnit,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // ✅ Better error handling for member images
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child:
                      member.imageUrl.isNotEmpty
                          ? ClipOval(
                            child: Image.network(
                              member.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print(
                                  '❌ Failed to load image: ${member.imageUrl}',
                                );
                                print('   Error: $error');
                                return const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey,
                                );
                              },
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const CircularProgressIndicator(
                                  strokeWidth: 2,
                                );
                              },
                            ),
                          )
                          : const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          ),
                ),
                const SizedBox(height: 10),
                Tooltip(
                  message: member.name,
                  child: Text(
                    member.name,
                    style: TextStyle(
                      fontSize: isLandscape ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: isLandscape ? 1 : null,
                    overflow:
                        isLandscape
                            ? TextOverflow.ellipsis
                            : TextOverflow.visible,
                  ),
                ),
                const SizedBox(height: 6),

                // 🔥 Designation badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    member.designation,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                _buildContactRow(Icons.phone, member.phone),
                const SizedBox(height: 6),
                _buildContactRow(Icons.email, member.email),
                const SizedBox(height: 6),
                _buildContactRow(Icons.location_on, member.address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ TeamPage widget to display team members
class TeamPage extends StatelessWidget {
  final List<dynamic> teams;
  final bool scrollable;

  const TeamPage({Key? key, required this.teams, this.scrollable = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Parse team data from API response
    final List<TeamMember> teamMembers =
        teams.map((team) {
          return TeamMember(
            id: team['id']?.toString() ?? '',
            name: team['name'] ?? 'Unknown',
            designation: team['designation'] ?? '',
            imageUrl: team['attachment'] ?? '',
            phone: team['phone'] ?? '',
            email: '', // Not in API response
            address: team['address'] ?? '',
            orgName: 'Rampur Municipality', // You can pass this from parent
            orgUnit: 'रामपुर नगरपालिका',
            logoUrl: '', // You can pass this from parent
          );
        }).toList();

    if (teamMembers.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: isLandscape ? 300 : 350,
      child:
          scrollable
              ? ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: teamMembers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: isLandscape ? 220 : 250,
                    child: TeamMemberCard(member: teamMembers[index]),
                  );
                },
              )
              : SingleChildScrollView(
                child: Column(
                  children:
                      teamMembers.map((member) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TeamMemberCard(member: member),
                        );
                      }).toList(),
                ),
              ),
    );
  }
}
