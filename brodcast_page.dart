// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class BroadcastPage extends StatefulWidget {
//   final String type; // "video", "youtube", "audio", "image", "text"
//   final String url; // URL or text
//   final int duration; // seconds
//   final String orgId; // dynamic organization ID for restart channel

//   const BroadcastPage({
//     super.key,
//     required this.type,
//     required this.url,
//     required this.duration,
//     required this.orgId,
//   });

//   @override
//   State<BroadcastPage> createState() => _BroadcastPageState();
// }

// class _BroadcastPageState extends State<BroadcastPage>
//     with SingleTickerProviderStateMixin {
//   VideoPlayerController? _videoController;
//   YoutubePlayerController? _ytController;
//   AudioPlayer? _audioPlayer;
//   Timer? _closeTimer;

//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_fadeController);

//     _initBroadcast();
//     _initPusherListener();
//   }

//   // Initialize broadcast content
//   void _initBroadcast() {
//     switch (widget.type.toLowerCase()) {
//       case 'video':
//         _videoController = VideoPlayerController.network(widget.url)
//           ..initialize().then((_) {
//             if (mounted) {
//               setState(() {});
//               _videoController!.play();
//               _fadeController.forward();
//             }
//           });
//         break;

//       case 'youtube':
//         final videoId = YoutubePlayer.convertUrlToId(widget.url);
//         if (videoId != null) {
//           _ytController = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//           );
//           _fadeController.forward();
//         }
//         break;

//       case 'audio':
//         _audioPlayer = AudioPlayer()..play(UrlSource(widget.url));
//         _fadeController.forward();
//         break;

//       case 'image':
//       case 'text':
//         _fadeController.forward();
//         break;

//       default:
//         debugPrint('⚠️ Unknown broadcast type: ${widget.type}');
//     }

//     // Auto-close timer
//     if (widget.duration > 0) {
//       _closeTimer?.cancel(); // cancel previous timer if exists
//       _closeTimer = Timer(Duration(seconds: widget.duration), () {
//         if (mounted) _closeBroadcast();
//       });
//     }
//   }

//   // Initialize Pusher listener
//   void _initPusherListener() async {
//     try {
//       await _pusher.init(
//         apiKey: 'f5e0f21674d914753049', // replace with your key
//         cluster: 'ap2',
//         onEvent: (event) {
//           if (event.data == null) return;

//           debugPrint("📡 Event: ${event.channelName} → ${event.eventName}");
//           final data = json.decode(event.data);

//           // NEWS broadcast
//           if (event.channelName == 'news-channel') {
//             final type = data['type'] ?? 'text';
//             final url = data['content'] ?? '';
//             final duration = data['duration'] ?? 10;

//             if (mounted && (ModalRoute.of(context)?.isCurrent ?? false)) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (_) => BroadcastPage(
//                         type: type,
//                         url: url,
//                         duration: duration,
//                         orgId: widget.orgId,
//                       ),
//                 ),
//               );
//             }
//           }
//           // RESTART broadcast
//           else if (event.channelName ==
//               'restart-signage-channel.${widget.orgId}') {
//             debugPrint('🔁 Restart command received!');
//             if (mounted) _closeBroadcast();
//           }
//         },
//       );

//       await _pusher.connect();

//       // Subscribe to channels
//       await _pusher.subscribe(channelName: 'news-channel');
//       await _pusher.subscribe(
//         channelName: 'restart-signage-channel.${widget.orgId}',
//       );

//       debugPrint(
//         "✅ Subscribed to news-channel and restart-signage-channel.${widget.orgId}",
//       );
//     } catch (e) {
//       debugPrint('❌ Pusher init error: $e');
//     }
//   }

//   void _closeBroadcast() {
//     _fadeController.reverse().then((_) {
//       _videoController?.pause();
//       _ytController?.pause();
//       _audioPlayer?.stop();

//       if (Navigator.canPop(context)) Navigator.pop(context);
//     });
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     _ytController?.dispose();
//     _audioPlayer?.dispose();
//     _closeTimer?.cancel();
//     _pusher.disconnect();
//     _fadeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget content;

//     switch (widget.type.toLowerCase()) {
//       case 'video':
//         content =
//             _videoController != null && _videoController!.value.isInitialized
//                 ? Center(
//                   child: AspectRatio(
//                     aspectRatio: _videoController!.value.aspectRatio,
//                     child: VideoPlayer(_videoController!),
//                   ),
//                 )
//                 : const Center(child: CircularProgressIndicator());
//         break;

//       case 'youtube':
//         content =
//             _ytController != null
//                 ? YoutubePlayer(
//                   controller: _ytController!,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: Colors.red,
//                 )
//                 : const Center(child: CircularProgressIndicator());
//         break;

//       case 'audio':
//         content = const Center(
//           child: Icon(Icons.audiotrack, size: 120, color: Colors.white),
//         );
//         break;

//       case 'image':
//         content = Center(child: Image.network(widget.url, fit: BoxFit.contain));
//         break;

//       case 'text':
//         content = Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               widget.url,
//               style: const TextStyle(
//                 fontSize: 28,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//         break;

//       default:
//         content = const Center(
//           child: Text(
//             'Unknown broadcast type',
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//     }

//     return RawKeyboardListener(
//       focusNode: FocusNode()..requestFocus(),
//       onKey: (RawKeyEvent event) {
//         if (event is RawKeyDownEvent &&
//             (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
//                 event.character == '*')) {
//           _closeBroadcast();
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Stack(children: [Positioned.fill(child: content)]),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class BroadcastPage extends StatefulWidget {
//   final String type;
//   final String url;
//   final int duration;
//   final String orgId;

//   const BroadcastPage({
//     super.key,
//     required this.type,
//     required this.url,
//     required this.duration,
//     required this.orgId,
//   });

//   @override
//   State<BroadcastPage> createState() => _BroadcastPageState();
// }

// class _BroadcastPageState extends State<BroadcastPage>
//     with SingleTickerProviderStateMixin {
//   VideoPlayerController? _videoController;
//   YoutubePlayerController? _ytController;
//   AudioPlayer? _audioPlayer;
//   Timer? _closeTimer;

//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_fadeController);

//     _initBroadcast();
//     _initPusherListener();
//     _restoreForcedChannel();
//   }

//   void _initBroadcast() {
//     switch (widget.type.toLowerCase()) {
//       case 'video':
//         _videoController = VideoPlayerController.network(widget.url)
//           ..initialize().then((_) {
//             if (mounted) {
//               setState(() {});
//               _videoController!.play();
//               _fadeController.forward();
//             }
//           });
//         break;

//       case 'youtube':
//         final videoId = YoutubePlayer.convertUrlToId(widget.url);
//         if (videoId != null) {
//           _ytController = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//           );
//           _fadeController.forward();
//         }
//         break;

//       case 'audio':
//         _audioPlayer = AudioPlayer()..play(UrlSource(widget.url));
//         _fadeController.forward();
//         break;

//       case 'image':
//       case 'text':
//         _fadeController.forward();
//         break;

//       default:
//         debugPrint('Unknown type: ${widget.type}');
//     }

//     if (widget.duration > 0) {
//       _closeTimer?.cancel();
//       _closeTimer = Timer(Duration(seconds: widget.duration), () {
//         if (mounted) _closeBroadcast();
//       });
//     }
//   }

//   // FETCH PUSHER CONFIG FROM BACKEND
//   Future<Map<String, String>> _fetchPusherConfig() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://your-backend.com/api/pusher-config'),
//         headers: {'org-id': widget.orgId},
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return {
//           'apiKey': data['apiKey'] ?? 'fallback_key',
//           'cluster': data['cluster'] ?? 'ap2',
//         };
//       }
//     } catch (e) {
//       debugPrint('Config fetch error: $e');
//     }

//     return {'apiKey': 'f5e0f21674d914753049', 'cluster': 'ap2'};
//   }

//   // PUSHER: DYNAMIC + SAVE + RESTORE
//   void _initPusherListener() async {
//     try {
//       final config = await _fetchPusherConfig();

//       await _pusher.init(
//         apiKey: config['apiKey']!,
//         cluster: config['cluster']!,
//         onEvent: (event) async {
//           if (event.data == null) return;

//           debugPrint("Event: ${event.eventName} → ${event.channelName}");

//           // FORCED SUBSCRIBE
//           if (event.eventName == 'pusher:subscribe') {
//             final data = json.decode(event.data);
//             final channel = data['data']['channel'] as String;
//             final auth = data['data']['auth'] ?? '';

//             debugPrint("Forced subscribe: $channel");

//             final box = await Hive.openBox('pusher_box');
//             await box.put('forced_channel', channel);
//             await box.put('forced_auth', auth);
//             await box.put(
//               'last_subscribed_at',
//               DateTime.now().toIso8601String(),
//             );

//             await _pusher.subscribe(channelName: channel);
//           }
//           // NEWS
//           else if (event.channelName == 'news-channel') {
//             final data = json.decode(event.data);
//             final type = data['type'] ?? 'text';
//             final url = data['content'] ?? '';
//             final duration = data['duration'] ?? 10;

//             if (mounted && (ModalRoute.of(context)?.isCurrent ?? false)) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (_) => BroadcastPage(
//                         type: type,
//                         url: url,
//                         duration: duration,
//                         orgId: widget.orgId,
//                       ),
//                 ),
//               );
//             }
//           }
//           // RESTART
//           else if (event.channelName ==
//               'restart-signage-channel.${widget.orgId}') {
//             debugPrint('Restart command!');
//             if (mounted) _closeBroadcast();
//           }
//         },
//       );

//       await _pusher.connect();

//       await _pusher.subscribe(channelName: 'news-channel');
//       await _pusher.subscribe(
//         channelName: 'restart-signage-channel.${widget.orgId}',
//       );

//       final box = await Hive.openBox('pusher_box');
//       await box.put('default_org', widget.orgId);
//     } catch (e) {
//       debugPrint('Pusher error: $e');
//     }
//   }

//   // RESTORE FORCED CHANNEL ON RESTART
//   Future<void> _restoreForcedChannel() async {
//     try {
//       final box = await Hive.openBox('pusher_box');
//       final channel = box.get('forced_channel') as String?;

//       if (channel != null) {
//         debugPrint("Restoring: $channel");
//         await _pusher.subscribe(channelName: channel);
//       }
//     } catch (e) {
//       debugPrint("Restore failed: $e");
//     }
//   }

//   void _closeBroadcast() {
//     _fadeController.reverse().then((_) {
//       _videoController?.pause();
//       _ytController?.pause();
//       _audioPlayer?.stop();
//       if (Navigator.canPop(context)) Navigator.pop(context);
//     });
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     _ytController?.dispose();
//     _audioPlayer?.dispose();
//     _closeTimer?.cancel();
//     _pusher.disconnect();
//     _fadeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget content;

//     switch (widget.type.toLowerCase()) {
//       case 'video':
//         content =
//             _videoController != null && _videoController!.value.isInitialized
//                 ? Center(
//                   child: AspectRatio(
//                     aspectRatio: _videoController!.value.aspectRatio,
//                     child: VideoPlayer(_videoController!),
//                   ),
//                 )
//                 : const Center(child: CircularProgressIndicator());
//         break;

//       case 'youtube':
//         content =
//             _ytController != null
//                 ? YoutubePlayer(
//                   controller: _ytController!,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: Colors.red,
//                 )
//                 : const Center(child: CircularProgressIndicator());
//         break;

//       case 'audio':
//         content = const Center(
//           child: Icon(Icons.audiotrack, size: 120, color: Colors.white),
//         );
//         break;

//       case 'image':
//         content = Center(child: Image.network(widget.url, fit: BoxFit.contain));
//         break;

//       case 'text':
//         content = Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               widget.url,
//               style: const TextStyle(
//                 fontSize: 28,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//         break;

//       default:
//         content = const Center(
//           child: Text('Unknown type', style: TextStyle(color: Colors.white)),
//         );
//     }

//     return RawKeyboardListener(
//       focusNode: FocusNode()..requestFocus(),
//       onKey: (event) {
//         if (event is RawKeyDownEvent &&
//             (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
//                 event.character == '*')) {
//           _closeBroadcast();
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Stack(children: [Positioned.fill(child: content)]),
//         ),
//       ),
//     );
//   }
// }

//before:

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class BroadcastPage extends StatefulWidget {
//   final String type;
//   final String url;
//   final int duration;
//   final String orgId;

//   const BroadcastPage({
//     super.key,
//     required this.type,
//     required this.url,
//     required this.duration,
//     required this.orgId,
//   });

//   @override
//   State<BroadcastPage> createState() => _BroadcastPageState();
// }

// class _BroadcastPageState extends State<BroadcastPage>
//     with SingleTickerProviderStateMixin {
//   // ──────────────────────────────────────────────────────────────
//   // Controllers
//   VideoPlayerController? _videoController;
//   YoutubePlayerController? _ytController;
//   AudioPlayer? _audioPlayer;
//   Timer? _closeTimer;

//   // Pusher
//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

//   // UI
//   late final AnimationController _fadeController;
//   late final Animation<double> _fadeAnimation;

//   // -----------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();

//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_fadeController);

//     _initBroadcast();
//     _restorePusherState();
//     _initPusherListener();
//     _restoreForcedChannel();
//   }

//   // -----------------------------------------------------------------
//   // 1. Media handling
//   void _initBroadcast() {
//     switch (widget.type.toLowerCase()) {
//       case 'video':
//         _videoController = VideoPlayerController.network(widget.url)
//           ..initialize().then((_) {
//             if (mounted) {
//               setState(() {});
//               _videoController!.play();
//               _fadeController.forward();
//             }
//           });
//         break;

//       case 'youtube':
//         final videoId = YoutubePlayer.convertUrlToId(widget.url);
//         if (videoId != null) {
//           _ytController = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//           );
//           _fadeController.forward();
//         }
//         break;

//       case 'audio':
//         _audioPlayer = AudioPlayer()..play(UrlSource(widget.url));
//         _fadeController.forward();
//         break;

//       case 'image':
//       case 'text':
//         _fadeController.forward();
//         break;

//       default:
//         debugPrint('Unknown broadcast type: ${widget.type}');
//     }

//     if (widget.duration > 0) {
//       _closeTimer?.cancel();
//       _closeTimer = Timer(Duration(seconds: widget.duration), () {
//         if (mounted) _closeBroadcast();
//       });
//     }
//   }

//   // -----------------------------------------------------------------
//   // 2. Fetch Pusher config from backend
//   Future<Map<String, String>> _fetchPusherConfig() async {
//     try {
//       final resp = await http.get(
//         Uri.parse('https://your-backend.com/api/pusher-config'),
//         headers: {'org-id': widget.orgId},
//       );

//       if (resp.statusCode == 200) {
//         final data = json.decode(resp.body);
//         return {
//           'apiKey': data['apiKey'] ?? '',
//           'cluster': data['cluster'] ?? '',
//         };
//       }
//     } catch (e) {
//       debugPrint('Config fetch error: $e');
//     }

//     return {'apiKey': 'f5e0f21674d914753049', 'cluster': 'ap2'};
//   }

//   // -----------------------------------------------------------------
//   // 3. Save full Pusher state
//   Future<void> _savePusherState(String apiKey, String cluster) async {
//     try {
//       final box = await Hive.openBox('pusher_box');
//       await box.put('pusher_connected', _pusher.connectionState == 'CONNECTED');
//       await box.put('last_connected_at', DateTime.now().toIso8601String());
//       await box.put('api_key', apiKey);
//       await box.put('cluster', cluster);
//       debugPrint('Pusher state saved');
//     } catch (e) {
//       debugPrint('Save failed: $e');
//     }
//   }

//   // -----------------------------------------------------------------
//   // 4. Restore Pusher state
//   Future<void> _restorePusherState() async {
//     try {
//       final box = await Hive.openBox('pusher_box');
//       final wasConnected = box.get('pusher_connected') ?? false;
//       final apiKey = box.get('api_key');
//       final cluster = box.get('cluster');

//       if (wasConnected && apiKey != null && cluster != null) {
//         debugPrint('Restoring Pusher from Hive');
//         await _pusher.init(apiKey: apiKey, cluster: cluster);
//         await _pusher.connect();
//       }
//     } catch (e) {
//       debugPrint('Restore failed: $e');
//     }
//   }

//   // -----------------------------------------------------------------
//   // 5. Initialise Pusher
//   Future<void> _initPusherListener() async {
//     try {
//       final cfg = await _fetchPusherConfig();

//       await _pusher.init(
//         apiKey: cfg['apiKey']!,
//         cluster: cfg['cluster']!,
//         onConnectionStateChange: (current, _) {
//           if (current == 'CONNECTED') {
//             _savePusherState(cfg['apiKey']!, cfg['cluster']!);
//           }
//         },
//         onEvent: (event) async {
//           if (event.data == null) return;
//           debugPrint("Event: ${event.eventName} → ${event.channelName}");

//           // FORCED SUBSCRIBE
//           if (event.eventName == 'pusher:subscribe') {
//             final data = json.decode(event.data);
//             final channel = data['data']['channel'] as String;
//             final auth = data['data']['auth'] ?? '';

//             final box = await Hive.openBox('pusher_box');
//             await box.put('forced_channel', channel);
//             await box.put('forced_auth', auth);
//             await box.put(
//               'last_subscribed_at',
//               DateTime.now().toIso8601String(),
//             );

//             await _pusher.subscribe(channelName: channel);
//           }
//           // NEWS
//           else if (event.channelName == 'news-channel') {
//             final data = json.decode(event.data);
//             final type = data['type'] ?? 'text';
//             final url = data['content'] ?? '';
//             final duration = data['duration'] ?? 10;

//             if (mounted && (ModalRoute.of(context)?.isCurrent ?? false)) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (_) => BroadcastPage(
//                         type: type,
//                         url: url,
//                         duration: duration,
//                         orgId: widget.orgId,
//                       ),
//                 ),
//               );
//             }
//           }
//           // RESTART + SAVE
//           else if (event.channelName ==
//               'restart-signage-channel.${widget.orgId}') {
//             debugPrint('Restart command — saving state');
//             await _savePusherState(cfg['apiKey']!, cfg['cluster']!);
//             if (mounted) _closeBroadcast();
//           }
//           // CLEAR CACHE
//           else if (event.channelName == 'clear-data-channel' &&
//               event.eventName == 'clear-cache') {
//             final data = json.decode(event.data);
//             if (data['orgId'] == widget.orgId) {
//               await _clearLocalCache();
//             }
//           }
//         },
//       );

//       await _pusher.connect();

//       await _pusher.subscribe(channelName: 'news-channel');
//       await _pusher.subscribe(
//         channelName: 'restart-signage-channel.${widget.orgId}',
//       );

//       final box = await Hive.openBox('pusher_box');
//       await box.put('default_org', widget.orgId);
//     } catch (e) {
//       debugPrint('Pusher init error: $e');
//     }
//   }

//   // -----------------------------------------------------------------
//   // 6. Restore forced channel
//   Future<void> _restoreForcedChannel() async {
//     try {
//       final box = await Hive.openBox('pusher_box');
//       final channel = box.get('forced_channel') as String?;

//       if (channel != null) {
//         debugPrint('Restoring forced channel: $channel');
//         await _pusher.subscribe(channelName: channel);
//       }
//     } catch (e) {
//       debugPrint('Restore failed: $e');
//     }
//   }

//   // -----------------------------------------------------------------
//   // 7. Clear local cache
//   Future<void> _clearLocalCache() async {
//     try {
//       final box = await Hive.openBox('pusher_box');
//       await box.clear();
//       debugPrint("Local cache cleared");

//       await _pusher.disconnect();
//       await _initPusherListener();
//     } catch (e) {
//       debugPrint("Clear failed: $e");
//     }
//   }

//   // -----------------------------------------------------------------
//   // Close broadcast
//   void _closeBroadcast() {
//     _fadeController.reverse().then((_) {
//       _videoController?.pause();
//       _ytController?.pause();
//       _audioPlayer?.stop();
//       if (Navigator.canPop(context)) Navigator.pop(context);
//     });
//   }

//   // -----------------------------------------------------------------
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     _ytController?.dispose();
//     _audioPlayer?.dispose();
//     _closeTimer?.cancel();
//     _pusher.disconnect();
//     _fadeController.dispose();
//     super.dispose();
//   }

//   // -----------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     Widget content;

//     switch (widget.type.toLowerCase()) {
//       case 'video':
//         content =
//             _videoController != null && _videoController!.value.isInitialized
//                 ? Center(
//                   child: AspectRatio(
//                     aspectRatio: _videoController!.value.aspectRatio,
//                     child: VideoPlayer(_videoController!),
//                   ),
//                 )
//                 : const Center(child: CircularProgressIndicator());
//         break;

//       case 'youtube':
//         content =
//             _ytController != null
//                 ? YoutubePlayer(
//                   controller: _ytController!,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: Colors.red,
//                 )
//                 : const Center(child: CircularProgressIndicator());
//         break;

//       case 'audio':
//         content = const Center(
//           child: Icon(Icons.audiotrack, size: 120, color: Colors.white),
//         );
//         break;

//       case 'image':
//         content = Center(child: Image.network(widget.url, fit: BoxFit.contain));
//         break;

//       case 'text':
//         content = Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               widget.url,
//               style: const TextStyle(
//                 fontSize: 28,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//         break;

//       default:
//         content = const Center(
//           child: Text('Unknown type', style: TextStyle(color: Colors.white)),
//         );
//     }

//     return RawKeyboardListener(
//       focusNode: FocusNode()..requestFocus(),
//       onKey: (event) {
//         if (event is RawKeyDownEvent &&
//             (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
//                 event.character == '*')) {
//           _closeBroadcast();
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Stack(children: [Positioned.fill(child: content)]),
//         ),
//       ),
//     );
//   }
// }

//after:
// broadcast_page.dart
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

class BroadcastPage extends StatefulWidget {
  final String type; // 'video', 'youtube', 'image', 'text'
  final String url;
  final int duration;
  final String orgId;

  const BroadcastPage({
    super.key,
    required this.type,
    required this.url,
    required this.duration,
    required this.orgId,
  });

  @override
  State<BroadcastPage> createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  VideoPlayerController? _videoController;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();

    if (widget.type == 'video') {
      _videoController = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {});
          _videoController?.play();
        });
    } else if (widget.type == 'youtube') {
      _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url) ?? '',
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
      );
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            widget.type == 'video' && _videoController != null
                ? VideoPlayer(_videoController!)
                : widget.type == 'youtube' && _youtubeController != null
                ? YoutubePlayer(controller: _youtubeController!)
                : Text('Unsupported broadcast type'),
      ),
    );
  }
}
