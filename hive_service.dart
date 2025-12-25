// import 'package:hive_flutter/hive_flutter.dart';
// import '../models/service.dart';

// class HiveService {
//   static const String _boxName = 'services_box';

//   /// Initialize Hive (call this in main.dart before runApp)
//   static Future<void> init() async {
//     await Hive.initFlutter();
//     if (!Hive.isAdapterRegistered(0)) {
//       Hive.registerAdapter(ServiceAdapter());
//     }
//     await Hive.openBox<Service>(_boxName);
//   }

//   /// Save list of services (overwrites old cache)
//   static Future<void> saveServices(List<Service> services) async {
//     final box = Hive.box<Service>(_boxName);
//     await box.clear(); // clear old cache
//     for (var service in services) {
//       await box.add(service);
//     }
//   }

//   /// Retrieve all cached services
//   static List<Service> getServices() {
//     final box = Hive.box<Service>(_boxName);
//     return box.values.toList();
//   }

//   /// Clear cache if needed
//   static Future<void> clearCache() async {
//     final box = Hive.box<Service>(_boxName);
//     await box.clear();
//   }

//   /// Check if cache has data
//   static bool hasData() {
//     final box = Hive.box<Service>(_boxName);
//     return box.isNotEmpty;
//   }
// }

//LOCAL CACHE

import 'package:hive_flutter/hive_flutter.dart';
import '../models/service.dart';

class HiveService {
  static const String _servicesBox = 'services_box';
  static const String _pusherBox = 'pusher_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ServiceAdapter());
    }
    await Future.wait([
      Hive.openBox<Service>(_servicesBox),
      Hive.openBox(_pusherBox),
    ]);
  }

  // Services
  static Future<void> saveServices(List<Service> services) async {
    final box = Hive.box<Service>(_servicesBox);
    await box.clear();
    for (var s in services) await box.add(s);
  }

  static List<Service> getServices() =>
      Hive.box<Service>(_servicesBox).values.toList();

  static Future<void> clearServices() async =>
      await Hive.box<Service>(_servicesBox).clear();

  // Pusher
  static Future<void> savePusherState(
    String apiKey,
    String cluster,
    bool connected,
  ) async {
    final box = Hive.box(_pusherBox);
    await box.put('api_key', apiKey);
    await box.put('cluster', cluster);
    await box.put('connected', connected);
  }

  static Map<String, dynamic>? getPusherState() {
    final box = Hive.box(_pusherBox);
    final apiKey = box.get('api_key');
    final cluster = box.get('cluster');
    if (apiKey == null || cluster == null) return null;
    return {
      'apiKey': apiKey,
      'cluster': cluster,
      'connected': box.get('connected') ?? false,
    };
  }

  // ADMIN DELETE → CLEAR ALL
  static Future<void> clearAllLocalData() async {
    await Future.wait([clearServices(), Hive.box(_pusherBox).clear()]);
    print("All local data cleared by admin"); // ← Fixed
  }
}
