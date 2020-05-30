import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion = 0;
  int score = 0;
  var quiz = [
    {
      "title": "Question 1",
      "answers": [
        {"answers": "Answer 11", "correct": false},
        {"answers": "Answer 12", "correct": true},
        {"answers": "Answer 13", "correct": false},
      ]
    },
    {
      "title": "Question 2",
      "answers": [
        {"answers": "Answer 21", "correct": true},
        {"answers": "Answer 22", "correct": false},
        {"answers": "Answer 23", "correct": false},
      ]
    },
    {
      "title": "Question 3",
      "answers": [
        {"answers": "Answer 31", "correct": false},
        {"answers": "Answer 32", "correct": false},
        {"answers": "Answer 33", "correct": true},
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
        body:
        (this.currentQuestion>=quiz.length)?

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Score: ${(100*score/quiz.length).round()} %",style:TextStyle(fontSize:22,color:Colors.deepOrangeAccent)),

                  RaisedButton(
                    onPressed: (){
                      setState(() {
                        this.currentQuestion=0;
                        this.score=0;
                      });

                    },
                    color:Colors.deepOrangeAccent,
                    child: Text("Restart....",style:TextStyle(fontSize:22)),
                    textColor: Colors.white,
                  )
                ],

              )

            )

        : ListView(
          children: <Widget>[
            ListTile(
              title: Center(
                  child: Text(
                "Question ${currentQuestion + 1}/${quiz.length}",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold),
              )),
            ),
            ListTile(
              title: Text(
                quiz[currentQuestion]['title'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ...(quiz[currentQuestion]['answers'] as List<Map<String, Object>>)
                .map((answer) {
              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color : Colors.deepOrangeAccent,textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if(answer['correct']==true) ++score;
                        ++currentQuestion;
                      });
                    },
                    child:  Text(answer['answers'],style:TextStyle(fontSize: 22)),
                  ),
                ),
              );
            })
          ],
        ));
  }
}
