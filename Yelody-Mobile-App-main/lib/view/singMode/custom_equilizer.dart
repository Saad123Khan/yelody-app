import 'package:flutter/material.dart';
import 'dart:async';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class CustomEQ extends StatefulWidget {
  const CustomEQ(this.enabled, this.bandLevelRange);

  final bool enabled;
  final List<int> bandLevelRange;

  @override
  _CustomEQState createState() => _CustomEQState();
}

class _CustomEQState extends State<CustomEQ> {
  late double min, max;
  String? _selectedValue;
  late Future<List<String>> fetchPresets;

  @override
  void initState() {
    super.initState();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();
    fetchPresets = EqualizerFlutter.getPresetNames();
  }

  @override
  Widget build(BuildContext context) {
    int bandId = 0;

    return FutureBuilder<List<int>>(
      future: EqualizerFlutter.getCenterBandFreqs(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!
                        .map((freq) => _buildSliderBand(freq, bandId))
                        .toList(),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: _buildPresets(),
                  ),
                ],
              )
            : const CircularProgressIndicator();
      },
    );
  }

  Widget _buildSliderBand(int freq, int bandId) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            child: FutureBuilder<int>(
              future: EqualizerFlutter.getBandLevel(bandId),
              builder: (context, snapshot) {
                var data = snapshot.data?.toDouble() ?? 0.0;
                return RotatedBox(
                  quarterTurns: 1,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 1, trackShape: SliderCustomTrackShape()),
                    child: Center(
                      child: Slider(
                        min: min,
                        max: max,
                        value: data,
                        onChanged: (lowerValue) {
                          if (widget.enabled) {
                            EqualizerFlutter.setBandLevel(
                                bandId, lowerValue.toInt());
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text('${freq ~/ 1000} Hz'),
        ],
      ),
    );
  }

  // Widget _buildSliderBand(int freq, int bandId) {
  //   return Expanded(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 250,
  //           child: FutureBuilder<int>(
  //             future: EqualizerFlutter.getBandLevel(bandId),
  //             builder: (context, snapshot) {
  //               var data = snapshot.data?.toDouble() ?? 0.0;
  //               return RotatedBox(
  //                 quarterTurns: 1,
  //                 child: SliderTheme(
  //                   data: SliderTheme.of(context).copyWith(
  //                       trackHeight: 1, trackShape: SliderCustomTrackShape()),
  //                   child: Center(
  //                     child: Slider(
  //                       activeColor: AppColor.primaryColor,
  //                       min: min,
  //                       max: max,
  //                       value: data,
  //                       onChanged: (lowerValue) {
  //                         EqualizerFlutter.setBandLevel(
  //                             bandId, lowerValue.toInt());
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         Text('${freq ~/ 1000} Hz'),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPresets() {
    return FutureBuilder<List<String>>(
      future: fetchPresets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final presets = snapshot.data;
          if (presets!.isEmpty) return Text('No presets available!');
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Available Presets',
              border: OutlineInputBorder(),
            ),
            value: _selectedValue,
            onChanged: widget.enabled
                ? (String? value) {
                    EqualizerFlutter.setPreset(value!);
                    setState(() {
                      _selectedValue = value;
                    });
                  }
                : null,
            items: presets.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        } else if (snapshot.hasError)
          return Text(snapshot.error.toString());
        else
          return CircularProgressIndicator();
      },
    );
  }
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = (parentBox.size.height) / 2;
    final double trackWidth = 230;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
  }
}
