import 'package:fluent_ui/fluent_ui.dart';

class Populations extends StatelessWidget {
  const Populations({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Populations'),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.add),
              label: const Text('Add Population'),
              onPressed: () {
                // Add your add population logic here
              },
            ),
          ],
        ),
      ),
      content: Center(child: Text('Populations Content')),
    );
  }
}
