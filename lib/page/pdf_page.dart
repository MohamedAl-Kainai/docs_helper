import 'package:flutter/material.dart';
import 'package:docs_helper/api/pdf_api.dart';
import 'package:docs_helper/api/pdf_timing_api.dart';
import 'package:docs_helper/main.dart';
import 'package:docs_helper/widget/button_widget.dart';
import 'package:docs_helper/widget/title_widget.dart';
import 'package:docs_helper/model/data.dart' show defultData;

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate Invoice',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Invoice PDF',
                  onClicked: () async {
                    final pdfFile = await PdfInvoiceApi.generate(defultData);
                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
