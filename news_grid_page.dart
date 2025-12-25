import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import './nepali_tts_newspage.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false, //  This hides the red DEBUG banner
    home: NewsGridPage(),
  ),
);

class NewsGridPage extends StatefulWidget {
  @override
  _NewsGridPageState createState() => _NewsGridPageState();
}

class _NewsGridPageState extends State<NewsGridPage> {
  final int itemCount = 50;
  int _focusedIndex = -1;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();

  Timer? _autoScrollTimer;
  final double _scrollSpeed = 0.5; // Adjust for speed (lower is slower)

  final String description = '''
निवेदन पत्र, आमा बुबाको नागरिकता, जन्म दर्ताको प्रमाणपत्रको प्रतिलिपि। 
विवाहित महिलाको हकमा: पति, आमा, बुबाको नागरिकता वा विवाह दर्ता प्रमाणको प्रतिलिपि।
...
''';

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(Duration(milliseconds: 30), (_) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        if (currentScroll < maxScrollExtent) {
          _scrollController.jumpTo(currentScroll + _scrollSpeed);
        } else {
          // Optional: Loop back to start
          _scrollController.jumpTo(0);
        }
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  // Future<void> _playAudio() async {
  //   await _audioPlayer.play(AssetSource('audio/nepali.mp3'));
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTV = screenSize.width > 1000;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("News Items"),
        backgroundColor: Colors.white,
        elevation: 5,
        toolbarHeight: 80,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: isTV ? 30 : 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          controller: _scrollController,
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTV ? 5 : 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final String title = 'Item $index';
            final bool isFocused = _focusedIndex == index;

            return FocusableActionDetector(
              autofocus: index == 0,
              onShowFocusHighlight: (focused) {
                setState(() {
                  _focusedIndex = focused ? index : -1;
                });
              },
              child: InkWell(
                onTap: () async {
                  //await _playAudio();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => NepaliTTSNewsPage(
                            title: title,
                            description: description,
                          ),
                    ),
                  );
                  await _audioPlayer.stop();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isFocused ? Colors.blueAccent : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: isTV ? 24 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: isTV ? 30 : 20,
                            backgroundImage: AssetImage('assets/logonepal.jpg'),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          color: Colors.grey[300],
                          child: Text(
                            description,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                            softWrap: true,
                            style: TextStyle(fontSize: isTV ? 20 : 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
