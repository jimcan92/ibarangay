import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/household/household.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';

class HouseholdDialog extends StatefulWidget {
  const HouseholdDialog({super.key, this.household});

  final Household? household;

  @override
  State<HouseholdDialog> createState() => _HouseholdDialogState();
}

class _HouseholdDialogState extends State<HouseholdDialog> {
  late final List<Resident> residents;

  late TextEditingController noController;

  List<String> members = [];

  Resident? selectedResident;
  bool isHead = false;

  void oncheckIsHead(bool? val) {
    if (val == null || isHead == val) return;

    isHead = val;

    reload();
  }

  // void onSelectMemberType(HouseholdMemberType? val) {
  //   if (val == null || memberType == val) return;

  //   memberType = val;

  //   reload();
  // }

  void onAddMember(String val) {
    if (members.contains(val)) return;

    members.add(val);

    reload();
  }

  void onRemoveMember(String val) {
    if (members.contains(val)) {
      members.remove(val);

      reload();
    }
  }

  void reload() => setState(() {});

  @override
  void initState() {
    residents = getBox<Resident>().values.toList();
    noController = TextEditingController(
      text:
          widget.household?.id ??
          getBox<Household>().length.toString().padLeft(4, "0"),
    );
    if (widget.household != null) {
      members = widget.household!.members;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Household  Details"),
          IconButton(icon: Icon(FluentIcons.clear), onPressed: context.pop),
        ],
      ),
      content: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                // color: Colors.red,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.cardColor),
                  ),
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("HOUSEHOLD NUMBER", style: theme.typography.caption),
                      // selectedLogo == null
                      //     ? Image.asset(profileAsset)
                      //     : Image.file(
                      //       File(selectedLogo!.path),
                      //       errorBuilder: (context, o, t) {
                      //         return Image.asset(profileAsset);
                      //       },
                      //     ),
                      SizedBox(height: 8),
                      TextBox(
                        enabled: false,
                        controller: noController,
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "Auto generated.",
                        style: theme.typography.caption?.copyWith(
                          fontWeight: FontWeight.w200,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                // color: Colors.red,
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
                        "ADD MEMBER",
                        // style: theme.typography.subtitle!.copyWith(
                        //   fontWeight: FontWeight.w200,
                        // ),
                        style: theme.typography.caption,
                      ),
                      // selectedLogo == null
                      //     ? Image.asset(profileAsset)
                      //     : Image.file(
                      //       File(selectedLogo!.path),
                      //       errorBuilder: (context, o, t) {
                      //         return Image.asset(profileAsset);
                      //       },
                      //     ),
                      AutoSuggestBox<Resident>(
                        onSelected: (item) {
                          selectedResident = item.value;
                          reload();
                        },
                        leadingIcon: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(FluentIcons.search, size: 14),
                        ),
                        placeholder: "Search resident",
                        items:
                            residents.map((r) {
                              return AutoSuggestBoxItem(
                                value: r,
                                label: r.fullname,
                              );
                            }).toList(),
                      ),
                      SizedBox(height: 5),
                      Button(
                        child: Text("Add"),
                        onPressed: () {
                          if (selectedResident == null) return;

                          onAddMember(selectedResident!.id);

                          selectedResident = null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
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
                    "MEMBERS",
                    style: theme.typography.caption,
                    // style: theme.typography.subtitle!.copyWith(
                    //   fontWeight: FontWeight.w200,
                    // ),
                  ),
                  // selectedLogo == null
                  //     ? Image.asset(profileAsset)
                  //     : Image.file(
                  //       File(selectedLogo!.path),
                  //       errorBuilder: (context, o, t) {
                  //         return Image.asset(profileAsset);
                  //       },
                  //     ),
                  Expanded(
                    child: ListView(
                      children:
                          members.map((m) {
                            final r = residents.firstWhere((r) => r.id == m);
                            return ListTile(
                              leading: CircleAvatar(
                                child: Image.file(File(r.profilePath!)),
                              ),
                              title: Text(r.fullname),
                              subtitle: Text("${r.age} years old"),
                              trailing: IconButton(
                                icon: Icon(FluentIcons.delete),
                                onPressed: () {
                                  onRemoveMember(m);
                                },
                              ),
                              onPressed: () {},
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        ThemedButton.primary(
          onPressed: () async {
            if (members.isEmpty) return;

            final h = Household(id: noController.text, members: members);
            await getBox<Household>().put(h.id, h);

            if (context.mounted) context.pop();
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
