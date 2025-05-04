import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibarangay/app/providers/user/user.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userBoxProvider);

    return ScaffoldPage(
      header: PageHeader(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Admin'),
            Text(
              'Manage your barangay',
              style: FluentTheme.of(context).typography.subtitle?.copyWith(
                fontSize: 12,
                color: FluentTheme.of(
                  context,
                ).inactiveColor.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.add),
              label: const Text('Add'),
              onPressed: () {},
            ),
          ],
        ),
      ),
      content: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Admin Page Content'),
            Text(user?.username ?? 'No user logged in'),
            Text(user == null || user.role.isAdmin ? 'Admin' : 'Not Admin'),
          ],
        ),
      ),
    );
  }
}
