import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibarangay/app/models/user/user.dart';
import 'package:ibarangay/app/providers/infobar/infobar.dart';
import 'package:ibarangay/app/services/helper.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/utils/user.dart';

class Users extends ConsumerWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: getListenable<User>(),
      builder: (context, usersBox, _) {
        return ScaffoldPage(
          header: PageHeader(
            title: Text("Users"),
            commandBar: CommandBar(
              mainAxisAlignment: MainAxisAlignment.end,
              primaryItems: [
                CommandBarButton(
                  icon: Icon(FluentIcons.delete),
                  label: Text("Clear All"),
                  onPressed: () {
                    getBox<User>().clear();
                  },
                ),
                CommandBarButton(
                  icon: Icon(FluentIcons.add),
                  label: Text("Add User"),
                  onPressed: () async {
                    final newUser = await showDialog<User>(
                      context: context,
                      builder: (context) {
                        return AddEditUserDialog();
                      },
                    );

                    if (newUser != null) {
                      usersBox.put(newUser.id, newUser);
                      ref
                          .read(infobarProvider.notifier)
                          .set(
                            AppInfo.success(
                              title: Text("Success!"),
                              content: Text(
                                "Successfully added \"${newUser.username}\" in the database.",
                              ),
                            ),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
          content: ListView.builder(
            itemCount: usersBox.length,
            itemBuilder: (BuildContext context, int index) {
              final user = usersBox.getAt(index)!;

              return ListTile(
                title: Text(user.username),
                leading: Text("${index + 1}."),
                onPressed: () async {
                  final newUser = await showDialog<User>(
                    context: context,
                    builder: (context) {
                      return AddEditUserDialog(user: user);
                    },
                  );

                  if (newUser != null) {
                    usersBox.delete(user.id);
                    usersBox.put(newUser.id, newUser);
                    ref
                        .read(infobarProvider.notifier)
                        .set(
                          AppInfo.success(
                            title: Text("Success!"),
                            content: Text(
                              "Successfully updated \"${newUser.username}\".",
                            ),
                          ),
                        );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

class AddEditUserDialog extends ConsumerStatefulWidget {
  const AddEditUserDialog({super.key, this.user});

  final User? user;

  @override
  ConsumerState<AddEditUserDialog> createState() => _AddEditUserDialogState();
}

class _AddEditUserDialogState extends ConsumerState<AddEditUserDialog> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late GlobalKey<FormState> _formKey;
  late FocusNode _usernameFocusNode;

  late UserRole _role;

  void onSelectRole(UserRole? role) {
    if (role == null || _role == role) return;

    _role = role;

    reload();
  }

  void reload() => setState(() {});

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user?.username);
    _passwordController = TextEditingController();
    _nameController = TextEditingController(text: widget.user?.name);
    _formKey = GlobalKey<FormState>();
    _usernameFocusNode = FocusNode();

    _role = widget.user?.role ?? UserRole.staff;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _usernameFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _formKey.currentState?.dispose();
    _usernameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ContentDialog(
        title: Text(
          widget.user == null ? "Add User" : 'Edit "${widget.user!.username}"',
        ),
        content: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: "Username",
              child: TextFormBox(
                controller: _usernameController,
                placeholder: "Username",
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (value) {
                  // make username al least 4 characters long
                  if (value == null || value.isEmpty) {
                    return "Username is required";
                  } else if (value.length < 4) {
                    return "Username must be at least 4 characters long";
                  } else if (widget.user == null &&
                      getListenable<User>().value.values.any(
                        (user) => user.username == value,
                      )) {
                    return "Username already exists";
                  }
                  return null;
                },
              ),
            ),
            InfoLabel(
              label: "Password",
              child: TextFormBox(
                controller: _passwordController,
                placeholder: "Password",
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (value) {
                  if (widget.user != null) return null;

                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters long";
                  }
                  return null;
                },
              ),
            ),
            InfoLabel(
              label: "Full Name",
              child: TextBox(controller: _nameController, placeholder: "Name"),
            ),
            InfoLabel(
              label: "User Role",
              child: ComboBox<UserRole>(
                value: _role,
                items:
                    UserRole.values.map((UserRole role) {
                      return ComboBoxItem<UserRole>(
                        value: role,
                        child: Text(role.name),
                      );
                    }).toList(),
                onChanged: onSelectRole,
              ),
            ),
          ],
        ),
        actions: [
          ThemedButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          if (widget.user != null)
            ThemedButton.warning(
              child: const Text("Delete"),
              onPressed: () {
                getBox<User>().delete(widget.user!.id);
                Navigator.pop(context);
              },
            ),
          ThemedButton.primary(
            child: Text(widget.user == null ? "Add" : "Update"),
            onPressed: () {
              if (_formKey.currentState?.validate() != true) {
                ref
                    .read(infobarProvider.notifier)
                    .set(
                      AppInfo.error(
                        title: const Text("Error!"),
                        content: const Text("Error adding user."),
                      ),
                    );
                return;
              }

              final newUser = User(
                id: _usernameController.text,
                username: _usernameController.text,
                password: hashPassword(_passwordController.text),
                name: _nameController.text,
              );

              Navigator.pop(context, newUser);
            },
          ),
        ],
      ),
    );
  }
}
