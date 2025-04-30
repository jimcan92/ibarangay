import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/address/address.dart';
import 'package:ibarangay/app/providers/addresses/addresses.dart';
import 'package:ibarangay/app/providers/infobar/infobar.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';

class AddressessPage extends ConsumerWidget {
  const AddressessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesBox = ref.watch(addressesBoxProvider);

    return ValueListenableBuilder(
      valueListenable: addressesBox,
      builder: (context, box, _) {
        return ScaffoldPage(
          header: PageHeader(
            title: Text("Addresses"),
            commandBar: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                Button(child: Text("Clear"), onPressed: () {}),
                FilledButton(
                  child: Text("Add New"),
                  onPressed: () async {
                    final address = await showDialog<Address?>(
                      context: context,
                      builder: (context) {
                        return AddEditAddress();
                      },
                    );

                    if (address != null &&
                        box.values.any(
                          (a) =>
                              a.barangay == address.barangay ||
                              a.street == address.street ||
                              a.purokId == address.purokId,
                        )) {
                      ref
                          .read(infobarProvider.notifier)
                          .set(AppInfo.error(title: Text("Error")));

                      return;
                    }

                    if (address != null) {
                      ref.read(addressesBoxProvider.notifier).add(address);

                      ref
                          .read(infobarProvider.notifier)
                          .set(AppInfo.success(title: Text("Success")));
                    }
                  },
                ),
              ],
            ),
          ),
          content: ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final address = box.values.toList()[index];
              return ListTile(title: Text(address.barangay));
            },
          ),
        );
      },
    );
  }
}

class AddEditAddress extends StatefulWidget {
  const AddEditAddress({super.key});

  @override
  State<AddEditAddress> createState() => _AddEditAddressState();
}

class _AddEditAddressState extends State<AddEditAddress> {
  late TextEditingController barangayController;
  late TextEditingController streetController;
  late TextEditingController purokIdController;

  @override
  void initState() {
    super.initState();

    barangayController = TextEditingController();
    streetController = TextEditingController();
    purokIdController = TextEditingController();
  }

  @override
  void dispose() {
    barangayController.dispose();
    streetController.dispose();
    purokIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text("Add new Adress"),
      content: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoLabel(
            label: 'Sitio',
            child: TextBox(
              placeholder: 'Sitio',
              controller: barangayController,
              expands: false,
            ),
          ),
          InfoLabel(
            label: "Purok",
            child: TextBox(controller: streetController),
          ),
          InfoLabel(
            label: "Street",
            child: TextBox(controller: purokIdController),
          ),
          InfoLabel(
            label: "House No.",
            child: TextBox(controller: purokIdController),
          ),
        ],
      ),
      actions: [
        ThemedButton(onPressed: context.pop, child: Text('Cancel')),
        ThemedButton.warning(onPressed: () {}, child: Text('Delete')),
        ThemedButton.primary(onPressed: () {}, child: Text('Add')),
      ],
    );
  }
}
