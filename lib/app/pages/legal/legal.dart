import 'package:fluent_ui/fluent_ui.dart';

class Legal extends StatelessWidget {
  const Legal({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Legal'),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.add),
              label: const Text('Add Legal Document'),
              onPressed: () {
                // Add your add legal document logic here
              },
            ),
          ],
        ),
      ),
      content: Center(child: Text('Legal Content')),
    );
  }
}
