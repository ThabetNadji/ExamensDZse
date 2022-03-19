import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myEduApp/Model/question.dart';
import 'package:myEduApp/Model/userDetails.dart';
import 'package:myEduApp/Model/users.dart';
import 'package:myEduApp/Services/quizServices.dart';
import 'package:myEduApp/View/Quiz/quizWidget.dart';
import '../Quiz/userGlobal.dart' as userGlobal;

class letsGoButton extends StatelessWidget {
  String courseName, trim, examNum;
  List<question> _listQuestion = new List<question>();
  letsGoButton(String c, String t, String e) {
    courseName = c;
    trim = t;
    examNum = e;
  }
  quizServices quizeServe = new quizServices();
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Container(
          child: Row(
            children: [
              Text('إبدأ',
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white70,
                      fontFamily: 'Kufi',
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        color: Colors.green,
        onPressed: () {
          userGlobal.setExamName(courseName);
          userGlobal.setTrimester(trim);
          userGlobal.setExamNum(examNum);
          List<Map<String, dynamic>> listMap;
          // ignore: non_constant_identifier_names
          question question_;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FutureBuilder(
                        future: quizeServe.getListQuestion(
                            examNum, courseName, trim),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            listMap = snapshot.data;
                            for (int i = 0; i < listMap.length; i++) {
                              question_ = new question();
                              String questionText =
                                  listMap[i]['questionText'] as String;
                              String rep1 = listMap[i]['rep1'] as String;
                              String rep2 = listMap[i]['rep2'] as String;
                              String rep3 = listMap[i]['rep3'] as String;
                              String rep4 = listMap[i]['rep4'] as String;
                              int correctRepNum =
                                  listMap[i]['correctRepNum'] as int;
                              question_.set_Question(rep1, rep2, rep3, rep4,
                                  questionText, correctRepNum);
                              _listQuestion.add(question_);
                            }
                            users user;
                            user = userGlobal.getUserInfo();
                            userDetails userX = new userDetails(
                                user.getUserName(), user.getUserID());
                            // ignore: unused_local_variable
                            quizWidget _quizWidget = new quizWidget(
                              _listQuestion,
                              userX,
                            );
                            return _quizWidget;
                            //return Text('hello');
                          } else {
                            return new AlertDialog(
                              title: Center(
                                child: Text(
                                  examNum + 'الإختبار رقم ',
                                  style: new TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.green,
                                      fontFamily: 'Kufi',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              content: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                          child: Column(
                                        children: [
                                          CupertinoActivityIndicator(),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '... يتم العمل على جلب البيانات  ',
                                            style: new TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.orange,
                                                fontFamily: 'Kufi',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      )));
        });
  }
}
