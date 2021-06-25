import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:tutorial_app/activityview.dart';


class ActivityViewPage extends StatefulWidget {
  final String url;
  final String title;
  final String judulkegiatan;
  ActivityViewPage({this.url, this.title, this.judulkegiatan});

  @override
  _ActivityViewPage createState() => _ActivityViewPage();
}

class _ActivityViewPage extends State<ActivityViewPage> {
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
        title: Text(widget.judulkegiatan),
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      ): PDFViewer(document: document, zoomSteps: 1,),

    );
  }
}
