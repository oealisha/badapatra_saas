//after implementing saas:

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TopNewsBar extends StatelessWidget {
  const TopNewsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔵 News Marquee
        Container(
          width: double.infinity,
          height: 26,
          color: const Color(0xFF2E64C7),
          child: Row(
            children: [
              Material(
                color: const Color(0xFF233072),
                child: Container(
                  height: 16,
                  width: 130,
                  alignment: Alignment.center,
                  child: const Text(
                    '📢 सूचनाहरु:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Marquee(
                  text:
                      '🔴 Latest Updates: Flutter 4.0 released! | Nepal ranks top in tourism | AI advancements reshape industries',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  velocity: 38.0,
                  blankSpace: 20,
                ),
              ),
            ],
          ),
        ),

        // 🔹 Gap between marquee and blue line
        const SizedBox(height: 8),

        // 🔹 Blue horizontal line below the marquee
        Container(width: double.infinity, height: 3, color: Colors.blue),
      ],
    );
  }
}
