//BEFORE JSON
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'login_page.dart';
// import './database/database_connection.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => DatabaseConnection()..initialize(), // Optional: init DB
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nagarik Badapatra',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import './wara_badapatra_table.dart';

// Future<void> saveHeaderData() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('userid', '7');
//   await prefs.setString('orgid', '22');
//   await prefs.setString('org_code', 'Bhanu8');
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await saveHeaderData();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Badapatra App',
//       debugShowCheckedModeBanner: false,
//       home: WaraBadapatraTable(),
//     );
//   }
// }

//##################################################################//
//ORIGINAL
// import 'package:flutter/material.dart';
// import 'login_page.dart'; // Adjust if your login page is in a different folder

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nagarik Wada Patra',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const LoginPage(), //  Always goes to LoginPage
//     );
//   }
// }

//#############################################################//
//HIVE INTEGRATION:

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'login_page.dart';
// import 'models/service.dart';
// import './final_homepage.dart';
// import 'services/hive_service.dart'; // Import your HiveService

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Hive and open box via HiveService
//   await HiveService.init();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nagarik Wada Patra',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const LoginPage(),
//     );
//   }
// }

//changed on above:

//OLD MAIN.DART:

// import 'package:flutter/material.dart';
// import 'services/socket_table_service.dart';
// import 'services/hive_service.dart';
// import 'login_page.dart';

// final socketService = SocketTableService(); // global instance

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await HiveService.init();

//   // CONNECT SOCKET
//   socketService.connect(
//     url: 'https://sprta.digitalbadapatra.com',
//     pushingKey: 'YOUR_KEY',
//   );

//   // EVENTS FROM BACKEND
//   socketService.onUniqueIdReceived((uniqueId) {
//     print("🔐 Unique ID from server: $uniqueId");
//   });

//   socketService.onTableUpdate((data) {
//     print("📊 Table updated: $data");
//   });

//   socketService.onYoutubeCommand((videoId) {
//     print("▶️ Play YouTube video: $videoId");
//   });

//   socketService.onAdminRestart(() {
//     print("🔁 Restart command from admin");
//   });

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nagarik Wada Patra',
//       debugShowCheckedModeBanner: false,
//       home: const LoginPage(),
//     );
//   }
// }

//NEW MAIN.DART:

// import 'package:flutter/material.dart';
// import 'services/socket_table_service.dart';
// import 'services/hive_service.dart';
// import 'login_page.dart';

// final socketService = SocketTableService();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await HiveService.init();

//   socketService.connect(
//     url: 'https://sprta.digitalbadapatra.com',
//     pushingKey: 'YOUR_KEY',
//   );

//   socketService.onUniqueIdReceived((uniqueId) {
//     print("🔐 Unique ID from server: $uniqueId");
//   });

//   socketService.onTableUpdate((data) {
//     print("📊 Table updated: $data");
//   });

//   socketService.onAdminRestart(() {
//     print("🔁 Restart command from admin");
//   });

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nagarik Wada Patra',
//       debugShowCheckedModeBanner: false,
//       home: const LoginPage(),
//     );
//   }
// }

//restart:
// import 'package:flutter/material.dart';
// import 'services/socket_table_service.dart';
// import 'services/hive_service.dart';
// import 'login_page.dart';

// final socketService = SocketTableService();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await HiveService.init();

//   socketService.connect(
//     url: 'https://sprta.digitalbadapatra.com',
//     pushingKey: 'YOUR_KEY',
//   );

//   socketService.onUniqueIdReceived((uniqueId) {
//     print("🔐 Unique ID from server: $uniqueId");
//   });

//   socketService.onTableUpdate((data) {
//     print("📊 Table updated: $data");
//   });

//   socketService.onAdminRestart(() {
//     print("🔁 ========== SOCKET: ADMIN RESTART RECEIVED ==========");
//     AppRestartManager.instance.triggerRestart();
//   });

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nagarik Wada Patra',
//       debugShowCheckedModeBanner: false,
//       home: const LoginPage(),
//     );
//   }
// }

// // ============================================
// // App Restart Manager (NEW CLEAN VERSION)
// // ============================================

// class AppRestartManager {
//   static final AppRestartManager _instance = AppRestartManager._internal();
//   static AppRestartManager get instance => _instance;
//   AppRestartManager._internal();

//   final List<VoidCallback> _cleanupCallbacks = [];
//   VoidCallback? _reloadCallback;

//   void registerCleanup(VoidCallback cleanup) {
//     _cleanupCallbacks.add(cleanup);
//   }

//   void removeCleanup(VoidCallback cleanup) {
//     _cleanupCallbacks.remove(cleanup);
//   }

//   void registerReloadCallback(VoidCallback callback) {
//     _reloadCallback = callback;
//   }

//   void triggerRestart() {
//     print("🔄 ========== ADMIN RESTART TRIGGERED ==========");

//     // Execute all cleanups (video stop, dialog close, etc.)
//     for (final cleanup in List.from(_cleanupCallbacks)) {
//       try {
//         cleanup();
//       } catch (e) {
//         print("❌ Cleanup error: $e");
//       }
//     }

//     _cleanupCallbacks.clear();

//     // Reload homepage data
//     _reloadCallback?.call();

//     print("✅ ========== RESTART COMPLETED (STAYED ON HOMEPAGE) ==========");
//   }
// }

//new rampur:
import 'package:flutter/material.dart';
import 'services/socket_table_service.dart';
import 'services/hive_service.dart';
import 'login_page.dart';

final socketService = SocketTableService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // ✅ NEW API ENDPOINT
  socketService.connect(
    url: 'https://digitalbadapatra.com',
    pushingKey: 'YOUR_KEY',
  );

  socketService.onUniqueIdReceived((uniqueId) {
    print("🔐 Unique ID from server: $uniqueId");
  });

  socketService.onTableUpdate((data) {
    print("📊 Table updated: $data");
  });

  socketService.onAdminRestart(() {
    print("🔁 ========== SOCKET: ADMIN RESTART RECEIVED ==========");
    AppRestartManager.instance.triggerRestart();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nagarik Wada Patra',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// ============================================
// App Restart Manager
// ============================================

class AppRestartManager {
  static final AppRestartManager _instance = AppRestartManager._internal();
  static AppRestartManager get instance => _instance;
  AppRestartManager._internal();

  final List<VoidCallback> _cleanupCallbacks = [];
  VoidCallback? _reloadCallback;

  void registerCleanup(VoidCallback cleanup) {
    _cleanupCallbacks.add(cleanup);
  }

  void removeCleanup(VoidCallback cleanup) {
    _cleanupCallbacks.remove(cleanup);
  }

  void registerReloadCallback(VoidCallback callback) {
    _reloadCallback = callback;
  }

  void triggerRestart() {
    print("🔄 ========== ADMIN RESTART TRIGGERED ==========");

    // Execute all cleanups
    for (final cleanup in List.from(_cleanupCallbacks)) {
      try {
        cleanup();
      } catch (e) {
        print("❌ Cleanup error: $e");
      }
    }

    _cleanupCallbacks.clear();

    // Reload homepage data
    _reloadCallback?.call();

    print("✅ ========== RESTART COMPLETED ==========");
  }
}
