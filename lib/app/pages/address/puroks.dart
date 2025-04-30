import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/purok/purok.dart';
import 'package:ibarangay/app/providers/infobar/infobar.dart';
import 'package:ibarangay/app/providers/puroks/puroks.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';

class PuroksPage extends ConsumerWidget {
  const PuroksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puroksBoxListenable = ref.watch(puroksBoxProvider);

    return ValueListenableBuilder(
      valueListenable: puroksBoxListenable,
      builder: (context, box, widget) {
        return ScaffoldPage(
          header: PageHeader(
            title: Text("Puroks"),
            commandBar: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                Button(
                  child: Text("Clear"),
                  onPressed: () {
                    ref.read(puroksBoxProvider.notifier).clear();
                  },
                ),
                FilledButton(
                  child: Text("Add New"),
                  onPressed: () async {
                    final purok = await showDialog<Purok?>(
                      context: context,
                      builder: (context) {
                        return AddEditPurokDialog();
                      },
                    );

                    if (purok != null) {
                      ref.read(puroksBoxProvider.notifier).add(purok);

                      ref
                          .read(infobarProvider.notifier)
                          .set(
                            AppInfo.success(
                              title: Text("Success!"),
                              content: Text(
                                "Successfully added \"${purok.name}\" in the database.",
                              ),
                            ),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final puroks = box.values.toList();
                puroks.sort((a, b) => a.name.compareTo(b.name));
                final purok = puroks[index];

                return ListTile(
                  leading: Text("${index + 1}."),
                  title: Text(purok.name),
                  onPressed: () async {
                    final updatedPurok = await showDialog<Purok>(
                      context: context,
                      builder: (context) => AddEditPurokDialog(purok: purok),
                    );

                    if (updatedPurok != null) {
                      ref.read(puroksBoxProvider.notifier).add(updatedPurok);

                      ref
                          .read(infobarProvider.notifier)
                          .set(
                            AppInfo.success(
                              title: Text("Success!"),
                              content: Text(
                                "Successfully updated \"${purok.name}\" to \"${updatedPurok.name}\".",
                              ),
                            ),
                          );
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class AddEditPurokDialog extends ConsumerStatefulWidget {
  const AddEditPurokDialog({super.key, this.purok});

  final Purok? purok;

  @override
  ConsumerState<AddEditPurokDialog> createState() => _AddEditPurokDialogState();
}

class _AddEditPurokDialogState extends ConsumerState<AddEditPurokDialog> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (widget.purok != null) {
      nameController.text = widget.purok!.name;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    void onSave() {
      if (nameController.text.isEmpty) return;

      if (widget.purok?.name == nameController.text) return;

      final newPurok = Purok(id: widget.purok?.id, name: nameController.text);

      if (ref
          .watch(puroksBoxProvider)
          .value
          .values
          .any((p) => p.name == newPurok.name)) {
        ref
            .read(infobarProvider.notifier)
            .set(
              AppInfo.error(
                title: Text("Error!"),
                content: Text(
                  "\"${newPurok.name}\" is already in the database.",
                ),
              ),
            );

        return;
      }

      context.pop(newPurok);
    }

    return ContentDialog(
      title: Text(
        widget.purok == null
            ? "Add New Purok"
            : 'Update "${widget.purok!.name}"',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(
            autofocus: true,
            controller: nameController,
            onSubmitted: (_) {
              onSave();
            },
          ),
        ],
      ),
      actions: [
        ThemedButton(onPressed: context.pop, child: Text("Cancel")),
        if (widget.purok != null)
          ThemedButton.warning(
            onPressed: () {
              ref.watch(puroksBoxProvider.notifier).delete((widget.purok?.id)!);

              ref
                  .read(infobarProvider.notifier)
                  .set(
                    AppInfo.success(
                      title: Text("Deleted!"),
                      content: Text(
                        "Successfully deleted \"${widget.purok!.name}\".",
                      ),
                    ),
                  );

              context.pop();
            },
            child: Text("Delete"),
          ),
        ThemedButton.primary(onPressed: onSave, child: Text("Save")),
      ],
    );
  }
}
