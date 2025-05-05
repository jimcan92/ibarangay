import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<File> generateBarangayClearance({
  required Resident issuedTo,
  DateTime? date,
}) async {
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
    'This is to certify that ${issuedTo.fullname.toUpperCase()}, ${issuedTo.age} years old, ${issuedTo.status.name.toUpperCase()} and a resident of Barangay Poblacion West, Moalboal, Cebu is known to be of good moral character and law abiding citizen in the community.',

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

  final now = date ?? DateTime.now();
  final day = now.day;

  String getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  final dayWithSuffix = '$day${getOrdinalSuffix(day)}';
  final monthName = DateFormat.MMMM().format(now); // e.g., "May"
  final year = now.year;
  //Draw text
  page.graphics.drawString(
    'ISSUED this $dayWithSuffix day of $monthName, $year at Barangay Poblacion West, Moalboal, Cebu upon request of the interested party for whatever purpose it may serve.',

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
  return await saveAndLaunchFile(bytes, 'BC.pdf');
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
