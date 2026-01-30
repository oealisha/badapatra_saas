// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class NewsBroadcastPage extends StatefulWidget {
//   const NewsBroadcastPage({super.key});

//   @override
//   State<NewsBroadcastPage> createState() => _NewsBroadcastPageState();
// }

// class _NewsBroadcastPageState extends State<NewsBroadcastPage> {
//   late YoutubePlayerController _youtubeController;
//   late VideoPlayerController _videoController;

//   @override
//   void initState() {
//     super.initState();

//     // YouTube video
//     _youtubeController = YoutubePlayerController(
//       initialVideoId:
//           YoutubePlayer.convertUrlToId("https://youtu.be/cU4HwAf-zx0")!,
//       flags: const YoutubePlayerFlags(autoPlay: false),
//     );

//     // Optional: normal video
//     _videoController = VideoPlayerController.network(
//         "https://example.com/video.mp4",
//       ) // replace if you want a real MP4
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _youtubeController.dispose();
//     _videoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("News Broadcast")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // YouTube Video
//             YoutubePlayer(
//               controller: _youtubeController,
//               showVideoProgressIndicator: true,
//             ),
//             const SizedBox(height: 20),
//             // Normal video (if you have an MP4)
//             if (_videoController.value.isInitialized)
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   AspectRatio(
//                     aspectRatio: _videoController.value.aspectRatio,
//                     child: VideoPlayer(_videoController),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _videoController.value.isPlaying
//                           ? Icons.pause_circle
//                           : Icons.play_circle,
//                       color: Colors.white,
//                       size: 48,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         if (_videoController.value.isPlaying) {
//                           _videoController.pause();
//                         } else {
//                           _videoController.play();
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


