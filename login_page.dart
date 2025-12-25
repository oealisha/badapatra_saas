//ORIGINAL:
// import 'package:bada_patra_task/badapatra_table.dart';
// import 'package:bada_patra_task/components/header_section.dart';
// import 'package:bada_patra_task/components/news_broadcast_page.dart';
// import 'package:bada_patra_task/components/sidebar_widget.dart';
// import 'package:bada_patra_task/grid_button.dart';
// import 'package:bada_patra_task/wara_badapatra_table.dart';
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import './home_page.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../config.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import './database/local_database.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   bool _isHovering = false;
//   bool _isLoading = false;
//   bool _isPasswordVisible = false; // Password visibility toggle

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   void _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       if (connectivityResult == ConnectivityResult.none) {
//         _showError('No internet connection. Please check your network.');
//         return;
//       }

//       setState(() => _isLoading = true);
//       final url = Uri.parse('$baseUrl/api/v1/login');

//       try {
//         final response = await http.post(
//           url,
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode({
//             'email': _usernameController.text.trim(),
//             'password': _passwordController.text.trim(),
//           }),
//         );

//         print('Response status: ${response.statusCode}');
//         print('Response body: ${response.body}');

//         final jsonResponse = jsonDecode(response.body);

//         if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//           // Store auth token
//           if (jsonResponse['token'] != null) {
//             await _secureStorage.write(
//               key: 'auth_token',
//               value: jsonResponse['token'],
//             );
//           }

//           // Store userid and orgid
//           final userInfo = jsonResponse['user_info'];
//           if (userInfo != null) {
//             await _secureStorage.write(
//               key: 'userid',
//               value: userInfo['userid'].toString(),
//             );
//             await _secureStorage.write(
//               key: 'orgid',
//               value: userInfo['orgid'].toString(),
//             );
//           }

//           //NAVIGATION:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => WaraBadapatraTable()),
//           );
//         } else {
//           _showError(jsonResponse['message'] ?? 'Login failed. Try again.');
//         }
//       } catch (e) {
//         print('Login error: $e');
//         _showError('An error occurred. Please try again later.');
//       } finally {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   Widget _buildLoginForm() {
//     return Form(
//       key: _formKey,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 400),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Center(
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/images/flag1.gif',
//                     height: 80,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Icon(
//                         Icons.flag,
//                         size: 80,
//                         color: Colors.grey,
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Sign in to your account.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 32),

//             const Text(
//               'Username | Email',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 hintText: 'employee',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your username or email'
//                           : null,
//             ),

//             const SizedBox(height: 20),
//             const Text(
//               'Password',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             // Password field with eye toggle
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible, // false = show, true = hide
//               decoration: InputDecoration(
//                 hintText: '........',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons
//                             .visibility // eye open = password visible
//                         : Icons.visibility_off, // eye closed = password hidden
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isPasswordVisible = !_isPasswordVisible;
//                     });
//                   },
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your password'
//                           : null,
//             ),

//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Forgot password? Click here to reset.',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             MouseRegion(
//               onEnter: (_) => setState(() => _isHovering = true),
//               onExit: (_) => setState(() => _isHovering = false),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 decoration: BoxDecoration(
//                   boxShadow:
//                       _isHovering
//                           ? [
//                             BoxShadow(
//                               color: Colors.blue.withOpacity(0.4),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ]
//                           : [],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _login,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child:
//                         _isLoading
//                             ? const SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                             : const Text('Login'),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 40),
//             const Divider(),
//             const SizedBox(height: 16),
//             const Center(
//               child: Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Copyright ©Xelwell Innovation Pvt. Ltd. 2018-2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: _buildLoginForm(),
//         ),
//       ),
//     );
//   }
// }

//###############################################################################//
//DEADLINE:

// import 'package:bada_patra_task/components/news_broadcast_page.dart';
// import 'package:bada_patra_task/wara_badapatra_table.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../config.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkIfAlreadyLoggedIn(); //Check if user already logged in
//   }

//   Future<void> _checkIfAlreadyLoggedIn() async {
//     final savedToken = await _secureStorage.read(key: 'auth_token');
//     final savedUsername = await _secureStorage.read(key: 'saved_username');
//     final savedPassword = await _secureStorage.read(key: 'saved_password');

//     if (savedToken != null ||
//         (savedUsername != null && savedPassword != null)) {
//       // Token or credentials found → skip login page
//       await Future.delayed(
//         const Duration(milliseconds: 300),
//       ); // slight delay for smoother transition
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const FinalHomePage()),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _saveUserLocally(String username, String password) async {
//     await _secureStorage.write(key: 'saved_username', value: username);
//     await _secureStorage.write(key: 'saved_password', value: password);
//   }

//   Future<bool> _offlineLogin(String username, String password) async {
//     final savedUsername = await _secureStorage.read(key: 'saved_username');
//     final savedPassword = await _secureStorage.read(key: 'saved_password');
//     return savedUsername == username && savedPassword == password;
//   }

//   void _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;

//     setState(() => _isLoading = true);

//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       final url = Uri.parse('$baseUrl/api/v1/login');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': username, 'password': password}),
//       );

//       final jsonResponse = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//         // ✅ Save auth info
//         if (jsonResponse['token'] != null) {
//           await _secureStorage.write(
//             key: 'auth_token',
//             value: jsonResponse['token'],
//           );
//         }

//         final userInfo = jsonResponse['user_info'];
//         if (userInfo != null) {
//           await _secureStorage.write(
//             key: 'userid',
//             value: userInfo['userid'].toString(),
//           );
//           await _secureStorage.write(
//             key: 'orgid',
//             value: userInfo['orgid'].toString(),
//           );
//         }

//         // Save credentials for offline login
//         await _saveUserLocally(username, password);

//         _navigateToHome();
//       } else {
//         // Try offline login if server login fails
//         final offlineSuccess = await _offlineLogin(username, password);
//         if (offlineSuccess) {
//           _navigateToHome();
//         } else {
//           _showError(jsonResponse['message'] ?? 'Login failed. Try again.');
//         }
//       }
//     } catch (e) {
//       // Try offline login in case of network issue
//       final offlineSuccess = await _offlineLogin(username, password);
//       if (offlineSuccess) {
//         _navigateToHome();
//       } else {
//         _showError('An error occurred. Please try again later.');
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const NewsBroadcastPage()),
//     );
//   }

//   Widget _buildLoginForm() {
//     return Form(
//       key: _formKey,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 400),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Center(
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/images/flag1.gif',
//                     height: 80,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Sign in to your account.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Username | Email',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 hintText: 'employee',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your username or email'
//                           : null,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Password',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               decoration: InputDecoration(
//                 hintText: '........',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                   ),
//                   onPressed:
//                       () => setState(
//                         () => _isPasswordVisible = !_isPasswordVisible,
//                       ),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your password'
//                           : null,
//             ),
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Forgot password? Click here to reset.',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _isLoading ? null : _login,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child:
//                     _isLoading
//                         ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                         : const Text('Login'),
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Divider(),
//             const SizedBox(height: 16),
//             const Center(
//               child: Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Copyright ©Xelwell Innovation Pvt. Ltd. 2018-2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: _buildLoginForm(),
//         ),
//       ),
//     );
//   }
// }

//LOGIN PAGE WITH API AND SQLITE: USING SHARED PREFERENCES

// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import './home_page.dart' as home; // Aliased to avoid Service conflict
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../config.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../database/local_database.dart';
// import './badapatra_table.dart';
// import './models/tablemodel.dart' as model; // Aliased for correct Service usage
// import 'wara_badapatra_table.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _isHovering = false;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   void _showSuccess(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.green),
//     );
//   }

//   Future<void> _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       if (connectivityResult == ConnectivityResult.none) {
//         _showError('No internet connection. Please check your network.');
//         return;
//       }

//       setState(() => _isLoading = true);
//       final url = Uri.parse('$baseUrl/api/v1/login');

//       try {
//         final response = await http.post(
//           url,
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode({
//             'email': _usernameController.text.trim(),
//             'password': _passwordController.text.trim(),
//           }),
//         );

//         final jsonResponse = jsonDecode(response.body);

//         if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setString('email', _usernameController.text.trim());
//           await prefs.setString('password', _passwordController.text.trim());

//           final userInfo = jsonResponse['user_info'];
//           String? userId, orgId;
//           if (userInfo != null) {
//             userId = userInfo['userid'].toString();
//             orgId = userInfo['orgid'].toString();
//           }

//           if (jsonResponse['badapatradata'] != null) {
//             try {
//               await LocalDatabase.saveServices(jsonResponse['badapatradata']);
//               _showSuccess(
//                 'Successfully saved ${jsonResponse['badapatradata'].length} services locally',
//               );
//             } catch (e) {
//               _showError(
//                 'Failed to save data offline. Please check your storage.',
//               );
//               return;
//             }
//           }

//           if (userId != null && orgId != null) {
//             await _sendHeaderProtectedRequest(userId, orgId);
//           }

//           if (mounted) {
//             final services =
//                 (jsonResponse['badapatradata'] as List)
//                     .map((e) => model.Service.fromJson(e)) // ✅ Corrected usage
//                     .toList();

//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => WaraBadapatraTable()),
//             );
//           }
//         } else {
//           _showError(
//             jsonResponse['message'] ?? 'Login failed. Please try again.',
//           );
//         }
//       } catch (e) {
//         _showError('An error occurred. Please try again later.');
//       } finally {
//         if (mounted) setState(() => _isLoading = false);
//       }
//     }
//   }

//   Future<void> _sendHeaderProtectedRequest(String userId, String orgId) async {
//     final url = Uri.parse(
//       'http://digitalbadapatra.com/api/v1/get_wara_badapatra',
//     );
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'userid': userId,
//           'orgid': orgId,
//         },
//         body: jsonEncode({'userid': userId, 'orgid': orgId}),
//       );
//       debugPrint('Header-protected API status: ${response.statusCode}');
//       debugPrint('Header-protected API response: ${response.body}');
//     } catch (e) {
//       debugPrint('Header request error: $e');
//     }
//   }

//   Widget _buildLoginForm() {
//     return Form(
//       key: _formKey,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 400),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Center(
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/images/flag1.gif',
//                     height: 80,
//                     errorBuilder:
//                         (_, __, ___) => const Icon(
//                           Icons.flag,
//                           size: 80,
//                           color: Colors.grey,
//                         ),
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const Center(
//               child: Text(
//                 'Sign in to your account.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Username | Email',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       (value == null || value.isEmpty)
//                           ? 'Please enter your username or email'
//                           : null,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Password',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       (value == null || value.isEmpty)
//                           ? 'Please enter your password'
//                           : null,
//             ),
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Forgot password? Click here to reset.',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             MouseRegion(
//               onEnter: (_) => setState(() => _isHovering = true),
//               onExit: (_) => setState(() => _isHovering = false),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 decoration: BoxDecoration(
//                   boxShadow:
//                       _isHovering
//                           ? [
//                             BoxShadow(
//                               color: Colors.blue.withOpacity(0.4),
//                               blurRadius: 10,
//                               offset: Offset(0, 4),
//                             ),
//                           ]
//                           : [],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _login,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child:
//                         _isLoading
//                             ? const SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                             : const Text('Login'),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Divider(),
//             const SizedBox(height: 16),
//             const Center(
//               child: Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Copyright ©Xelwell Innovation Pvt. Ltd. 2018-2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: _buildLoginForm(),
//         ),
//       ),
//     );
//   }
// }

//#####################################################################################//

//###################################################################//

//working:

// import 'package:bada_patra_task/components/news_broadcast_page.dart';
// import 'package:bada_patra_task/wara_badapatra_table.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../config.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _saveUserLocally(String username, String password) async {
//     await _secureStorage.write(key: 'saved_username', value: username);
//     await _secureStorage.write(key: 'saved_password', value: password);
//   }

//   Future<bool> _offlineLogin(String username, String password) async {
//     final savedUsername = await _secureStorage.read(key: 'saved_username');
//     final savedPassword = await _secureStorage.read(key: 'saved_password');
//     return savedUsername == username && savedPassword == password;
//   }

//   void _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;

//     setState(() => _isLoading = true);

//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       // Attempt online login
//       final url = Uri.parse('$baseUrl/api/v1/login');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': username, 'password': password}),
//       );

//       final jsonResponse = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//         // Save auth info
//         if (jsonResponse['token'] != null) {
//           await _secureStorage.write(
//             key: 'auth_token',
//             value: jsonResponse['token'],
//           );
//         }
//         final userInfo = jsonResponse['user_info'];
//         if (userInfo != null) {
//           await _secureStorage.write(
//             key: 'userid',
//             value: userInfo['userid'].toString(),
//           );
//           await _secureStorage.write(
//             key: 'orgid',
//             value: userInfo['orgid'].toString(),
//           );
//         }
//         // Save credentials for offline login
//         await _saveUserLocally(username, password);

//         _navigateToTable();
//       } else {
//         // If online login fails, try offline login
//         final offlineSuccess = await _offlineLogin(username, password);
//         if (offlineSuccess) {
//           _navigateToTable();
//         } else {
//           _showError(jsonResponse['message'] ?? 'Login failed. Try again.');
//         }
//       }
//     } catch (e) {
//       // On any exception (offline), try offline login
//       final offlineSuccess = await _offlineLogin(username, password);
//       if (offlineSuccess) {
//         _navigateToTable();
//       } else {
//         _showError('An error occurred. Please try again later.');
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }

//   }

//   void _navigateToTable() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => FinalHomePage()),
//     );
//   }

//   Widget _buildLoginForm() {
//     return Form(
//       key: _formKey,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 400),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Center(
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/images/flag1.gif',
//                     height: 80,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Sign in to your account.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Username | Email',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 hintText: 'employee',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your username or email'
//                           : null,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Password',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               decoration: InputDecoration(
//                 hintText: '........',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                   ),
//                   onPressed:
//                       () => setState(
//                         () => _isPasswordVisible = !_isPasswordVisible,
//                       ),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your password'
//                           : null,
//             ),
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Forgot password? Click here to reset.',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _isLoading ? null : _login,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child:
//                     _isLoading
//                         ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                         : const Text('Login'),
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Divider(),
//             const SizedBox(height: 16),
//             const Center(
//               child: Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Copyright ©Xelwell Innovation Pvt. Ltd. 2018-2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: _buildLoginForm(),
//         ),
//       ),
//     );
//   }
// }

//#############################################################################################//

//FINGERPRINT:

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:local_auth/local_auth.dart';
// import '../config.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   final LocalAuthentication _localAuth = LocalAuthentication();

//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _saveUserLocally(String username, String password) async {
//     await _secureStorage.write(key: 'saved_username', value: username);
//     await _secureStorage.write(key: 'saved_password', value: password);
//   }

//   Future<bool> _offlineLogin(String username, String password) async {
//     final savedUsername = await _secureStorage.read(key: 'saved_username');
//     final savedPassword = await _secureStorage.read(key: 'saved_password');
//     return savedUsername == username && savedPassword == password;
//   }

//   Future<void> _biometricLogin() async {
//     try {
//       bool canCheck = await _localAuth.canCheckBiometrics;
//       bool isSupported = await _localAuth.isDeviceSupported();

//       if (!canCheck || !isSupported) {
//         _showError('Biometric authentication not available on this device.');
//         return;
//       }

//       bool authenticated = await _localAuth.authenticate(
//         localizedReason: 'Scan your fingerprint or face to login',
//       );

//       if (authenticated) {
//         final username = await _secureStorage.read(key: 'saved_username');
//         final password = await _secureStorage.read(key: 'saved_password');

//         if (username != null && password != null) {
//           final success = await _offlineLogin(username, password);
//           if (success) {
//             _navigateToTable();
//           } else {
//             _showError('Saved credentials not found or invalid.');
//           }
//         } else {
//           _showError(
//             'Please login once manually before using biometric login.',
//           );
//         }
//       }
//     } catch (e) {
//       _showError('Biometric login failed: $e');
//     }
//   }

//   void _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;

//     setState(() => _isLoading = true);

//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       final url = Uri.parse('$baseUrl/api/v1/login');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': username, 'password': password}),
//       );

//       final jsonResponse = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//         if (jsonResponse['token'] != null) {
//           await _secureStorage.write(
//             key: 'auth_token',
//             value: jsonResponse['token'],
//           );
//         }

//         final userInfo = jsonResponse['user_info'];
//         if (userInfo != null) {
//           await _secureStorage.write(
//             key: 'userid',
//             value: userInfo['userid'].toString(),
//           );
//           await _secureStorage.write(
//             key: 'orgid',
//             value: userInfo['orgid'].toString(),
//           );
//         }

//         await _saveUserLocally(username, password);
//         _navigateToTable();
//       } else {
//         final offlineSuccess = await _offlineLogin(username, password);
//         if (offlineSuccess) {
//           _navigateToTable();
//         } else {
//           _showError(jsonResponse['message'] ?? 'Login failed. Try again.');
//         }
//       }
//     } catch (e) {
//       final offlineSuccess = await _offlineLogin(username, password);
//       if (offlineSuccess) {
//         _navigateToTable();
//       } else {
//         _showError('An error occurred. Please try again later.');
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _navigateToTable() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const FinalHomePage()),
//     );
//   }

//   Widget _buildLoginForm() {
//     return Form(
//       key: _formKey,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 400),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Center(
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/images/flag1.gif',
//                     height: 80,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Sign in to your account.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Username | Email',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 hintText: 'Username',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your username or email'
//                           : null,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Password',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               decoration: InputDecoration(
//                 hintText: '********',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                   ),
//                   onPressed:
//                       () => setState(
//                         () => _isPasswordVisible = !_isPasswordVisible,
//                       ),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your password'
//                           : null,
//             ),
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Forgot password? Click here to reset.',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // ✅ Biometric login button
//             Center(
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.fingerprint),
//                 label: const Text("Login with Biometric"),
//                 onPressed: _biometricLogin,
//               ),
//             ),
//             const SizedBox(height: 12),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _isLoading ? null : _login,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child:
//                     _isLoading
//                         ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                         : const Text('Login with Credentials'),
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Divider(),
//             const SizedBox(height: 16),
//             const Center(
//               child: Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Copyright ©Xelwell Innovation Pvt. Ltd. 2018-2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: _buildLoginForm(),
//         ),
//       ),
//     );
//   }
// }

//###########################################################################//

//RESPONSIVE

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:local_auth/local_auth.dart';
// import '../config.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   final LocalAuthentication _localAuth = LocalAuthentication();

//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _saveUserLocally(String username, String password) async {
//     await _secureStorage.write(key: 'saved_username', value: username);
//     await _secureStorage.write(key: 'saved_password', value: password);
//   }

//   Future<bool> _offlineLogin(String username, String password) async {
//     final savedUsername = await _secureStorage.read(key: 'saved_username');
//     final savedPassword = await _secureStorage.read(key: 'saved_password');
//     return savedUsername == username && savedPassword == password;
//   }

//   Future<void> _biometricLogin() async {
//     try {
//       bool canCheck = await _localAuth.canCheckBiometrics;
//       bool isSupported = await _localAuth.isDeviceSupported();

//       if (!canCheck || !isSupported) {
//         _showError('Biometric authentication not available on this device.');
//         return;
//       }

//       bool authenticated = await _localAuth.authenticate(
//         localizedReason: 'Scan your fingerprint or face to login',
//       );

//       if (authenticated) {
//         final username = await _secureStorage.read(key: 'saved_username');
//         final password = await _secureStorage.read(key: 'saved_password');

//         if (username != null && password != null) {
//           final success = await _offlineLogin(username, password);
//           if (success) {
//             _navigateToTable();
//           } else {
//             _showError('Saved credentials not found or invalid.');
//           }
//         } else {
//           _showError(
//             'Please login once manually before using biometric login.',
//           );
//         }
//       }
//     } catch (e) {
//       _showError('Biometric login failed: $e');
//     }
//   }

//   void _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;
//     setState(() => _isLoading = true);

//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       final url = Uri.parse('$baseUrl/api/v1/login');
//       final response = await http
//           .post(
//             url,
//             headers: {'Content-Type': 'application/json'},
//             body: jsonEncode({'email': username, 'password': password}),
//           )
//           .timeout(const Duration(seconds: 10)); // added timeout

//       final jsonResponse = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//         if (jsonResponse['token'] != null) {
//           await _secureStorage.write(
//             key: 'auth_token',
//             value: jsonResponse['token'],
//           );
//         }

//         final userInfo = jsonResponse['user_info'];
//         if (userInfo != null) {
//           await _secureStorage.write(
//             key: 'userid',
//             value: userInfo['userid'].toString(),
//           );
//           await _secureStorage.write(
//             key: 'orgid',
//             value: userInfo['orgid'].toString(),
//           );
//         }

//         await _saveUserLocally(username, password);
//         _navigateToTable();
//       } else {
//         final offlineSuccess = await _offlineLogin(username, password);
//         if (offlineSuccess) {
//           _navigateToTable();
//         } else {
//           _showError(jsonResponse['message'] ?? 'Login failed. Try again.');
//         }
//       }
//     } catch (e) {
//       final offlineSuccess = await _offlineLogin(username, password);
//       if (offlineSuccess) {
//         _navigateToTable();
//       } else {
//         _showError('An error occurred. Please try again later.');
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _navigateToTable() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const FinalHomePage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isLandscape = size.width > size.height;

//     // dynamic sizing
//     final double titleFont = size.width < 600 ? 22 : 26;
//     final double subtitleFont = size.width < 600 ? 14 : 18;
//     final double flagHeight = isLandscape ? 60 : 80;

//     // allow scrolling only when landscape content doesn’t fit
//     final bool needsScroll = isLandscape && size.height < 450;

//     final content = Form(
//       key: _formKey,
//       child: Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: size.width < 600 ? size.width * 0.9 : 500,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/flag1.gif',
//                 height: flagHeight,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'नागरिक वडापत्र',
//                 style: TextStyle(
//                   fontSize: titleFont,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.redAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Login',
//                 style: TextStyle(
//                   fontSize: titleFont,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Sign in to your account',
//                 style: TextStyle(fontSize: subtitleFont, color: Colors.grey),
//               ),
//               const SizedBox(height: 20),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Username | Email',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   hintText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator:
//                     (v) =>
//                         v == null || v.isEmpty
//                             ? 'Enter username or email'
//                             : null,
//               ),
//               const SizedBox(height: 12),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Password',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: !_isPasswordVisible,
//                 decoration: InputDecoration(
//                   hintText: '********',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed:
//                         () => setState(
//                           () => _isPasswordVisible = !_isPasswordVisible,
//                         ),
//                   ),
//                 ),
//                 validator:
//                     (v) => v == null || v.isEmpty ? 'Enter password' : null,
//               ),
//               const SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Forgot password?',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               ElevatedButton.icon(
//                 icon: const Icon(Icons.fingerprint),
//                 label: const Text("Login with Biometric"),
//                 onPressed: _biometricLogin,
//               ),
//               const SizedBox(height: 10),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _login,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child:
//                       _isLoading
//                           ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                           : const Text('Login'),
//                 ),
//               ),

//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 8),
//               const Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 'Copyright © Xelwell Innovation Pvt. Ltd. 2018–2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 10),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body:
//           needsScroll
//               ? SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 24,
//                 ),
//                 child: content,
//               )
//               : Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: content,
//               ),
//     );
//   }
// }

//persistent login :

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:local_auth/local_auth.dart';
// import '../config.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   final LocalAuthentication _localAuth = LocalAuthentication();

//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkPersistentLogin(); // ✅ check saved login
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _saveUserLocally(String username, String password) async {
//     await _secureStorage.write(key: 'saved_username', value: username);
//     await _secureStorage.write(key: 'saved_password', value: password);
//   }

//   Future<bool> _offlineLogin(String username, String password) async {
//     final savedUsername = await _secureStorage.read(key: 'saved_username');
//     final savedPassword = await _secureStorage.read(key: 'saved_password');
//     return savedUsername == username && savedPassword == password;
//   }

//   Future<void> _biometricLogin() async {
//     try {
//       bool canCheck = await _localAuth.canCheckBiometrics;
//       bool isSupported = await _localAuth.isDeviceSupported();

//       if (!canCheck || !isSupported) {
//         _showError('Biometric authentication not available on this device.');
//         return;
//       }

//       bool authenticated = await _localAuth.authenticate(
//         localizedReason: 'Scan your fingerprint or face to login',
//       );

//       if (authenticated) {
//         final username = await _secureStorage.read(key: 'saved_username');
//         final password = await _secureStorage.read(key: 'saved_password');

//         if (username != null && password != null) {
//           final success = await _offlineLogin(username, password);
//           if (success)
//             _navigateToTable();
//           else
//             _showError('Saved credentials not found or invalid.');
//         } else {
//           _showError(
//             'Please login once manually before using biometric login.',
//           );
//         }
//       }
//     } catch (e) {
//       _showError('Biometric login failed: $e');
//     }
//   }

//   // ✅ New: Check persistent login
//   Future<void> _checkPersistentLogin() async {
//     final token = await _secureStorage.read(key: 'auth_token');
//     if (token != null) {
//       // token exists → user already logged in
//       _navigateToTable();
//     }
//   }

//   void _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;
//     setState(() => _isLoading = true);

//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       final url = Uri.parse('$baseUrl/api/v1/login');
//       final response = await http
//           .post(
//             url,
//             headers: {'Content-Type': 'application/json'},
//             body: jsonEncode({'email': username, 'password': password}),
//           )
//           .timeout(const Duration(seconds: 10));

//       final jsonResponse = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//         if (jsonResponse['token'] != null) {
//           await _secureStorage.write(
//             key: 'auth_token',
//             value: jsonResponse['token'],
//           );
//         }

//         final userInfo = jsonResponse['user_info'];
//         if (userInfo != null) {
//           await _secureStorage.write(
//             key: 'userid',
//             value: userInfo['userid'].toString(),
//           );
//           await _secureStorage.write(
//             key: 'orgid',
//             value: userInfo['orgid'].toString(),
//           );
//         }

//         await _saveUserLocally(username, password);
//         _navigateToTable();
//       } else {
//         final offlineSuccess = await _offlineLogin(username, password);
//         if (offlineSuccess)
//           _navigateToTable();
//         else
//           _showError(jsonResponse['message'] ?? 'Login failed. Try again.');
//       }
//     } catch (e) {
//       final offlineSuccess = await _offlineLogin(username, password);
//       if (offlineSuccess)
//         _navigateToTable();
//       else
//         _showError('An error occurred. Please try again later.');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _navigateToTable() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const FinalHomePage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isLandscape = size.width > size.height;

//     final double titleFont = size.width < 600 ? 22 : 26;
//     final double subtitleFont = size.width < 600 ? 14 : 18;
//     final double flagHeight = isLandscape ? 60 : 80;

//     final bool needsScroll = isLandscape && size.height < 450;

//     final content = Form(
//       key: _formKey,
//       child: Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: size.width < 600 ? size.width * 0.9 : 500,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/flag1.gif',
//                 height: flagHeight,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'नागरिक वडापत्र',
//                 style: TextStyle(
//                   fontSize: titleFont,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.redAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Login',
//                 style: TextStyle(
//                   fontSize: titleFont,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Sign in to your account',
//                 style: TextStyle(fontSize: subtitleFont, color: Colors.grey),
//               ),
//               const SizedBox(height: 20),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Username | Email',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   hintText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator:
//                     (v) =>
//                         v == null || v.isEmpty
//                             ? 'Enter username or email'
//                             : null,
//               ),
//               const SizedBox(height: 12),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Password',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: !_isPasswordVisible,
//                 decoration: InputDecoration(
//                   hintText: '********',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed:
//                         () => setState(
//                           () => _isPasswordVisible = !_isPasswordVisible,
//                         ),
//                   ),
//                 ),
//                 validator:
//                     (v) => v == null || v.isEmpty ? 'Enter password' : null,
//               ),
//               const SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Forgot password?',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               ElevatedButton.icon(
//                 icon: const Icon(Icons.fingerprint),
//                 label: const Text("Login with Biometric"),
//                 onPressed: _biometricLogin,
//               ),
//               const SizedBox(height: 10),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _login,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child:
//                       _isLoading
//                           ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                           : const Text('Login'),
//                 ),
//               ),

//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 8),
//               const Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 'Copyright © Xelwell Innovation Pvt. Ltd. 2018–2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 10),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body:
//           needsScroll
//               ? SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 24,
//                 ),
//                 child: content,
//               )
//               : Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: content,
//               ),
//     );
//   }
// }

//OLD LOGIN:

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:local_auth/local_auth.dart';
// import '../config.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   final LocalAuthentication _localAuth = LocalAuthentication();

//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _saveUserLocally(String username, String password) async {
//     await _secureStorage.write(key: 'saved_username', value: username);
//     await _secureStorage.write(key: 'saved_password', value: password);
//   }

//   Future<bool> _offlineLogin(String username, String password) async {
//     final savedUsername = await _secureStorage.read(key: 'saved_username');
//     final savedPassword = await _secureStorage.read(key: 'saved_password');
//     return savedUsername == username && savedPassword == password;
//   }

//   Future<void> _biometricLogin() async {
//     try {
//       bool canCheck = await _localAuth.canCheckBiometrics;
//       bool isSupported = await _localAuth.isDeviceSupported();
//       if (!canCheck || !isSupported) {
//         _showError('Biometric authentication not available.');
//         return;
//       }

//       bool authenticated = await _localAuth.authenticate(
//         localizedReason: 'Scan your fingerprint or face to login',
//       );

//       if (authenticated) {
//         final username = await _secureStorage.read(key: 'saved_username');
//         final password = await _secureStorage.read(key: 'saved_password');
//         if (username != null && password != null) {
//           final success = await _offlineLogin(username, password);
//           if (success)
//             _navigateToHome();
//           else
//             _showError('Saved credentials not found or invalid.');
//         } else {
//           _showError(
//             'Please login once manually before using biometric login.',
//           );
//         }
//       }
//     } catch (e) {
//       _showError('Biometric login failed: $e');
//     }
//   }

//   void _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;
//     setState(() => _isLoading = true);

//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       final url = Uri.parse('$baseUrl/api/v1/login');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': username, 'password': password}),
//       );

//       final jsonResponse = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
//         if (jsonResponse['token'] != null) {
//           await _secureStorage.write(
//             key: 'auth_token',
//             value: jsonResponse['token'],
//           );
//         }
//         final userInfo = jsonResponse['user_info'];
//         if (userInfo != null) {
//           await _secureStorage.write(
//             key: 'userid',
//             value: userInfo['userid'].toString(),
//           );
//           await _secureStorage.write(
//             key: 'orgid',
//             value: userInfo['orgid'].toString(),
//           );
//         }
//         await _saveUserLocally(username, password);
//         _navigateToHome();
//       } else {
//         final offlineSuccess = await _offlineLogin(username, password);
//         if (offlineSuccess)
//           _navigateToHome();
//         else
//           _showError(jsonResponse['message'] ?? 'Login failed.');
//       }
//     } catch (e) {
//       final offlineSuccess = await _offlineLogin(username, password);
//       if (offlineSuccess)
//         _navigateToHome();
//       else
//         _showError('An error occurred. Please try again.');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const FinalHomePage()),
//     );
//   }

//   Widget _buildLoginForm() {
//     final size = MediaQuery.of(context).size;
//     final isLandscape = size.width > size.height;

//     final double imageHeight = isLandscape ? 60 : 80;
//     final double titleFont = isLandscape ? 20 : 22;
//     final double subtitleFont = isLandscape ? 12 : 16;
//     final double fieldSpacing = isLandscape ? 8 : 16;
//     final double sectionSpacing = isLandscape ? 12 : 24;

//     return Form(
//       key: _formKey,
//       child: SizedBox(
//         width: isLandscape ? double.infinity : 400,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Image.asset('assets/images/flag1.gif', height: imageHeight),
//                   SizedBox(height: fieldSpacing / 2),
//                   Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(
//                       fontSize: titleFont,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: sectionSpacing),
//             Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(
//                   fontSize: titleFont,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: fieldSpacing / 2),
//             Center(
//               child: Text(
//                 'Sign in to your account.',
//                 style: TextStyle(fontSize: subtitleFont, color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: sectionSpacing),
//             Text(
//               'Username | Email',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: fieldSpacing / 2),
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 hintText: 'Username',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty
//                           ? 'Enter username or email'
//                           : null,
//             ),
//             SizedBox(height: fieldSpacing),
//             Text(
//               'Password',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: fieldSpacing / 2),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               decoration: InputDecoration(
//                 hintText: '********',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                   ),
//                   onPressed:
//                       () => setState(
//                         () => _isPasswordVisible = !_isPasswordVisible,
//                       ),
//                 ),
//               ),
//               validator:
//                   (value) =>
//                       value == null || value.isEmpty ? 'Enter password' : null,
//             ),
//             SizedBox(height: fieldSpacing / 2),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Forgot password?',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//             SizedBox(height: sectionSpacing / 2),
//             Center(
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.fingerprint),
//                 label: const Text('Login with Biometric'),
//                 onPressed: _biometricLogin,
//               ),
//             ),
//             SizedBox(height: fieldSpacing / 2),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _isLoading ? null : _login,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child:
//                     _isLoading
//                         ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                         : const Text('Login with Credentials'),
//               ),
//             ),
//             SizedBox(height: sectionSpacing / 2),
//             const Divider(),
//             SizedBox(height: fieldSpacing / 2),
//             const Center(
//               child: Text(
//                 'Tech Support: +977-9707379820',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: fieldSpacing / 4),
//             const Center(
//               child: Text(
//                 'Copyright © Xelwell Innovation Pvt. Ltd. 2018-2025',
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: _buildLoginForm(),
//         ),
//       ),
//     );
//   }
// }

//LOGIN_PAGE 2050:

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;

//     setState(() => _isLoading = true);
//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       final url = Uri.parse("https://sprta.digitalbadapatra.com/api/v1/login");
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": username, "password": password}),
//       );

//       final jsonResponse = jsonDecode(response.body);
//       print("API RESPONSE: $jsonResponse");

//       if (jsonResponse["status"] == "success") {
//         final userId = jsonResponse["user_info"]["userid"].toString();
//         final orgId = jsonResponse["user_info"]["orgid"].toString();
//         final orgCode =
//             jsonResponse["organization_info"]["org_code"].toString();
//         final teams = jsonResponse["teams"] ?? [];
//         final orgInfo = jsonResponse["organization_info"] ?? {};
//         final rssItems = jsonResponse["rss_items"] ?? [];
//         final rssType = jsonResponse["rss_type"] ?? "News";

//         // Save secure storage
//         await _secureStorage.write(key: "userid", value: userId);
//         await _secureStorage.write(key: "orgid", value: orgId);
//         await _secureStorage.write(key: "orgCode", value: orgCode);

//         // Navigate to FinalHomePage with all required data
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (_) => FinalHomePage(
//                   userid: userId,
//                   orgid: orgId,
//                   orgCode: orgCode,
//                   teams: teams,
//                   loginData: jsonResponse, // pass full login response
//                 ),
//           ),
//         );
//       } else {
//         _showError(jsonResponse["message"] ?? "Login failed.");
//       }
//     } catch (e) {
//       _showError("An error occurred. Please try again.");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Image.asset('assets/images/flag1.gif', height: 80),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 24),
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: InputDecoration(
//                       labelText: 'Username | Email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     validator:
//                         (value) =>
//                             value == null || value.isEmpty
//                                 ? "Enter username or email"
//                                 : null,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: !_isPasswordVisible,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed:
//                             () => setState(
//                               () => _isPasswordVisible = !_isPasswordVisible,
//                             ),
//                       ),
//                     ),
//                     validator:
//                         (value) =>
//                             value == null || value.isEmpty
//                                 ? "Enter password"
//                                 : null,
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : _login,
//                       child:
//                           _isLoading
//                               ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               )
//                               : const Text("Login"),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Tech Support: +977-9707379820',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//##########################################//
//qr code fix:

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'final_homepage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   bool _isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Login Error'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   Future<void> _login() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;

//     setState(() => _isLoading = true);
//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       final url = Uri.parse("https://sprta.digitalbadapatra.com/api/v1/login");
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": username, "password": password}),
//       );

//       final jsonResponse = jsonDecode(response.body);
//       print("API RESPONSE: $jsonResponse");

//       if (jsonResponse["status"] == "success") {
//         final userId = jsonResponse["user_info"]["userid"].toString();
//         final orgId = jsonResponse["user_info"]["orgid"].toString();
//         final orgCode =
//             jsonResponse["organization_info"]["org_code"].toString();
//         final teams = jsonResponse["teams"] ?? [];
//         final token = jsonResponse["token"]; // ✅ NEW: Extract token

//         // Save secure storage (including token)
//         await _secureStorage.write(key: "userid", value: userId);
//         await _secureStorage.write(key: "orgid", value: orgId);
//         await _secureStorage.write(key: "orgCode", value: orgCode);
//         await _secureStorage.write(
//           key: "token",
//           value: token,
//         ); // ✅ NEW: Save token

//         print("🔑 Token saved: ${token.substring(0, 20)}..."); // ✅ Debug

//         // Navigate to FinalHomePage with all required data
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (_) => FinalHomePage(
//                   userid: userId,
//                   orgid: orgId,
//                   orgCode: orgCode,
//                   teams: teams,
//                   loginData:
//                       jsonResponse, // pass full login response (includes token)
//                   token: token, // ✅ NEW: Pass token explicitly
//                 ),
//           ),
//         );
//       } else {
//         _showError(jsonResponse["message"] ?? "Login failed.");
//       }
//     } catch (e) {
//       print("❌ Login error: $e"); // ✅ Better error logging
//       _showError("An error occurred. Please try again.");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Image.asset('assets/images/flag1.gif', height: 80),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'नागरिक वडापत्र',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 24),
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: InputDecoration(
//                       labelText: 'Username | Email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     validator:
//                         (value) =>
//                             value == null || value.isEmpty
//                                 ? "Enter username or email"
//                                 : null,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: !_isPasswordVisible,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed:
//                             () => setState(
//                               () => _isPasswordVisible = !_isPasswordVisible,
//                             ),
//                       ),
//                     ),
//                     validator:
//                         (value) =>
//                             value == null || value.isEmpty
//                                 ? "Enter password"
//                                 : null,
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : _login,
//                       child:
//                           _isLoading
//                               ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               )
//                               : const Text("Login"),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Tech Support: +977-9707379820',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//#####################################################################################//

//RAMPUR:
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'final_homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Login Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final url = Uri.parse("https://digitalbadapatra.com/api/v1/login");

      print("🚀 Sending login request to: $url");
      print("📧 Email: $username");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": username, "password": password}),
      );

      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode != 200) {
        _showError("Server error: ${response.statusCode}");
        return;
      }

      // Parse JSON response
      final jsonResponse = jsonDecode(response.body);
      print("✅ API RESPONSE STATUS: ${jsonResponse["status"]}");

      if (jsonResponse["status"] == "success") {
        // Debug: Print user info
        print("👤 User Info: ${jsonResponse["user_info"]}");
        print("🏢 Org Info: ${jsonResponse["organization_info"]}");

        // ✅ FIXED: Extract userid (not id) from user_info
        String userId = '';
        if (jsonResponse["user_info"]?["userid"] != null) {
          userId = jsonResponse["user_info"]["userid"].toString();
        } else if (jsonResponse["user_info"]?["id"] != null) {
          userId = jsonResponse["user_info"]["id"].toString();
        }

        final orgCode =
            jsonResponse["organization_info"]?["org_code"]?.toString() ?? '';
        final teams = jsonResponse["teams"] ?? [];
        final token = jsonResponse["token"]?.toString() ?? '';

        // Use org_code for both orgId and orgCode
        final orgId = orgCode;

        // Debug: Print extracted values
        print("🔍 Extracted userId: '$userId'");
        print("🔍 Extracted orgCode: '$orgCode'");
        print("🔍 Extracted token length: ${token.length}");
        print("🔍 Teams count: ${teams.length}");

        // Check for missing required fields
        if (userId.isEmpty) {
          print("❌ ERROR: User ID is empty");
          _showError("Server response missing: User ID");
          return;
        }

        if (orgId.isEmpty) {
          print("❌ ERROR: Organization ID is empty");
          _showError("Server response missing: Organization ID");
          return;
        }

        if (token.isEmpty) {
          print("❌ ERROR: Token is empty");
          _showError("Server response missing: Authentication Token");
          return;
        }

        // All required fields present
        print("✅ All required fields present. Saving to secure storage...");

        // Save to secure storage
        await _secureStorage.write(key: "userid", value: userId);
        await _secureStorage.write(key: "orgid", value: orgId);
        await _secureStorage.write(key: "orgCode", value: orgCode);
        await _secureStorage.write(key: "token", value: token);

        print("💾 Saved to secure storage:");
        print("   - userid: $userId");
        print("   - orgid: $orgId");
        print("   - orgCode: $orgCode");
        print(
          "   - token: ${token.substring(0, token.length > 20 ? 20 : token.length)}...",
        );

        // Navigate to FinalHomePage
        if (mounted) {
          print("🚀 Navigating to FinalHomePage...");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => FinalHomePage(
                    userid: userId,
                    orgid: orgId,
                    orgCode: orgCode,
                    teams: teams,
                    loginData: jsonResponse,
                    token: token,
                  ),
            ),
          );
        }
      } else {
        // Status is not "success"
        final errorMessage = jsonResponse["message"] ?? "Login failed.";
        print("❌ Login failed: $errorMessage");
        _showError(errorMessage);
      }
    } catch (e, stackTrace) {
      print("❌ Login error: $e");
      print("📚 Stack trace: $stackTrace");
      _showError("Network error. Please check your connection and try again.");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/flag1.gif', height: 80),
                  const SizedBox(height: 16),
                  const Text(
                    'नागरिक वडापत्र',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username | Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter username or email"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed:
                            () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            ),
                      ),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter password"
                                : null,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text(
                                "Login",
                                style: TextStyle(fontSize: 16),
                              ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tech Support: +977-9707379820',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
