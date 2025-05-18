import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfViewExample extends StatefulWidget {
  String url;
  PdfViewExample({required this.url, Key? key}) : super(key: key);

  @override
  _PdfViewExampleState createState() => _PdfViewExampleState();
}

class _PdfViewExampleState extends State<PdfViewExample> {
  PDFDocument? docs;

  moreDocs() async {
    docs = await PDFDocument.fromURL(
      widget.url,
    );
    setState(() {});
  }

  @override
  void initState() {
    moreDocs();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return docs == null
        ? Center(child: CircularProgressIndicator())
        : PDFViewer(document: docs!);
  }
}