
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Wave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: Hero(
        tag: "wave",
        child: WaveWidget(
//          waveFrequency: 1.0,
          config: CustomConfig(
            gradients: [
              [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
              [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
              [Color(0xFFfc00ff), Color(0xFF00dbde)],
              [Color(0xFF396afc), Color(0xFF2948ff)],
//              [Color(0xFFf65555), Color(0xFFf98686)],
//              [Color(0xFF45ed9c), Color(0xFF74f1b5)],
//              [Color(0xFF8c8c8c), Color(0xFFbfbfbf)],
//              [Color(0xFF4599ed), Color(0xFF74b3f1)],

            ],
            durations: [35000, 19440, 10800, 6000],
            heightPercentages: [0.20, 0.23, 0.25, 0.30],
            blur: MaskFilter.blur(BlurStyle.inner, 5),
            gradientBegin: Alignment.centerLeft,
            gradientEnd: Alignment.centerRight,
          ),
//          duration: 2,
          waveAmplitude: 1,
          size: Size(
            MediaQuery.of(context).size.width,
            100.0,
          ),
        ),
      ),
    );
  }
}
