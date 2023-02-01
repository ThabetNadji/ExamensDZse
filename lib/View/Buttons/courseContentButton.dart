import 'package:flutter/material.dart';
import '../PDFreader/Viewpdf.dart';

// ignore: must_be_immutable
class CourseContentButton extends StatelessWidget {
  Viewpdf viewpdf;
  String titleBtn, yearX;
  //interstitlaAds _interstitlaAds = interstitlaAds();
  String fullPath;
  CourseContentButton(this.viewpdf, this.titleBtn, this.yearX, this.fullPath);
  @override
  Widget build(BuildContext context) {
    String b, c, d, e, link, f, annee;
    bool withCorrection = false;

    if (fullPath != '') {
      f = fullPath.split("/")[5];

      if (f[0] == 'C') {
        withCorrection = true;
      }
      //String a = f[1];
      String b = f[2];
      String c = f[3];
      String d = f[4];
      String e = f[5];
      annee = b + c + d + e;
    }
    try {
      if (yearX != '') {
        link = titleBtn.split("/")[3]; // and 5 and 6
        link = link.substring(0, link.indexOf('.pdf'));
      }
    } catch (e) {
      print(e);
    }
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            //primary: Color.fromARGB(255, 22, 133, 66),
            primary: Colors.green[900],
            onPrimary: const Color(0xFF63d471),
          ),
          onPressed: () {
            /*try {
              _interstitlaAds.interstitialAd.show();
            } catch (ex) {
              print('ads faild to load ...?');
            }*/
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) => viewpdf));
          },
          child: Ink(
            child: Container(
              width: MediaQuery.of(context).size.height * 0.25,
              alignment: Alignment.center,
              child: yearX == '' && fullPath == ''
                  ? Text(
                      ' النموذج رقم ' + titleBtn,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontFamily: 'Kufi'),
                    )
                  : yearX == '' && fullPath != ''
                      ? Column(
                          children: [
                            Text(
                              ' النموذج رقم ' + titleBtn,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  fontFamily: 'Kufi'),
                            ),
                            Text(
                              ' السنة الدراسية ' + annee,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  fontFamily: 'Kufi'),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: ' التصحيح ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontFamily: 'Kufi')),
                                  withCorrection == true
                                      ? WidgetSpan(
                                          child: Icon(Icons.check, size: 20),
                                        )
                                      : WidgetSpan(
                                          child: Icon(
                                            Icons.cancel_rounded,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                  TextSpan(
                                      text: ' ا ',
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          fontFamily: 'Kufi'))
                                ],
                              ),
                            )
                          ],
                        )
                      : Text(
                          link,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontFamily: 'Kufi'),
                        ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
