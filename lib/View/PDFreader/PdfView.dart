import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:myEduApp/View/main/MyViewModel.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PdfView extends StatefulWidget {
  final String path;
  PdfView({Key key, this.path}) : super(key: key);
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  bool pdfReady = false;
  int _totalPages = 0;
  int _currentPage = 0;
  int _actualPage = 1;
  PDFViewController _pdfViewController;

  void _showToast(BuildContext context, String _actualPage, String totalPage) {
    Fluttertoast.showToast(
        msg: ' الصفحة ' + _actualPage + ' / ' + totalPage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        timeInSecForIos: 2,
        //timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    var myViewModel = Provider.of<MyViewModel>(context, listen: false);
    bool viewThemeX = myViewModel.getThemeView();

    //print('get >>>>>>>>>>>>>>>>>>>>>>>>');
    //print(widget.viewTheme.toString());
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              //width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height, //* 0.55,
              child: PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            swipeHorizontal: false,
            pageFling: true,
            nightMode: viewThemeX,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {
                _actualPage = page + 1;
                _showToast(context, _actualPage.toString(), total.toString());
              });
            },
            onPageError: (page, e) {},
          )),
          !pdfReady
              ? Center(
                  child: Text(
                      'حدث خطأ أثناء عملية فحص الملف، حاول فتح الملف من جديد'),
                )
              : Offstage()
        ],
      ),
    );
  }
}
