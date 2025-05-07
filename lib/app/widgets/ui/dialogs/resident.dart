import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/purok/purok.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/helper.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/utils/age.dart';
import 'package:ibarangay/utils/extensions.dart';
import 'package:ibarangay/utils/nationalities.dart';

class ResidentDialog extends StatefulWidget {
  const ResidentDialog({super.key, this.resident});

  final Resident? resident;

  @override
  State<ResidentDialog> createState() => _ResidentDialogState();
}

class _ResidentDialogState extends State<ResidentDialog> {
  final comboboxKey = GlobalKey<ComboBoxState>();
  final formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController middleNameController;
  late TextEditingController suffixNameController;
  late TextEditingController ageController;
  late TextEditingController birthplaceController;
  late TextEditingController religionController;
  late TextEditingController contactNumberController;
  late TextEditingController occupationController;
  late TextEditingController nationalIdNoController;
  late TextEditingController houseNoController;
  late TextEditingController streetController;

  File? selectedLogo;
  Gender gender = Gender.male;
  CivilStatus civilStatus = CivilStatus.single;
  DateTime birthDate = DateTime.now().add(Duration(days: -100));
  String nationality = "Filipino";
  Purok? selectedPurok;

  String profileAsset = "images/man.png";

  void onPurokSelect(Purok? val) {
    if (val == null || val == selectedPurok) return;

    selectedPurok = val;

    reload();
  }

  void onGenderSelect(Gender? val) {
    if (val == null || gender == val) return;

    gender = val;
    profileAsset =
        gender == Gender.male ? "images/man.png" : "images/woman.png";

    reload();
  }

  void onCivilStatusSelect(CivilStatus? val) {
    if (val == null || civilStatus == val) return;

    civilStatus = val;

    reload();
  }

  void onBirthDateSelect(DateTime? val) {
    if (val == null || birthDate == val) return;

    birthDate = val;
    ageController.text = getAge(birthDate).toString();
    print('nice');
    reload();
  }

  void onNationalitySelect(String? val) {
    if (val == null || nationality == val) return;

    nationality = val;

    reload();
  }

  void reload() => setState(() {});
  @override
  void initState() {
    final r = widget.resident;

    if (r != null) {
      if (r.updatedProfile) {
        selectedLogo = r.profilePath == null ? null : File(r.profilePath!);
      }

      gender = r.gender;
      civilStatus = r.civilStatus;
      birthDate = r.birthDate;
      nationality = r.nationality;
      selectedPurok = r.purok == null ? null : Purok(name: r.purok!);
    }

    firstNameController = TextEditingController(text: r?.firstName);
    lastNameController = TextEditingController(text: r?.lastName);
    middleNameController = TextEditingController(text: r?.middleName);
    suffixNameController = TextEditingController(text: r?.suffix);
    birthplaceController = TextEditingController(text: r?.birthPlace);
    religionController = TextEditingController(text: r?.religion);
    contactNumberController = TextEditingController(text: r?.contactNumber);
    occupationController = TextEditingController(text: r?.occupation);
    nationalIdNoController = TextEditingController(text: r?.nationalIdNumber);
    houseNoController = TextEditingController(text: r?.houseNo);
    streetController = TextEditingController(text: r?.street);
    ageController = TextEditingController(text: getAge(birthDate).toString());

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    middleNameController.dispose();
    suffixNameController.dispose();
    birthplaceController.dispose();
    religionController.dispose();
    contactNumberController.dispose();
    occupationController.dispose();
    nationalIdNoController.dispose();
    houseNoController.dispose();
    streetController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 1000),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Resident Details"),
          IconButton(icon: Icon(FluentIcons.clear), onPressed: context.pop),
        ],
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(
                  // color: Colors.red,
                  width: 200,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.cardColor),
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "PHOTO",
                          style: theme.typography.subtitle!.copyWith(
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        selectedLogo == null
                            ? Image.asset(profileAsset)
                            : Image.file(
                              File(selectedLogo!.path),
                              errorBuilder: (context, o, t) {
                                return Image.asset(profileAsset);
                              },
                            ),
                        Button(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,

                            children: [
                              Icon(FluentIcons.open_folder_horizontal),
                              Text("Browse"),
                            ],
                          ),
                          onPressed: () async {
                            final img = await pickImage();
                            if (img != null) {
                              selectedLogo = File(img.path!);

                              reload();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: FluentTheme.of(context).cardColor,
                      ),
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "PERSONAL INFORMATION",
                          style: theme.typography.subtitle!.copyWith(
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: InfoLabel(
                                label: "Last Name",
                                child: TextFormBox(
                                  controller: lastNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "First Name",
                                child: TextFormBox(
                                  controller: firstNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Middle Name",
                                child: TextFormBox(
                                  controller: middleNameController,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Suffix",
                                child: TextFormBox(
                                  controller: suffixNameController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            InfoLabel(
                              label: "Gender",
                              child: ComboBox<Gender>(
                                value: gender,
                                onChanged: onGenderSelect,
                                items:
                                    Gender.values.map((g) {
                                      return ComboBoxItem(
                                        value: g,
                                        child: Text(g.name.title()),
                                      );
                                    }).toList(),
                              ),
                            ),
                            InfoLabel(
                              label: "Civil Status",
                              child: ComboBox<CivilStatus>(
                                value: civilStatus,
                                onChanged: onCivilStatusSelect,
                                items:
                                    CivilStatus.values.map((cs) {
                                      return ComboBoxItem(
                                        value: cs,
                                        child: Text(cs.name.title()),
                                      );
                                    }).toList(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Birth Date",
                                child: DatePicker(
                                  selected: birthDate,
                                  onChanged: onBirthDateSelect,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: InfoLabel(
                                label: "Age",
                                child: TextFormBox(
                                  enabled: false,
                                  controller: ageController,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Birth place",
                                child: TextFormBox(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            InfoLabel(
                              label: "Nationality",
                              child: ComboBox<String>(
                                value: nationality,
                                onChanged: onNationalitySelect,
                                items:
                                    nationalities.map((n) {
                                      return ComboBoxItem(
                                        value: n,
                                        child: Text(n),
                                      );
                                    }).toList(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Religion",
                                child: TextFormBox(
                                  controller: religionController,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Contact No.",
                                child: TextFormBox(
                                  controller: contactNumberController,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Occupation",
                                child: TextFormBox(
                                  controller: occupationController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: InfoLabel(
                                label: "National ID No.",
                                child: TextFormBox(
                                  controller: nationalIdNoController,
                                ),
                              ),
                            ),
                            InfoLabel(
                              label: "Purok",
                              child: ValueListenableBuilder(
                                valueListenable: getBox<Purok>().listenable(),
                                builder: (context, puroksBox, child) {
                                  return ComboBox<Purok>(
                                    key: comboboxKey,
                                    value: selectedPurok,
                                    onChanged: onPurokSelect,

                                    items: [
                                      ComboBoxItem(
                                        enabled: false,
                                        child: Button(
                                          child: Text("Manage Puroks"),
                                          onPressed: () async {
                                            comboboxKey.currentState
                                                ?.closePopup();
                                            final purok =
                                                await showDialog<Purok>(
                                                  context: context,
                                                  builder: (context) {
                                                    return ManagePuroksDialog();
                                                  },
                                                );

                                            if (purok != null) {
                                              setState(() {
                                                selectedPurok = purok;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      ...puroksBox.values.map((p) {
                                        return ComboBoxItem(
                                          value: p,
                                          child: Text(p.name),
                                        );
                                      }),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "House No.",
                                child: TextFormBox(
                                  controller: houseNoController,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Street",
                                child: TextFormBox(
                                  controller: streetController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Button(onPressed: context.pop, child: Text("Cancel")),
        ThemedButton.primary(
          onPressed: () async {
            final res = await onSave();
            if (res && context.mounted) context.pop();
          },
          child: Text("Save"),
        ),
      ],
    );
  }

  Future<bool> onSave() async {
    if (!formKey.currentState!.validate()) return false;

    final resident = Resident(
      id: widget.resident?.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      middleName: middleNameController.text,
      suffix: suffixNameController.text,
      gender: gender,
      civilStatus: civilStatus,
      birthDate: birthDate,
      birthPlace: birthplaceController.text,
      nationality: nationality,
      religion: religionController.text,
      contactNumber: contactNumberController.text,
      occupation: occupationController.text,
      nationalIdNumber: nationalIdNoController.text,
      purok: selectedPurok?.name,
      houseNo: houseNoController.text,
      street: streetController.text,
    );

    // if (selectedLogo != null) {
    final dataFolder = "${Directory.current.path}\\data";
    final profilePath = "$dataFolder\\images\\profiles\\${resident.id}";

    final data =
        selectedLogo == null
            ? (await rootBundle.load(profileAsset)).buffer.asUint8List()
            : await selectedLogo!.readAsBytes();

    final savedFile = await saveDocumentWithDataTo(
      data,
      profilePath,
      "profile.png",
    );

    final newResident = resident.copyWith(
      profilePath: savedFile.path,
      updatedProfile: selectedLogo != null,
    );

    await getBox<Resident>().put(newResident.id, newResident);
    // }
    // await getBox<Resident>().put(resident.id, resident);

    return true;
  }
}

class ManagePuroksDialog extends StatefulWidget {
  const ManagePuroksDialog({super.key});

  @override
  State<ManagePuroksDialog> createState() => _ManagePuroksDialogState();
}

class _ManagePuroksDialogState extends State<ManagePuroksDialog> {
  late TextEditingController controller;
  late FocusNode node;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = TextEditingController();
    node = FocusNode();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => node.requestFocus());
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints(maxHeight: 500, maxWidth: 320),
      title: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Manage Puroks"),
          IconButton(icon: Icon(FluentIcons.clear), onPressed: context.pop),
        ],
      ),
      content: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: InfoLabel(
                    label: "New Purok",
                    child: TextFormBox(
                      focusNode: node,
                      controller: controller,
                      onFieldSubmitted: (value) async {
                        await onSave();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Don't add a purok with no name";
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                ThemedButton.primary(onPressed: onSave, child: Text("Save")),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: getBox<Purok>().listenable(),
              builder: (context, puroksBox, child) {
                return ListView.builder(
                  itemCount: puroksBox.length,
                  itemBuilder: (context, index) {
                    final purok = puroksBox.getAt(index)!;

                    return ListTile(
                      title: Text(purok.name),
                      trailing: IconButton(
                        icon: Icon(FluentIcons.delete),
                        onPressed: () {
                          puroksBox.deleteAt(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        // Button(onPressed: context.pop, child: Text("Cancel")),
        ThemedButton(onPressed: context.pop, child: Text("Done")),
      ],
    );
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) return;

    final purok = Purok(name: controller.text);

    await getBox<Purok>().add(purok);

    controller.clear();
    node.requestFocus();
  }
}
