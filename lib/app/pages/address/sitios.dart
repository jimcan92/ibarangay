import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/sitio/sitio.dart';
import 'package:ibarangay/app/providers/infobar/infobar.dart';
import 'package:ibarangay/app/providers/sitios/sitios.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';

class SitiosPage extends ConsumerWidget {
  const SitiosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sitiosBoxListenable = ref.watch(sitiosBoxProvider);

    return ValueListenableBuilder(
      valueListenable: sitiosBoxListenable,
      builder: (context, box, widget) {
        return ScaffoldPage(
          header: PageHeader(
            title: Text("Sitios"),
            commandBar: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                Button(
                  child: Text("Clear"),
                  onPressed: () {
                    ref.read(sitiosBoxProvider.notifier).clear();
                  },
                ),
                FilledButton(
                  child: Text("Add New"),
                  onPressed: () async {
                    final sitio = await showDialog<Sitio?>(
                      context: context,
                      builder: (context) {
                        return AddEditSitioDialog();
                      },
                    );

                    if (sitio != null) {
                      ref.read(sitiosBoxProvider.notifier).add(sitio);

                      ref
                          .read(infobarProvider.notifier)
                          .set(
                            AppInfo.success(
                              title: Text("Success!"),
                              content: Text(
                                "Successfully added \"${sitio.name}\" in the database.",
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
                final sitio = box.values.toList()[index];

                return ListTile(
                  leading: Text("${index + 1}."),
                  title: Text(sitio.name),
                  onPressed: () async {
                    final updatedSitio = await showDialog<Sitio>(
                      context: context,
                      builder: (context) => AddEditSitioDialog(sitio: sitio),
                    );

                    if (updatedSitio != null) {
                      ref.read(sitiosBoxProvider.notifier).add(updatedSitio);

                      ref
                          .read(infobarProvider.notifier)
                          .set(
                            AppInfo.success(
                              title: Text("Success!"),
                              content: Text(
                                "Successfully updated \"${sitio.name}\" to \"${updatedSitio.name}\".",
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

class AddEditSitioDialog extends ConsumerStatefulWidget {
  const AddEditSitioDialog({super.key, this.sitio});

  final Sitio? sitio;

  @override
  ConsumerState<AddEditSitioDialog> createState() => _AddEditSitioDialogState();
}

class _AddEditSitioDialogState extends ConsumerState<AddEditSitioDialog> {
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
    if (widget.sitio != null) {
      nameController.text = widget.sitio!.name;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    void onSave() {
      if (nameController.text.isEmpty) return;

      if (widget.sitio?.name == nameController.text) return;

      final newSitio = Sitio(id: widget.sitio?.id, name: nameController.text);

      if (ref
          .watch(sitiosBoxProvider)
          .value
          .values
          .any((p) => p.name == newSitio.name)) {
        ref
            .read(infobarProvider.notifier)
            .set(
              AppInfo.error(
                title: Text("Error!"),
                content: Text(
                  "\"${newSitio.name}\" is already in the database.",
                ),
              ),
            );

        return;
      }

      context.pop(newSitio);
    }

    return ContentDialog(
      title: Text(
        widget.sitio == null
            ? "Add New Sitio"
            : 'Update "${widget.sitio!.name}"',
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
        if (widget.sitio != null)
          ThemedButton.warning(
            onPressed: () {
              ref.watch(sitiosBoxProvider.notifier).delete((widget.sitio?.id)!);

              ref
                  .read(infobarProvider.notifier)
                  .set(
                    AppInfo.success(
                      title: Text("Deleted!"),
                      content: Text(
                        "Successfully deleted \"${widget.sitio!.name}\".",
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
