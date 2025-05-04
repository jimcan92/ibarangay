import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:system_theme/system_theme.dart';

part 'settings.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() => SettingsState(color: systemAccentColor);

  void setThemeMode(ThemeMode mode) async {
    state = state.copyWith(mode: mode);
  }

  void setAccentColor(AccentColor color) async {
    state = state.copyWith(color: color);
  }
}

class SettingsState {
  final ThemeMode mode;
  final AccentColor color;

  SettingsState({this.mode = ThemeMode.system, required this.color});

  SettingsState copyWith({
    ThemeMode? mode,
    WindowEffect? effect,
    AccentColor? color,
  }) {
    return SettingsState(mode: mode ?? this.mode, color: color ?? this.color);
  }
}

AccentColor get systemAccentColor {
  if (defaultTargetPlatform.supportsAccentColor) {
    return AccentColor('normal', {
      "lightest": SystemTheme.accentColor.lightest,
      'lighter': SystemTheme.accentColor.lighter,
      'light': SystemTheme.accentColor.light,
      'normal': SystemTheme.accentColor.accent,
      'dark': SystemTheme.accentColor.dark,
      'darker': SystemTheme.accentColor.darker,
      'darkest': SystemTheme.accentColor.darkest,
    });
  }

  return Colors.blue;
}
