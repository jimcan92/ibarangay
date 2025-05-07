import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/barangay_details/barangay_details.dart';
import 'package:ibarangay/app/models/official/official.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/barangay_details.dart';

class Officials extends StatefulWidget {
  const Officials({super.key});

  @override
  State<Officials> createState() => _OfficialsState();
}

class _OfficialsState extends State<Officials> {
  @override
  Widget build(BuildContext context) {
    final details = getBox<BarangayDetails>().get("details");
    final theme = FluentTheme.of(context);

    return ScaffoldPage(
      header: PageHeader(
        title: Text("Barangay Officials"),
        commandBar: CommandBar(
          primaryItems: [
            CommandBarButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return OfficialsDialog();
                  },
                );
              },
              icon: Icon(FluentIcons.update_restore),
              label: Text("Update"),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),

      content:
          details == null
              ? Center(
                child: InfoBar(
                  title: Text("Barangay Details Not Set."),
                  content: Text("You need set your barangay details first."),
                  severity: InfoBarSeverity.warning,
                  action: ThemedButton.primary(
                    child: Text("Set"),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return BarangayDetailsDialog();
                        },
                      );

                      setState(() {});
                    },
                  ),
                ),
              )
              : Padding(
                padding: EdgeInsets.all(24),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 150,
                              maxWidth: 150,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(
                                  "${Directory.current.path}\\data\\images\\logo.png",
                                ),
                                errorBuilder: (_, __, ___) {
                                  return Image.asset('images/logo.png');
                                },
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${details.name}, ${details.city}, ${details.province}, ${details.zipCode}",
                                style: theme.typography.subtitle,
                              ),
                              Text(
                                "BARANGAY OFFICIALS",
                                style: theme.typography.title,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: getBox<Official>().listenable(),
                          builder: (context, officialsBox, child) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.captain,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Wrap(
                                    runSpacing: 20,

                                    spacing: 20,
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.firstCouncilor,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.seconCouncilor,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.thirdCouncilor,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.fourthCouncilor,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.fifthCouncilor,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.sixthCouncilor,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.seventhCouncilor,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.secretary,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.treasurer,
                                            ),
                                      ),
                                      OfficialCard(
                                        official: officialsBox.values
                                            .firstWhere(
                                              (o) =>
                                                  o.type ==
                                                  OfficialType.skChairman,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}

class OfficialsDialog extends StatefulWidget {
  const OfficialsDialog({super.key});

  @override
  State<OfficialsDialog> createState() => _OfficialsDialogState();
}

class _OfficialsDialogState extends State<OfficialsDialog> {
  late final List<Resident> residents;

  late TextEditingController captainController;
  late TextEditingController skController;
  late TextEditingController treasurerController;
  late TextEditingController secretaryController;
  late TextEditingController firstCouncilorController;
  late TextEditingController secondCouncilorController;
  late TextEditingController thirdCouncilorController;
  late TextEditingController fourthCouncilorController;
  late TextEditingController fifthCouncilorController;
  late TextEditingController sixthCouncilorController;
  late TextEditingController seventhCouncilorController;

  Resident? captain;
  Resident? sk;
  Resident? treasurer;
  Resident? secretary;
  Resident? firstCouncilor;
  Resident? secondCouncilor;
  Resident? thirdCouncilor;
  Resident? fourthCouncilor;
  Resident? fifthCouncilor;
  Resident? sixthCouncilor;
  Resident? seventhCouncilor;

  void onSelect(Resident? val, OfficialType type) {
    if (val == null) return;

    switch (type) {
      case OfficialType.captain:
        captain = val;
        break;
      case OfficialType.skChairman:
        sk = val;
        break;
      case OfficialType.secretary:
        secretary = val;
        break;
      case OfficialType.treasurer:
        treasurer = val;
        break;
      case OfficialType.firstCouncilor:
        firstCouncilor = val;
        break;
      case OfficialType.seconCouncilor:
        secondCouncilor = val;
        break;
      case OfficialType.thirdCouncilor:
        thirdCouncilor = val;
        break;
      case OfficialType.fourthCouncilor:
        fourthCouncilor = val;
        break;
      case OfficialType.fifthCouncilor:
        fifthCouncilor = val;
        break;
      case OfficialType.sixthCouncilor:
        sixthCouncilor = val;
        break;
      case OfficialType.seventhCouncilor:
        seventhCouncilor = val;
    }

    setState(() {});
  }

  @override
  void initState() {
    final residentsBox = getBox<Resident>();
    residents = residentsBox.values.toList();
    final officialsBox = getBox<Official>();

    captainController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.captain.name)?.id)
              ?.fullname,
    );
    skController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.skChairman.name)?.id)
              ?.fullname,
    );
    secretaryController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.secretary.name)?.id)
              ?.fullname,
    );
    treasurerController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.treasurer.name)?.id)
              ?.fullname,
    );
    firstCouncilorController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.firstCouncilor.name)?.id)
              ?.fullname,
    );
    secondCouncilorController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.seconCouncilor.name)?.id)
              ?.fullname,
    );
    thirdCouncilorController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.thirdCouncilor.name)?.id)
              ?.fullname,
    );
    fourthCouncilorController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.fourthCouncilor.name)?.id)
              ?.fullname,
    );
    fifthCouncilorController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.fifthCouncilor.name)?.id)
              ?.fullname,
    );
    sixthCouncilorController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.sixthCouncilor.name)?.id)
              ?.fullname,
    );
    seventhCouncilorController = TextEditingController(
      text:
          residentsBox
              .get(officialsBox.get(OfficialType.seventhCouncilor.name)?.id)
              ?.fullname,
    );

    // captain = residents.firstWhere(
    //   (r) => r.id == officialsBox.get(OfficialType.captain.name)?.id,
    // );
    super.initState();
  }

  @override
  void dispose() {
    captainController.dispose();
    skController.dispose();
    secretaryController.dispose();
    treasurerController.dispose();
    firstCouncilorController.dispose();
    secondCouncilorController.dispose();
    thirdCouncilorController.dispose();
    fourthCouncilorController.dispose();
    fifthCouncilorController.dispose();
    sixthCouncilorController.dispose();
    seventhCouncilorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final details = getBox<BarangayDetails>().get("details");

    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 600),
      title: Text("Barangay ${details?.name}'s Officials"),
      content: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoLabel(
                  label: "Barangay Captain",

                  child: AutoSuggestBox(
                    controller: captainController,
                    onSelected: (val) {
                      onSelect(val.value, OfficialType.captain);
                    },
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "SK Chairman",
                  child: AutoSuggestBox(
                    controller: skController,
                    onSelected:
                        (val) => onSelect(val.value, OfficialType.skChairman),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "Barangay Treasurer",
                  child: AutoSuggestBox(
                    controller: treasurerController,
                    onSelected:
                        (val) => onSelect(val.value, OfficialType.treasurer),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "Barangay Secretary",
                  child: AutoSuggestBox(
                    controller: secretaryController,
                    onSelected:
                        (val) => onSelect(val.value, OfficialType.secretary),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoLabel(
                  label: "1st Councilor",
                  child: AutoSuggestBox(
                    controller: firstCouncilorController,
                    onSelected:
                        (val) =>
                            onSelect(val.value, OfficialType.firstCouncilor),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "2nd Councilor",
                  child: AutoSuggestBox(
                    controller: secondCouncilorController,
                    onSelected:
                        (val) =>
                            onSelect(val.value, OfficialType.seconCouncilor),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "3rd Councilor",
                  child: AutoSuggestBox(
                    controller: thirdCouncilorController,
                    onSelected:
                        (val) =>
                            onSelect(val.value, OfficialType.thirdCouncilor),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "4th Councilor",
                  child: AutoSuggestBox(
                    controller: fourthCouncilorController,
                    onSelected:
                        (val) =>
                            onSelect(val.value, OfficialType.fourthCouncilor),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "5th Councilor",
                  child: AutoSuggestBox(
                    controller: fifthCouncilorController,
                    onSelected:
                        (val) =>
                            onSelect(val.value, OfficialType.fifthCouncilor),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "6th Councilor",
                  child: AutoSuggestBox(
                    controller: sixthCouncilorController,
                    onSelected:
                        (val) =>
                            onSelect(val.value, OfficialType.sixthCouncilor),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
                InfoLabel(
                  label: "7th Councilor",
                  child: AutoSuggestBox(
                    controller: seventhCouncilorController,
                    onSelected:
                        (val) =>
                            onSelect(val.value, OfficialType.seventhCouncilor),
                    items:
                        residents
                            .map(
                              (r) => AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Button(onPressed: context.pop, child: Text("Cancel")),
        ThemedButton.primary(
          onPressed: () async {
            if (captain == null ||
                sk == null ||
                treasurer == null ||
                secretary == null ||
                firstCouncilor == null ||
                secondCouncilor == null ||
                thirdCouncilor == null ||
                fourthCouncilor == null ||
                fifthCouncilor == null ||
                sixthCouncilor == null ||
                seventhCouncilor == null) {
              return;
            }

            await getBox<Official>().putAll({
              OfficialType.captain.name: Official(
                id: captain!.id,
                type: OfficialType.captain,
              ),
              OfficialType.skChairman.name: Official(
                id: sk!.id,
                type: OfficialType.skChairman,
              ),
              OfficialType.secretary.name: Official(
                id: secretary!.id,
                type: OfficialType.secretary,
              ),
              OfficialType.treasurer.name: Official(
                id: treasurer!.id,
                type: OfficialType.treasurer,
              ),
              OfficialType.firstCouncilor.name: Official(
                id: firstCouncilor!.id,
                type: OfficialType.firstCouncilor,
              ),
              OfficialType.seconCouncilor.name: Official(
                id: secondCouncilor!.id,
                type: OfficialType.seconCouncilor,
              ),
              OfficialType.thirdCouncilor.name: Official(
                id: thirdCouncilor!.id,
                type: OfficialType.thirdCouncilor,
              ),
              OfficialType.fourthCouncilor.name: Official(
                id: fourthCouncilor!.id,
                type: OfficialType.fourthCouncilor,
              ),
              OfficialType.fifthCouncilor.name: Official(
                id: fifthCouncilor!.id,
                type: OfficialType.fifthCouncilor,
              ),
              OfficialType.sixthCouncilor.name: Official(
                id: sixthCouncilor!.id,
                type: OfficialType.sixthCouncilor,
              ),
              OfficialType.seventhCouncilor.name: Official(
                id: seventhCouncilor!.id,
                type: OfficialType.seventhCouncilor,
              ),
            });

            if (context.mounted) context.pop();
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}

class OfficialCard extends StatelessWidget {
  const OfficialCard({super.key, required this.official});

  final Official official;

  @override
  Widget build(BuildContext context) {
    final resident = getBox<Resident>().get(official.id);

    return IconButton(
      style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(16))),
      onPressed: () {},
      icon: Column(
        spacing: 8,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 150, maxWidth: 150),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child:
                  resident == null
                      ? Image.asset('images/man.png')
                      : Image.file(
                        File(resident.profilePath!),
                        errorBuilder: (_, __, ___) {
                          return Image.asset('images/man.png');
                        },
                      ),
            ),
          ),
          Card(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Column(
              children: [
                Text(
                  resident?.fullname ?? "Captain's name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color:
                    //     Colors.grey.withValues(alpha: 0.6).basedOnLuminance(),
                  ),
                ),
                Text(official.type.name, textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
