import 'package:fluent_ui/fluent_ui.dart';

class Financials extends StatelessWidget {
  const Financials({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Financials'),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.add),
              label: const Text('Add Financial Record'),
              onPressed: () {
                // Add your add financial record logic here
              },
            ),
          ],
        ),
      ),
      content: Center(child: Text('Financials Content')),
    );
  }
}
