
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Wave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
            [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
            [Color(0xFFfc00ff), Color(0xFF00dbde)],
            [Color(0xFF396afc), Color(0xFF2948ff)],
          ],
          durations: [35000, 19440, 10800, 6000],
          heightPercentages: [0.20, 0.23, 0.25, 0.30],
          blur: MaskFilter.blur(BlurStyle.inner, 5),
          gradientBegin: Alignment.centerLeft,
          gradientEnd: Alignment.centerRight,
        ),
        waveAmplitude: 1,
        size: Size(
          MediaQuery.of(context).size.width,
          100.0,
        ),
      ),
    );
  }
}
