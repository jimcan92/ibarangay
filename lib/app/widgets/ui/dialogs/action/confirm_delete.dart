import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text("Confirm Delete?"),
      content: Text("Are you really want to delete this?"),
      actions: [
        Button(onPressed: context.pop, child: Text("Cancel")),
        ThemedButton.warning(
          onPressed: () => context.pop(true),
          child: Text("Confirm"),
        ),
      ],
    );
  }
}
