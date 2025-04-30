import 'package:flutter/foundation.dart';

const String appTitle = "iBarangay";
const String kDefaultProvince = "Cebu";
const String kDefaultMunicipality = "Moalboal";
const String kDefaultBarangay = "Poblacion West";

bool get isWindows {
  if (kIsWeb) return false;
  return defaultTargetPlatform == TargetPlatform.windows;
}

bool get isLinux {
  if (kIsWeb) return false;
  return defaultTargetPlatform == TargetPlatform.linux;
}

bool get isMac {
  if (kIsWeb) return false;
  return defaultTargetPlatform == TargetPlatform.macOS;
}

bool get isAndroid {
  if (kIsWeb) return false;
  return defaultTargetPlatform == TargetPlatform.android;
}

bool get isIOS {
  if (kIsWeb) return false;
  return defaultTargetPlatform == TargetPlatform.iOS;
}

bool get isDesktop => isWindows || isLinux || isMac;
