import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/doc/doc.dart';
import 'package:ibarangay/app/services/helper.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/app/widgets/ui/dialogs.dart';

class Ordinance extends StatelessWidget {
  const Ordinance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TileButton(
            title: "New BOR Resolution",
            subtitle: "Click to select a file.",
            leading: FluentIcons.download_document,
            trailing: FluentIcons.add,
            onPressed: () async {
              bool done = false;

              while (!done) {
                final h = await pickDocument();

                if (h == null) {
                  done = true;
                  break;
                }

                if (!context.mounted) return;

                final res = await showDialog<PreviewDocResult>(
                  context: context,
                  builder: (context) {
                    return PickFileDialog(file: h);
                  },
                );

                if (res == null) {
                  done = true;
                  break;
                }

                switch (res.type) {
                  case PreviewDocResultType.repick:
                    continue;
                  case PreviewDocResultType.picked:
                    final file = res.selected!;
                    final filenameSegments = file.name.split(".");
                    final title = filenameSegments
                        .sublist(0, filenameSegments.length - 1)
                        .join('.');
                    final ext = '.${filenameSegments.last}';

                    final path = await saveDocumentTo(
                      File(file.path!),
                      '${Directory.current.path}\\data\\docs',
                      file.name,
                    );

                    await addDataToBox<Doc>(
                      Doc(
                        id: title.split(" ").join("_"),
                        title: title,
                        ext: ext,
                        desc: res.desc,
                        category: DocCategory.ordinance,
                        path: path,
                        addedBy: 'addedBy',
                        addedDate: DateTime.now(),
                      ),
                    );
                    done = true;
                    break;
                  case PreviewDocResultType.cancel:
                    done = true;
                    break;
                }
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: getBox<Doc>().listenable(),
              builder: (context, docsBox, child) {
                if (docsBox.isEmpty) {
                  return Center(child: Text("No files added yet."));
                }

                return ListView.separated(
                  itemCount: docsBox.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),

                  itemBuilder: (context, index) {
                    final file = docsBox.getAt(index)!;

                    return TileButton(
                      leading: FluentIcons.pdf,
                      trailing: FluentIcons.skype_circle_check,
                      leadingColor: Colors.red.withAlpha(200),
                      trailingColor: Colors.successPrimaryColor,
                      title: file.title,
                      subtitle: file.desc ?? file.title,
                      onPressed: () async {
                        final doc = await showDialog<Doc>(
                          context: context,
                          builder: (context) {
                            return ViewDocDialog(
                              file: file,
                              onDelete: () async {
                                await deleteFromBox<Doc>(file.id);
                                await deleteDocumentFrom(file.path);
                              },
                            );
                          },
                        );

                        if (doc != null) {
                          await addDataToBox(doc);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
