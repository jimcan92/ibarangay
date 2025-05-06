import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/barangay_details/barangay_details.dart';
import 'package:ibarangay/app/services/helper.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';

class BarangayDetailsDialog extends ConsumerStatefulWidget {
  const BarangayDetailsDialog({super.key});

  @override
  ConsumerState<BarangayDetailsDialog> createState() =>
      _BarangayDetailsDialogState();
}

class _BarangayDetailsDialogState extends ConsumerState<BarangayDetailsDialog> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController cityController;
  late TextEditingController provinceController;
  late TextEditingController zipcodeController;

  late BarangayDetails? details;

  File? logo;
  bool showNoLogoError = false;

  void reload() => setState(() {});

  @override
  void initState() {
    details = getBox<BarangayDetails>().get('details');

    nameController = TextEditingController(text: details?.name);
    cityController = TextEditingController(text: details?.city);
    provinceController = TextEditingController(text: details?.province);
    zipcodeController = TextEditingController(
      text: details?.zipCode.toString(),
    );
    if (details != null) logo = File(details!.logoPath);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    provinceController.dispose();
    zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text("Barangay Details"),
      content: Form(
        key: formKey,
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoLabel(
              label: "Barangay Name",
              child: TextFormBox(
                controller: nameController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Name is required.";
                  }
                  return null;
                },
                onFieldSubmitted: (_) async {
                  final saved = await onSave();
                  if (saved && context.mounted) {
                    context.pop();
                  }
                },
              ),
            ),
            InfoLabel(
              label: "City/municipality",
              child: TextFormBox(
                controller: cityController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "City/Municipality is required.";
                  }
                  return null;
                },
                onFieldSubmitted: (_) async {
                  final saved = await onSave();
                  if (saved && context.mounted) {
                    context.pop();
                  }
                },
              ),
            ),
            InfoLabel(
              label: "Province",
              child: TextFormBox(
                controller: provinceController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Province is required.";
                  }
                  return null;
                },
                onFieldSubmitted: (_) async {
                  final saved = await onSave();
                  if (saved && context.mounted) {
                    context.pop();
                  }
                },
              ),
            ),
            InfoLabel(
              label: "Zip Code",
              child: TextFormBox(
                controller: zipcodeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Zip code is required.";
                  }

                  if (value.length != 4 || int.tryParse(value) == null) {
                    return "Invalid zip code.";
                  }

                  return null;
                },
                onFieldSubmitted: (_) async {
                  final saved = await onSave();
                  if (saved && context.mounted) {
                    context.pop();
                  }
                },
              ),
            ),
            InfoLabel(
              label: "Logo",
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tooltip(
                        message: "Click to pick file",
                        child: IconButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(24)),
                            iconSize: WidgetStatePropertyAll(40),
                          ),
                          onPressed: () async {
                            showNoLogoError = false;

                            final img = await pickImage();

                            if (img != null) {
                              logo = File(img.path!);
                            }

                            reload();
                          },
                          iconButtonMode: IconButtonMode.large,
                          icon:
                              logo == null
                                  ? Icon(FluentIcons.photo2)
                                  : Image.file(
                                    logo!,
                                    height: 100,
                                    width: 100,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(FluentIcons.photo2);
                                    },
                                  ),
                        ),
                      ),
                    ],
                  ),
                  if (showNoLogoError)
                    Text(
                      "Please select a logo.",
                      style: TextStyle(color: Colors.warningPrimaryColor),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Button(onPressed: context.pop, child: Text("Cancel")),
        ThemedButton.primary(
          onPressed: () async {
            final saved = await onSave();
            if (saved && context.mounted) {
              context.pop();
            }
          },
          child: Text("Save"),
        ),
      ],
    );
  }

  Future<bool> onSave() async {
    if (!formKey.currentState!.validate()) return false;

    if (logo == null) {
      // ref
      //     .read(infobarProvider.notifier)
      //     .set(
      //       AppInfo.error(
      //         title: Text("Error"),
      //         content: Text("Please select a logo."),
      //       ),
      //     );
      showNoLogoError = true;

      reload();

      return false;
    }
    final appDir = Directory.current.path;

    final logoPath = await saveDocumentTo(
      logo!,
      "$appDir\\data\\images",
      "logo.png",
    );

    final details = BarangayDetails(
      name: nameController.text,
      city: cityController.text,
      province: provinceController.text,
      zipCode: int.parse(zipcodeController.text),
      logoPath: logoPath,
    );

    await getBox<BarangayDetails>().put("details", details);

    reload();

    return true;
  }
}
