import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/doc/doc.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PreviewDocResult {
  final PreviewDocResultType type;
  final PlatformFile? selected;
  final String? desc;

  PreviewDocResult({required this.type, this.selected, this.desc});
}

enum PreviewDocResultType { cancel, repick, picked }

class PickFileDialog extends StatefulWidget {
  final PlatformFile file;

  const PickFileDialog({super.key, required this.file});

  @override
  State<PickFileDialog> createState() => _PickFileDialogState();
}

class _PickFileDialogState extends State<PickFileDialog> {
  late TextEditingController titleController;
  late TextEditingController extController;
  late TextEditingController descController;
  late FocusNode titleNode;

  @override
  void initState() {
    final filenameSegments = widget.file.name.split(".");
    final filename = filenameSegments
        .sublist(0, filenameSegments.length - 1)
        .join(".");

    titleController = TextEditingController(text: filename);
    extController = TextEditingController(text: '.${filenameSegments.last}');
    descController = TextEditingController();
    titleNode = FocusNode();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => titleNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    extController.dispose();
    descController.dispose();
    titleNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 1000),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(widget.file.name)),
          IconButton(
            icon: Icon(FluentIcons.chrome_close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: InfoLabel(
                        label: "Filename",
                        child: TextBox(controller: titleController),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: InfoLabel(
                        label: "File Extension",
                        child: TextBox(
                          controller: extController,
                          enabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InfoLabel(
                  label: "Description",
                  child: TextBox(controller: descController),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Expanded(child: SfPdfViewer.file(File(widget.file.path!))),
        ],
      ),
      actions: [
        Button(child: Text("Cancel"), onPressed: () => context.pop()),
        ThemedButton.warning(
          child: Text("Repick"),
          onPressed:
              () => context.pop(
                PreviewDocResult(type: PreviewDocResultType.repick),
              ),
        ),
        ThemedButton.primary(
          child: Text("Save"),
          onPressed: () {
            context.pop(
              PreviewDocResult(
                type: PreviewDocResultType.picked,
                desc: descController.text,
                selected: PlatformFile(
                  name: '${titleController.text}${extController.text}',
                  size: widget.file.size,
                  bytes: widget.file.bytes,
                  identifier: widget.file.identifier,
                  path: widget.file.path,
                  readStream: widget.file.readStream,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ViewDocDialog extends StatefulWidget {
  const ViewDocDialog({super.key, required this.file, this.onDelete});

  final Doc file;
  final VoidCallback? onDelete;

  @override
  State<ViewDocDialog> createState() => _ViewDocDialogState();
}

class _ViewDocDialogState extends State<ViewDocDialog> {
  late TextEditingController titleController;
  late TextEditingController extController;
  late TextEditingController descController;
  late FocusNode titleNode;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.file.title);
    extController = TextEditingController(text: widget.file.ext);
    descController = TextEditingController(text: widget.file.desc);
    titleNode = FocusNode();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => titleNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    extController.dispose();
    descController.dispose();
    titleNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 1000),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(widget.file.title)),
          IconButton(
            icon: Icon(FluentIcons.chrome_close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: InfoLabel(
                        label: "Filename",
                        child: TextBox(controller: titleController),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: InfoLabel(
                        label: "File Extension",
                        child: TextBox(
                          controller: extController,
                          enabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InfoLabel(
                  label: "Description",
                  child: TextBox(controller: descController),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Expanded(child: SfPdfViewer.file(File(widget.file.path))),
        ],
      ),
      actions: [
        Button(child: Text("Cancel"), onPressed: () => context.pop()),
        if (widget.onDelete != null)
          ThemedButton.warning(
            onPressed: () {
              widget.onDelete!();

              context.pop();
            },
            child: Text("Delete"),
          ),
        ThemedButton.primary(
          onPressed: () {
            final doc = Doc(
              id: widget.file.id,
              title: titleController.text,
              ext: extController.text,
              category: widget.file.category,
              desc: descController.text,
              path: widget.file.path,
              addedBy: widget.file.addedBy,
              addedDate: widget.file.addedDate,
            );

            context.pop(doc);
          },
          child: Text("Update"),
        ),
      ],
    );
  }
}
