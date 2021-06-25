import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:tutorial_app/screen/activitylist.dart';

class PdfViewPage extends StatefulWidget {
  final String url;
  final String title;
  PdfViewPage({this.url, this.title});

  @override
  _PdfViewPage createState() => _PdfViewPage();
}

class _PdfViewPage extends State<PdfViewPage> {
  bool loading = true;
  PDFDocument document;

  loadPdf() async {
    try {
      document = await PDFDocument.fromURL(widget.url);
      // PDFDocument doc = await PDFDocument.fromURL(widget.url);
      if(document != null) {
        print('ada');
      }
      setState(() {
        loading = false;
      });
    } catch(err) {
      print(PDFDocument);
      print(widget.url);
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      ): PDFViewer(document: document, zoomSteps: 1,),

    );
  }
}
