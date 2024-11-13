import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyric_ui/lyric_ui.dart';

///Sample Netease style
///should be extends LyricUI implementation your own UI.
///this property only for change UI,if not demand just only overwrite methods.
class UINetease extends LyricUI {
  double defaultSize;
  double defaultExtSize;
  double otherMainSize;
  double bias;
  double lineGap;
  bool isHeightlighed;
  double inlineGap;
  LyricAlign lyricAlign;
  LyricBaseLine lyricBaseLine;
  bool highlight;
  HighlightDirection highlightDirection;

  UINetease(
      {this.defaultSize = 18,
      this.defaultExtSize = 14,
      this.otherMainSize = 16,
      this.bias = 0.5,
      this.lineGap = 25,
      this.isHeightlighed = false,
      this.inlineGap = 25,
      this.lyricAlign = LyricAlign.CENTER,
      this.lyricBaseLine = LyricBaseLine.CENTER,
      this.highlight = true,
      this.highlightDirection = HighlightDirection.LTR});

  UINetease.clone(UINetease uiNetease)
      : this(
          defaultSize: uiNetease.defaultSize,
          defaultExtSize: uiNetease.defaultExtSize,
          otherMainSize: uiNetease.otherMainSize,
          bias: uiNetease.bias,
          lineGap: uiNetease.lineGap,
          inlineGap: uiNetease.inlineGap,
          lyricAlign: uiNetease.lyricAlign,
          lyricBaseLine: uiNetease.lyricBaseLine,
          highlight: uiNetease.highlight,
          highlightDirection: uiNetease.highlightDirection,
        );

  @override
  TextStyle getPlayingExtTextStyle() => TextStyle(
      color: Colors.grey[300],
      height: 1.5,
      fontWeight: FontWeight.w900,
      fontFamily: 'Urbanist',
      fontStyle: FontStyle.normal,
      fontSize: defaultExtSize);

  @override
  TextStyle getOtherExtTextStyle() => TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Urbanist',
        fontSize: defaultExtSize,
      );

  @override
  TextStyle getOtherMainTextStyle() => TextStyle(
      color: Colors.grey[200],
      fontFamily: 'Urbanist',
      fontStyle: FontStyle.normal,
      fontSize: otherMainSize);

  @override
  TextStyle getPlayingMainTextStyle() => TextStyle(
        color: Color(0xffF6AE00),
        fontSize: defaultSize,
        // fontStyle: FontStyle.italic,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.bold,
      );

  @override
  double getInlineSpace() => inlineGap;

  @override
  double getLineSpace() => lineGap;

  @override
  double getPlayingLineBias() => bias;

  @override
  LyricAlign getLyricHorizontalAlign() => lyricAlign;

  @override
  LyricBaseLine getBiasBaseLine() => lyricBaseLine;

  @override
  bool enableHighlight() => highlight;

  @override
  HighlightDirection getHighlightDirection() => highlightDirection;
}
