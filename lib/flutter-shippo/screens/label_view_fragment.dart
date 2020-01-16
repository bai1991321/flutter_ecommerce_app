import 'package:flutter/material.dart';
import 'package:pdf_viewer_2/pdfviewer_scaffold.dart';

class LabelViewFragment extends StatelessWidget {
  String file_url;

  LabelViewFragment(
    this.file_url,
  );

//   _LabelViewFragmentState createState() => _LabelViewFragmentState();
// }

// class _LabelViewFragmentState extends State<LabelViewFragment> {

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // File(pathPDF).delete();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(path: file_url);
  }
}
