import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/certificate/certificate.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/pdf.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Certificates extends StatefulWidget {
  const Certificates({super.key});

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  Map<int, bool> selected = {0: true, 1: true, 2: true, 3: true, 4: true};

  void toggleSelected(int index) {
    selected[index] = !selected[index]!;
    setState(() {});
  }

  void toggleSelectAll() {
    final allActive = selected.entries.every((e) => e.value);

    if (allActive) {
      selected.forEach((i, _) {
        selected[i] = false;
      });
    } else {
      selected.forEach((i, _) {
        selected[i] = true;
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final allActive = selected.entries.every((e) => e.value);

    return ScaffoldPage(
      header: PageHeader(title: const Text('Certificates & Clearances')),
      content: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Issued Certificates & Clearances',
              style: FluentTheme.of(context).typography.subtitle,
            ),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Button(
                  // backgroundColor: Colors.accentColors[e.$1 + 1]
                  // .withAlpha(150),
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      allActive
                          ? Colors.accentColors[1].basedOnLuminance()
                          : Colors.accentColors[1].basedOnLuminance().withAlpha(
                            100,
                          ),
                    ),

                    backgroundColor: WidgetStateProperty.resolveWith((state) {
                      if (state.isHovered) {
                        return allActive
                            ? Colors.accentColors[1]
                            : Colors.accentColors[1].withAlpha(80);
                      }
                      return allActive
                          ? Colors.accentColors[1].withAlpha(220)
                          : Colors.accentColors[1].withAlpha(40);
                    }),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                  ),
                  onPressed: toggleSelectAll,
                  child: Text('All: ${25}'),
                ),
                ...CertificateType.values.indexed.map((e) {
                  return Button(
                    // backgroundColor: Colors.accentColors[e.$1 + 1]
                    // .withAlpha(150),
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(
                        selected[e.$1]!
                            ? Colors.accentColors[e.$1 + 2].basedOnLuminance()
                            : Colors.accentColors[e.$1 + 2]
                                .basedOnLuminance()
                                .withAlpha(100),
                      ),

                      backgroundColor: WidgetStateProperty.resolveWith((state) {
                        if (state.isHovered) {
                          return selected[e.$1]!
                              ? Colors.accentColors[e.$1 + 2]
                              : Colors.accentColors[e.$1 + 2].withAlpha(80);
                        }
                        return selected[e.$1]!
                            ? Colors.accentColors[e.$1 + 2].withAlpha(220)
                            : Colors.accentColors[e.$1 + 2].withAlpha(40);
                      }),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                    ),
                    child: Text('${e.$2.name}: ${e.$1 + 4}'),
                    onPressed: () {
                      toggleSelected(e.$1);
                    },
                  );
                }),
                Button(
                  // backgroundColor: Colors.accentColors[e.$1 + 1]
                  // .withAlpha(150),
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      Colors.accentColors[1].basedOnLuminance(),
                    ),

                    backgroundColor: WidgetStateProperty.resolveWith((state) {
                      if (state.isHovered) {
                        return Colors.accentColors[7].withAlpha(220);
                      }
                      return Colors.accentColors[7];
                    }),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Icon(FluentIcons.add),
                      Text('New Clearance/Certificate'),
                    ],
                  ),
                  onPressed: () async {
                    // toggleSelected(0);
                    final cert = await showDialog<Certificate>(
                      context: context,
                      builder: (context) {
                        return NewCertificateDialog();
                      },
                    );
                  },
                ),
              ],
            ),
            Expanded(child: CreatePdfStatefulWidget()),
          ],
        ),
      ),
    );
  }
}

Future<File> saveAndLaunchFile(List<int> bytes, String fileName) async {
  //Get the storage folder location using path_provider package.
  String? path = Directory.current.path;
  // if (Platform.isAndroid ||
  //     Platform.isIOS ||
  //     Platform.isLinux ||
  //     Platform.isWindows) {
  //   final Directory directory =
  //       await path_provider.getApplicationSupportDirectory();
  //   path = directory.path;
  // } else {
  //   path = await PathProviderPlatform.instance.getApplicationSupportPath();
  // }
  final File file = File(
    Platform.isWindows ? '$path\\$fileName' : '$path/$fileName',
  );
  final res = await file.writeAsBytes(bytes, flush: true);
  print(res.path);
  return res;
  // if (Platform.isAndroid || Platform.isIOS) {
  //   //Launch the file (used open_file package)
  //   // await open_file.OpenFile.open('$path/$fileName');
  // } else if (Platform.isWindows) {
  //   await Process.run('start', <String>['$path\\$fileName'], runInShell: true);
  // } else if (Platform.isMacOS) {
  //   await Process.run('open', <String>['$path/$fileName'], runInShell: true);
  // } else if (Platform.isLinux) {
  //   await Process.run('xdg-open', <String>[
  //     '$path/$fileName',
  //   ], runInShell: true);
  // }
}

/// Represents the PDF stateful widget class.
class CreatePdfStatefulWidget extends StatefulWidget {
  /// Initalize the instance of the [CreatePdfStatefulWidget] class.
  const CreatePdfStatefulWidget({super.key});

  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdfStatefulWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Button(
            onPressed: () async {
              file = await generateBarangayClearance(
                issuedTo: Resident(
                  firstName: "Shielamae",
                  lastName: "Cantila",
                  middleName: "Dela Cruz",
                  gender: Gender.female,
                  birthDate: DateTime.now(),
                  // householdId: "householdId",
                  // status: CivilStatus.married,
                  // age: 32,
                ),
              );
              setState(() {});
            },
            child: const Text('Generate Barangay Clearance'),
          ),
          if (file != null) Expanded(child: SfPdfViewer.file(file!)),
        ],
      ),
    );
  }

  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219)),
    );
    //Generate PDF grid.
    // final PdfGrid grid = getGrid();
    // //Draw the header section by creating text element
    // final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    // //Draw grid
    // drawGrid(page, grid, result);
    // //Add invoice footer
    // drawFooter(page, pageSize);
    //Draw the image

    page.graphics.drawImage(
      PdfBitmap(File('C:\\Users\\jimcan\\Desktop\\san.png').readAsBytesSync()),
      Rect.fromLTWH(40, 25, 80, 80),
    );

    //Draw text
    page.graphics.drawString(
      'Republic of the Philippines\nProvince of Cebu\nMunicipality of Moalboal',

      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(0, 30, pageSize.width, 110),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );

    //Draw text
    page.graphics.drawString(
      'Barangay Poblacion West',

      PdfStandardFont(PdfFontFamily.timesRoman, 18, style: PdfFontStyle.bold),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(0, 75, pageSize.width, 50),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );

    page.graphics.drawLine(
      PdfPen(PdfColor(142, 170, 219)),
      Offset(30, 115),
      Offset(pageSize.width - 30, 115),
    );

    //Draw text
    page.graphics.drawString(
      'OFFICE OF THE BARANGAY CAPATAIN',

      PdfStandardFont(PdfFontFamily.timesRoman, 16),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(0, 135, pageSize.width, 50),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );

    page.graphics.drawString(
      'BARANGAY CLEARANCE',

      PdfStandardFont(PdfFontFamily.timesRoman, 18, style: PdfFontStyle.bold),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(0, 170, pageSize.width, 50),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );

    //Draw text
    page.graphics.drawString(
      'TO WHOM IT MAY CONCERN:',

      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(30, 210, pageSize.width - 60, 50),
    );

    //Draw text
    page.graphics.drawString(
      'This is to certify that JIMBOY B. CANTILA, 33 years old, MARRIED and a resident of Barangay Poblacion West, Moalboal, Cebu is known to be of good moral character and law abiding citizen in the community.',

      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      brush: PdfBrushes.black,
      // pen: PdfPens.black,
      bounds: Rect.fromLTWH(30, 250, pageSize.width - 60, 110),
      format: PdfStringFormat(
        paragraphIndent: 40,
        alignment: PdfTextAlignment.justify,
        lineSpacing: 10,
      ),
    );
    //Draw text
    page.graphics.drawString(
      'To certify further, that he/she has no derogatory and/or criminal records filed in this barangay.',

      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      brush: PdfBrushes.black,
      // pen: PdfPens.black,
      bounds: Rect.fromLTWH(30, 330, pageSize.width - 60, 110),
      format: PdfStringFormat(
        paragraphIndent: 40,
        alignment: PdfTextAlignment.justify,
        lineSpacing: 10,
      ),
    );
    //Draw text
    page.graphics.drawString(
      'ISSUED this 24th day of March, 2025 at Barangay Poblacion West, Moalboal, Cebu upon request of the interested party for whatever purpose it may serve.',

      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      brush: PdfBrushes.black,
      // pen: PdfPens.black,
      bounds: Rect.fromLTWH(30, 390, pageSize.width - 60, 110),
      format: PdfStringFormat(
        paragraphIndent: 40,
        alignment: PdfTextAlignment.justify,
        lineSpacing: 10,
      ),
    );
    //Draw text
    page.graphics.drawString(
      'JOEL B. LLORCA',

      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold),
      brush: PdfBrushes.black,
      // pen: PdfPens.black,
      bounds: Rect.fromLTWH(pageSize.width - 250, 485, 200, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineSpacing: 10,
      ),
    );
    //Draw text
    page.graphics.drawString(
      'Barangay Captain',

      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      brush: PdfBrushes.black,
      // pen: PdfPens.black,
      bounds: Rect.fromLTWH(pageSize.width - 250, 500, 200, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineSpacing: 10,
      ),
    );
    //Draw text
    page.graphics.drawString(
      'O.R. No.:\t\t_____________\nDate Issued:\t_____________\nDoc. Stamp:\t_____________',

      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      brush: PdfBrushes.black,
      // pen: PdfPens.black,
      bounds: Rect.fromLTWH(30, 560, 200, 100),
      format: PdfStringFormat(lineSpacing: 10),
    );

    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    file = await saveAndLaunchFile(bytes, 'Invoice.pdf');

    setState(() {});
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90),
    );
    //Draw string
    page.graphics.drawString(
      'INVOICE',
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle),
    );

    page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
      brush: PdfSolidBrush(PdfColor(65, 104, 205)),
    );

    page.graphics.drawString(
      r'$' + getTotalAmount(grid).toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 18),
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
      brush: PdfBrushes.white,
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
      ),
    );

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString(
      'Amount',
      contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.bottom,
      ),
    );
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Invoice Number: 2058557939\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    const String address = '''Bill To: \r\n\r\nAbraham Swearegin, 
        \r\n\r\nUnited States, California, San Mateo, 
        \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
        pageSize.width - (contentSize.width + 30),
        120,
        contentSize.width + 30,
        pageSize.height - 120,
      ),
    );

    return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
        30,
        120,
        pageSize.width - (contentSize.width + 30),
        pageSize.height - 120,
      ),
    )!;
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result =
        grid.draw(
          page: page,
          bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0),
        )!;

    //Draw grand total.
    page.graphics.drawString(
      'Grand Total',
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
        quantityCellBounds!.left,
        result.bounds.bottom + 10,
        quantityCellBounds!.width,
        quantityCellBounds!.height,
      ),
    );
    page.graphics.drawString(
      getTotalAmount(grid).toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
        totalPriceCellBounds!.left,
        result.bounds.bottom + 10,
        totalPriceCellBounds!.width,
        totalPriceCellBounds!.height,
      ),
    );
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen = PdfPen(
      PdfColor(142, 170, 219),
      dashStyle: PdfDashStyle.custom,
    );
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(
      linePen,
      Offset(0, pageSize.height - 100),
      Offset(pageSize.width, pageSize.height - 100),
    );

    const String footerContent =
    // ignore: leading_newlines_in_multiline_strings
    '''800 Interchange Blvd.\r\n\r\nSuite 2501, Austin,
         TX 78721\r\n\r\nAny Questions? support@adventure-works.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
      footerContent,
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0),
    );
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Product Id';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Product Name';
    headerRow.cells[2].value = 'Price';
    headerRow.cells[3].value = 'Quantity';
    headerRow.cells[4].value = 'Total';
    //Add rows
    addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
    addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding = PdfPaddings(
        bottom: 5,
        left: 5,
        right: 5,
        top: 5,
      );
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding = PdfPaddings(
          bottom: 5,
          left: 5,
          right: 5,
          top: 5,
        );
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(
    String productId,
    String productName,
    double price,
    int quantity,
    double total,
    PdfGrid grid,
  ) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
          grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }
}

class NewCertificateDialog extends StatelessWidget {
  const NewCertificateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 1000),
      title: Text("New Certificate/Clearance"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SfPdfViewer.file(
              File("D:\\jimcan\\projects\\flutter\\ibarangay\\Invoice.pdf"),
            ),
          ),
        ],
      ),
      actions: [Button(onPressed: context.pop, child: Text("Cancel"))],
    );
  }
}
