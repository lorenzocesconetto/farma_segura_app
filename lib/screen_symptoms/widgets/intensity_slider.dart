import 'package:flutter/material.dart';

class IntensitySlider extends StatefulWidget {
  @override
  _IntensitySliderState createState() => _IntensitySliderState();
}

class _IntensitySliderState extends State<IntensitySlider> {
  double _currentSliderValue = 1;
  @override
  Widget build(BuildContext context) {
    return Slider.adaptive(
        value: _currentSliderValue,
        min: 1,
        max: 4,
        divisions: 3,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() => _currentSliderValue = value);
        });
  }
}
