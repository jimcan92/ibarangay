import 'package:fluent_ui/fluent_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'infobar.g.dart';

@riverpod
class Infobar extends _$Infobar {
  @override
  AppInfo? build() => null;

  void set(AppInfo info) {
    state = info;
  }

  void clear() {
    state = null;
  }
}

class AppInfo {
  final InfoBarSeverity severity;
  final Widget title;
  final Widget? content;
  final Widget? action;

  const AppInfo({
    this.severity = InfoBarSeverity.info,
    required this.title,
    this.content,
    this.action,
  });

  const AppInfo.success({required this.title, this.content, this.action})
    : severity = InfoBarSeverity.success;
  const AppInfo.warning({required this.title, this.content, this.action})
    : severity = InfoBarSeverity.warning;
  const AppInfo.error({required this.title, this.content, this.action})
    : severity = InfoBarSeverity.error;
}
