import 'package:fluent_ui/fluent_ui.dart';

class Misc extends StatelessWidget {
  const Misc({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: const Text("Miscellaneous")),
      content: Center(child: Text("Miscellaneous Content")),
    );
  }
}
