import 'dart:io' show File;
import 'package:docs_helper/api/pdf_api.dart' show PdfApi;
import 'package:docs_helper/widget/cell_widget.dart' show CellWidget;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<File> generate(Map<String, dynamic> database) async {
    final pdf = pw.Document();
    final myPdfFile = pw.MemoryImage(
        (await rootBundle.load('assets/timing.jpg')).buffer.asUint8List());
    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.zero,
        build: (context) {
          return [
            pw.Stack(children: [
              pw.Transform.rotate(angle: 0.009, child: pw.Image(myPdfFile)),

              // Abrechnungszeitraum
              pw.Positioned(
                left: 285,
                top: 107,
                child: pw.Text(database["Abrechnungszeitraum"],
                    style: pw.TextStyle(fontSize: 8)),
              ),

              // Mitarbeiter
              pw.Positioned(
                left: 247,
                top: 124,
                child: pw.Text(database["Mitarbeiter"],
                    style: pw.TextStyle(fontSize: 8)),
              ),

              // timing
              for (double i = 0; i < 31; i++)
                pw.Positioned(
                  left: 90 + (i / 10),
                  top: 159 + (15.6 * i),
                  child: pw.Row(children: [
                    CellWidget(text: database["timing"][i.toInt()]["Tag"], width:22),
                    CellWidget(text: database["timing"][i.toInt()]["von"], width:41),
                    CellWidget(text: database["timing"][i.toInt()]["bis"], width:42),
                    CellWidget(text: database["timing"][i.toInt()]["Pause"], width:41),
                    CellWidget(text: database["timing"][i.toInt()]["Arbeitsort"], width:265.5),
                    CellWidget(text: database["timing"][i.toInt()]["Gesamt Std."], width:50.5),
                  ]),
                ),

              // Summe
              pw.Positioned(
                top: 642.5,
                left: 503.5,
                child: pw.Container(
                    height: 15,
                    width: 50.5,
                    alignment: pw.Alignment.center,
                    child: pw.Text(database["Summe"],
                        style: pw.TextStyle(fontSize: 8))),
              ),

              // Datum
              pw.Positioned(
                top: 694,
                left: 94,
                child: pw.Text(database["Datum"],
                    style: pw.TextStyle(fontSize: 8)),
              ),

            ]),
          ];
        }));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
