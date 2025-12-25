// // lib/services/pusher_service.dart
// import 'dart:convert';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class PusherService {
//   static final PusherService _instance = PusherService._internal();
//   factory PusherService() => _instance;
//   PusherService._internal();

//   PusherChannelsFlutter? _pusher;
//   String? _channelName;

//   Function(String url)? onVideoReceived;

//   Future<void> connect({
//     required String orgId,
//     required Function(String url) onVideo,
//   }) async {
//     onVideoReceived = onVideo;
//     _channelName = "emergency-broadcast-channel.$orgId";

//     _pusher = PusherChannelsFlutter.getInstance();

//     await _pusher!.init(
//       apiKey: "f5e0f21674d914753049",
//       cluster: "ap2",
//       onEvent: _onEvent,
//     );

//     await _pusher!.subscribe(channelName: _channelName!);
//     await _pusher!.connect();
//     print("Pusher connected → $_channelName");
//   }

//   void _onEvent(PusherEvent event) {
//     if (event.eventName == "emergency-broadcast") {
//       String url = "";
//       try {
//         Map json = jsonDecode(event.data);
//         url = json['url'] ?? json['video_url'] ?? event.data;
//       } catch (e) {
//         url = event.data;
//       }
//       onVideoReceived?.call(url.trim());
//     }
//   }

//   void disconnect() {
//     _pusher?.disconnect();
//   }
// }

//time set:

// services/pusher_service.dart

// import 'dart:convert';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class PusherService {
//   static final PusherService _instance = PusherService._internal();
//   factory PusherService() => _instance;
//   PusherService._internal();

//   PusherChannelsFlutter? _pusher;
//   String? _channelName;
//   bool _isConnected = false;

//   Function(String url)? onVideoReceived;

//   Future<void> connect({
//     required String orgId,
//     required String pusherKey,
//     required String cluster,
//     required Function(String url) onVideo,
//   }) async {
//     try {
//       onVideoReceived = onVideo;
//       _channelName = "emergency-broadcast-channel.$orgId";

//       _pusher = PusherChannelsFlutter.getInstance();

//       await _pusher!.init(
//         apiKey: pusherKey, // ✅ required
//         cluster: cluster, // ✅ required
//         onConnectionStateChange: onConnectionStateChange,
//         onError: onError,
//         onSubscriptionSucceeded: onSubscriptionSucceeded,
//         onEvent: onEvent,
//         onSubscriptionError: onSubscriptionError,
//         onDecryptionFailure: onDecryptionFailure,
//         onMemberAdded: onMemberAdded,
//         onMemberRemoved: onMemberRemoved,
//       );

//       await _pusher!.connect();
//       await _pusher!.subscribe(channelName: _channelName!);

//       print("✅ Pusher connected to: $_channelName");
//     } catch (e) {
//       print("❌ Pusher error: $e");
//     }
//   }

//   void onConnectionStateChange(dynamic currentState, dynamic previousState) {
//     print("🔄 Pusher: $previousState -> $currentState");
//     _isConnected = currentState == "CONNECTED";
//   }

//   void onError(String message, int? code, dynamic e) {
//     print("❌ Pusher error: $message");
//   }

//   void onSubscriptionSucceeded(String channelName, dynamic data) {
//     print("✅ Subscribed to: $channelName");
//   }

//   void onSubscriptionError(String message, dynamic e) {
//     print("❌ Subscription error: $message");
//   }

//   void onDecryptionFailure(String event, String reason) {
//     print("❌ Decryption failure: $event");
//   }

//   void onMemberAdded(String channelName, PusherMember member) {}
//   void onMemberRemoved(String channelName, PusherMember member) {}

//   void onEvent(PusherEvent event) {
//     print("📨 Event: ${event.eventName}");
//     print("📦 Data: ${event.data}");

//     if (event.eventName == "emergency-broadcast") {
//       _handleEmergencyBroadcast(event.data);
//     }
//   }

//   void _handleEmergencyBroadcast(String data) {
//     try {
//       String url = "";

//       try {
//         Map<String, dynamic> json = jsonDecode(data);

//         // Try normal fields
//         url =
//             json['youtube_url'] ??
//             json['url'] ??
//             json['video_url'] ??
//             json['link'] ??
//             '';

//         // If empty, try extracting YouTube URL from HTML template
//         if (url.isEmpty && json['template'] != null) {
//           final template = json['template'] as String;

//           // Regex to find YouTube URL
//           final regex = RegExp(
//             r'https?://(www\.)?youtube\.com/watch\?v=[\w-]+(&[\w=&]*)?',
//           );

//           final match = regex.firstMatch(template);
//           if (match != null) {
//             url = match.group(0) ?? '';
//           }
//         }
//       } catch (e) {
//         // Not JSON? Treat as plain URL
//         url = data;
//       }

//       if (url.isNotEmpty) {
//         url = url.trim();
//         print("🎥 Video URL: $url");
//         onVideoReceived?.call(url);
//       } else {
//         print("⚠️ No video URL found in broadcast");
//       }
//     } catch (e) {
//       print("❌ Error parsing emergency broadcast: $e");
//     }
//   }

//   bool get isConnected => _isConnected;

//   Future<void> disconnect() async {
//     try {
//       if (_channelName != null) {
//         await _pusher?.unsubscribe(channelName: _channelName!);
//       }
//       await _pusher?.disconnect();
//       _isConnected = false;
//       print("🔌 Pusher disconnected");
//     } catch (e) {
//       print("❌ Disconnect error: $e");
//     }
//   }
// }

// services/pusher_service.dart

// import 'dart:convert';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class PusherService {
//   static final PusherService _instance = PusherService._internal();
//   factory PusherService() => _instance;
//   PusherService._internal();

//   PusherChannelsFlutter? _pusher;
//   String? _channelName;
//   bool _isConnected = false;

//   Function(String url)? onVideoReceived;

//   Future<void> connect({
//     required String orgId,
//     required String pusherKey,
//     required String cluster,
//     required Function(String url) onVideo,
//   }) async {
//     try {
//       onVideoReceived = onVideo;
//       _channelName = "emergency-broadcast-channel.$orgId";

//       _pusher = PusherChannelsFlutter.getInstance();

//       await _pusher!.init(
//         apiKey: pusherKey, // ✅ required
//         cluster: cluster, // ✅ required
//         onConnectionStateChange: onConnectionStateChange,
//         onError: onError,
//         onSubscriptionSucceeded: onSubscriptionSucceeded,
//         onEvent: onEvent,
//         onSubscriptionError: onSubscriptionError,
//         onDecryptionFailure: onDecryptionFailure,
//         onMemberAdded: onMemberAdded,
//         onMemberRemoved: onMemberRemoved,
//       );

//       await _pusher!.connect();
//       await _pusher!.subscribe(channelName: _channelName!);

//       print("✅ Pusher connected to: $_channelName");
//     } catch (e) {
//       print("❌ Pusher error: $e");
//     }
//   }

//   void onConnectionStateChange(dynamic currentState, dynamic previousState) {
//     print("🔄 Pusher: $previousState -> $currentState");
//     _isConnected = currentState == "CONNECTED";
//   }

//   void onError(String message, int? code, dynamic e) {
//     print("❌ Pusher error: $message");
//   }

//   void onSubscriptionSucceeded(String channelName, dynamic data) {
//     print("✅ Subscribed to: $channelName");
//   }

//   void onSubscriptionError(String message, dynamic e) {
//     print("❌ Subscription error: $message");
//   }

//   void onDecryptionFailure(String event, String reason) {
//     print("❌ Decryption failure: $event");
//   }

//   void onMemberAdded(String channelName, PusherMember member) {}
//   void onMemberRemoved(String channelName, PusherMember member) {}

//   void onEvent(PusherEvent event) {
//     print("📨 Event: ${event.eventName}");
//     print("📦 Data: ${event.data}");

//     if (event.eventName == "emergency-broadcast") {
//       _handleEmergencyBroadcast(event.data);
//     }
//   }

//   void _handleEmergencyBroadcast(String data) {
//     try {
//       String url = "";

//       try {
//         Map<String, dynamic> json = jsonDecode(data);

//         // Try normal fields
//         url =
//             json['youtube_url'] ??
//             json['url'] ??
//             json['video_url'] ??
//             json['link'] ??
//             '';

//         // If empty, try extracting YouTube URL from HTML template
//         if (url.isEmpty && json['template'] != null) {
//           final template = json['template'] as String;

//           // Regex to find YouTube URL
//           final regex = RegExp(
//             r'https?://(www\.)?youtube\.com/watch\?v=[\w-]+(&[\w=&]*)?',
//           );

//           final match = regex.firstMatch(template);
//           if (match != null) {
//             url = match.group(0) ?? '';
//           }
//         }
//       } catch (e) {
//         // Not JSON? Treat as plain URL
//         url = data;
//       }

//       if (url.isNotEmpty) {
//         url = url.trim();
//         print("🎥 Video URL: $url");
//         onVideoReceived?.call(url);
//       } else {
//         print("⚠️ No video URL found in broadcast");
//       }
//     } catch (e) {
//       print("❌ Error parsing emergency broadcast: $e");
//     }
//   }

//   bool get isConnected => _isConnected;

//   Future<void> disconnect() async {
//     try {
//       if (_channelName != null) {
//         await _pusher?.unsubscribe(channelName: _channelName!);
//       }
//       await _pusher?.disconnect();
//       _isConnected = false;
//       print("🔌 Pusher disconnected");
//     } catch (e) {
//       print("❌ Disconnect error: $e");
//     }
//   }
// }

//restart doing: video closed
// pusher_service.dart
// import 'dart:convert';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class PusherService {
//   static final PusherService _instance = PusherService._internal();
//   factory PusherService() => _instance;
//   PusherService._internal();

//   PusherChannelsFlutter? _pusher;
//   String? _broadcastChannelName;
//   String? _restartChannelName;
//   bool _isConnected = false;

//   Function(String url)? onVideoReceived;
//   Function()? onRestart;

//   Future<void> connect({
//     required String orgId,
//     required String pusherKey,
//     required String cluster,
//     required Function(String url) onVideo,
//     required Function() onRestart,
//   }) async {
//     try {
//       onVideoReceived = onVideo;
//       this.onRestart = onRestart;
//       _broadcastChannelName = "emergency-broadcast-channel.$orgId";
//       _restartChannelName = "restart-signage-channel.$orgId";

//       _pusher = PusherChannelsFlutter.getInstance();

//       await _pusher!.init(
//         apiKey: pusherKey,
//         cluster: cluster,
//         onConnectionStateChange: onConnectionStateChange,
//         onError: onError,
//         onSubscriptionSucceeded: onSubscriptionSucceeded,
//         onEvent: onEvent,
//         onSubscriptionError: onSubscriptionError,
//         onDecryptionFailure: onDecryptionFailure,
//         onMemberAdded: onMemberAdded,
//         onMemberRemoved: onMemberRemoved,
//       );

//       await _pusher!.connect();
//       await _pusher!.subscribe(channelName: _broadcastChannelName!);
//       await _pusher!.subscribe(channelName: _restartChannelName!);

//       print(
//         "✅ Pusher connected to: $_broadcastChannelName and $_restartChannelName",
//       );
//     } catch (e) {
//       print("❌ Pusher error: $e");
//     }
//   }

//   void onConnectionStateChange(dynamic currentState, dynamic previousState) {
//     print("🔄 Pusher: $previousState -> $currentState");
//     _isConnected = currentState == "CONNECTED";
//   }

//   void onError(String message, int? code, dynamic e) {
//     print("❌ Pusher error: $message");
//   }

//   void onSubscriptionSucceeded(String channelName, dynamic data) {
//     print("✅ Subscribed to: $channelName");
//   }

//   void onSubscriptionError(String message, dynamic e) {
//     print("❌ Subscription error: $message");
//   }

//   void onDecryptionFailure(String event, String reason) {
//     print("❌ Decryption failure: $event");
//   }

//   void onMemberAdded(String channelName, PusherMember member) {}
//   void onMemberRemoved(String channelName, PusherMember member) {}

//   void onEvent(PusherEvent event) {
//     print("📨 Event: ${event.eventName}");
//     print("📦 Data: ${event.data}");

//     if (event.eventName == "emergency-broadcast") {
//       _handleEmergencyBroadcast(event.data);
//     } else if (event.eventName == "restart-signage") {
//       print("⚠️ Restart signal received");
//       onRestart?.call();
//     }
//   }

//   void _handleEmergencyBroadcast(String data) {
//     try {
//       String url = "";

//       try {
//         Map<String, dynamic> json = jsonDecode(data);

//         url =
//             json['youtube_url'] ??
//             json['url'] ??
//             json['video_url'] ??
//             json['link'] ??
//             '';

//         if (url.isEmpty && json['template'] != null) {
//           final template = json['template'] as String;

//           final regex = RegExp(
//             r'https?://(www\.)?youtube\.com/watch\?v=[\w-]+(&[\w=&]*)?',
//           );

//           final match = regex.firstMatch(template);
//           if (match != null) {
//             url = match.group(0) ?? '';
//           }
//         }
//       } catch (e) {
//         url = data;
//       }

//       url = url.trim();
//       if (url.isNotEmpty) {
//         print("🎥 Video URL: $url");
//         onVideoReceived?.call(url);
//       } else {
//         print("⚠️ No video URL found in broadcast");
//       }
//     } catch (e) {
//       print("❌ Error parsing emergency broadcast: $e");
//     }
//   }

//   bool get isConnected => _isConnected;

//   Future<void> disconnect() async {
//     try {
//       if (_broadcastChannelName != null) {
//         await _pusher?.unsubscribe(channelName: _broadcastChannelName!);
//       }
//       if (_restartChannelName != null) {
//         await _pusher?.unsubscribe(channelName: _restartChannelName!);
//       }
//       await _pusher?.disconnect();
//       _isConnected = false;
//       print("🔌 Pusher disconnected");
//     } catch (e) {
//       print("❌ Disconnect error: $e");
//     }
//   }
// }

//actual restart:

// import 'dart:convert';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class PusherService {
//   static final PusherService _instance = PusherService._internal();
//   factory PusherService() => _instance;
//   PusherService._internal();

//   PusherChannelsFlutter? _pusher;
//   String? _broadcastChannelName;
//   String? _restartChannelName;
//   bool _isConnected = false;

//   Function(String url)? onVideoReceived;
//   Function()? onRestart;

//   /// Connect to Pusher
//   Future<void> connect({
//     required String orgId,
//     required String pusherKey,
//     required String cluster,
//     required Function(String url) onVideo,
//     required Function() onRestart,
//   }) async {
//     // Only enable broadcasting for Rampur
//     if (orgId != "RampurP") {
//       print("🚫 Broadcasting disabled for SaaS org: $orgId");
//       return;
//     }

//     try {
//       onVideoReceived = onVideo;
//       this.onRestart = onRestart;
//       _broadcastChannelName = "emergency-broadcast-channel.$orgId";
//       _restartChannelName = "restart-signage-channel.$orgId";

//       _pusher = PusherChannelsFlutter.getInstance();

//       await _pusher!.init(
//         apiKey: pusherKey,
//         cluster: cluster,
//         onConnectionStateChange: onConnectionStateChange,
//         onError: onError,
//         onSubscriptionSucceeded: onSubscriptionSucceeded,
//         onEvent: onEvent,
//         onSubscriptionError: onSubscriptionError,
//         onDecryptionFailure: onDecryptionFailure,
//         onMemberAdded: onMemberAdded,
//         onMemberRemoved: onMemberRemoved,
//       );

//       await _pusher!.connect();
//       await _pusher!.subscribe(channelName: _broadcastChannelName!);
//       await _pusher!.subscribe(channelName: _restartChannelName!);

//       print(
//         "✅ Pusher connected to: $_broadcastChannelName and $_restartChannelName",
//       );
//     } catch (e) {
//       print("❌ Pusher error: $e");
//     }
//   }

//   void onConnectionStateChange(dynamic currentState, dynamic previousState) {
//     print("🔄 Pusher: $previousState -> $currentState");
//     _isConnected = currentState == "CONNECTED";
//   }

//   void onError(String message, int? code, dynamic e) {
//     print("❌ Pusher error: $message");
//   }

//   void onSubscriptionSucceeded(String channelName, dynamic data) {
//     print("✅ Subscribed to: $channelName");
//   }

//   void onSubscriptionError(String message, dynamic e) {
//     print("❌ Subscription error: $message");
//   }

//   void onDecryptionFailure(String event, String reason) {
//     print("❌ Decryption failure: $event");
//   }

//   void onMemberAdded(String channelName, PusherMember member) {}
//   void onMemberRemoved(String channelName, PusherMember member) {}

//   void onEvent(PusherEvent event) {
//     print("📨 Event: ${event.eventName}");
//     print("📦 Data: ${event.data}");

//     if (event.eventName == "emergency-broadcast") {
//       _handleEmergencyBroadcast(event.data);
//     } else if (event.eventName == "restart-signage") {
//       print("⚠️ Restart signal received");
//       onRestart?.call();
//     }
//   }

//   /// Parse video URL safely
//   void _handleEmergencyBroadcast(String data) {
//     try {
//       String url = "";

//       try {
//         Map<String, dynamic> json = jsonDecode(data);

//         url =
//             json['youtube_url'] ??
//             json['url'] ??
//             json['video_url'] ??
//             json['link'] ??
//             '';

//         if (url.isEmpty && json['template'] != null) {
//           final template = json['template'] as String;

//           final regex = RegExp(
//             r'https?://(www\.)?youtube\.com/watch\?v=[\w-]+(&[\w=&]*)?',
//           );

//           final match = regex.firstMatch(template);
//           if (match != null) {
//             url = match.group(0) ?? '';
//           }
//         }
//       } catch (e) {
//         url = data;
//       }

//       url = url.trim();
//       if (url.isNotEmpty) {
//         print("🎥 Video URL: $url");
//         onVideoReceived?.call(url);
//       } else {
//         print("⚠️ No video URL found in broadcast");
//       }
//     } catch (e) {
//       print("❌ Error parsing emergency broadcast: $e");
//     }
//   }

//   bool get isConnected => _isConnected;

//   Future<void> disconnect() async {
//     try {
//       if (_broadcastChannelName != null) {
//         await _pusher?.unsubscribe(channelName: _broadcastChannelName!);
//       }
//       if (_restartChannelName != null) {
//         await _pusher?.unsubscribe(channelName: _restartChannelName!);
//       }
//       await _pusher?.disconnect();
//       _isConnected = false;
//       print("🔌 Pusher disconnected");
//     } catch (e) {
//       print("❌ Disconnect error: $e");
//     }
//   }
// }

//RAMPUR:
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherChannelsFlutter _pusher =
      PusherChannelsFlutter.getInstance();

  static Future<void> init({
    required String apiKey,
    required String cluster,
    required Function(dynamic) onEmergencyBroadcast,
    required Function(dynamic) onRestartSignage,
  }) async {
    try {
      await _pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: (currentState, previousState) {
          debugPrint('Pusher state: $previousState -> $currentState');
        },
        onError: (message, code, error) {
          debugPrint('Pusher error: $message (code: $code)');
        },
      );

      // Subscribe with per-channel event handlers
      await _pusher.subscribe(
        channelName: 'emergency-broadcast-channel.RampurP',
        onEvent: (PusherEvent event) {
          if (event.eventName == 'emergency-broadcast') {
            onEmergencyBroadcast(event.data);
          }
        },
      );

      await _pusher.subscribe(
        channelName: 'restart-signage-channel.RampurP',
        onEvent: (PusherEvent event) {
          if (event.eventName == 'restart-signage') {
            onRestartSignage(event.data);
          }
        },
      );

      await _pusher.connect();
    } catch (e) {
      debugPrint('Pusher init error: $e');
    }
  }

  static Future<void> disconnect() async {
    await _pusher.unsubscribe(
      channelName: 'emergency-broadcast-channel.RampurP',
    );
    await _pusher.unsubscribe(channelName: 'restart-signage-channel.RampurP');
    await _pusher.disconnect();
  }
}
