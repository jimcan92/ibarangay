import 'package:fluent_ui/fluent_ui.dart';

class PublicServices extends StatelessWidget {
  const PublicServices({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Public Services'),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.add),
              label: const Text('Add Service'),
              onPressed: () {
                // Add your add service logic here
              },
            ),
          ],
        ),
      ),
      content: Center(child: Text('Public Services Content')),
    );
  }
}
