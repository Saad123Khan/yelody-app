import 'dart:ui';

class AppColor {
  static const Color secondaryColor = Color(0xf1A1B22);

  static const Color linearProgressIndicator = Color(0xFF3A3B43);
  static const Color dropdownBackgroundColor = Color(0xFF23252F);

  static const Color darkBackgroundColor = Color(0xFF1A1B22);

  static const Color blackColor = Color(0xff000000);
  static const Color darkColor = Color(0xFF1A1B22);
  static const Color whiteColor = Color(0xffffffff);
  static const Color primaryColor = Color(0xffF6AE00);
  static const Color linearProgressColor = Color(0xFFEFA607);

  static const Color primaryButtonColor = Color(0xff01B1C9);
  static const Color secondaryButtonColor = Color(0xffFC3F5B);

  static const Color redColor = Color(0xffFC3F5B);

  static const Color primaryTextColor = Color(0xff000000);
  static const Color secondaryTextColor = Color(0xff444648);
}

Color hexToColor(String hexString) {
  // Assuming hexString is in the format "RRGGBB"
  int value = int.parse(hexString, radix: 16);
  return Color(value | 0xFF000000); // Add alpha channel (fully opaque)
}
