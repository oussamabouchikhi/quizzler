import 'package:flutter/material.dart';
//import 'package:quizzler/question.dart';
//import 'question.dart';
//? Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain(); // object from Quizbrain Class

/*
! This function has a bug
? is This working
TODO this function is not finished yet

 */

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizzler(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List scoreKeeper = [  ];

  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() { // everything inside this function will be updated after each hotreload
      //? Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
      if (quizBrain.isFinished() == true) {
          //? Step 4 Part A - show an alert using rFlutter_alert,
          //This is the code for the basic alert from the docs for rFlutter Alert:
          //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

          //Modified for our purposes:
          Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz.',
          ).show();

          //? Step 4 Part C - reset the questionNumber,
          quizBrain.reset();

          //? Step 4 Part D - empty out the scoreKeeper.
          scoreKeeper = [];
      }

      //? Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
          if (userPickedAnswer == correctAnswer) {// compare user choice with the correct answer
            //print('user got it right');
            // add check icon to scoreKeeper list
            scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
          } else {
            //print('user got it wrong');
            // add close icon to scoreKeeper list
            scoreKeeper.add(Icon( Icons.close, color: Colors.red,));
          }
        quizBrain.nextQuestion();// move to the next question
      }

    });
  }

///  List<String> questions = [ // List of questions
///    'You can lead a cow down stairs but not upstairs',
///    'Approximately one quarter of human bones are in the feet',
///    'A slug\'s blood is green',
///  ];

///  List<bool> answer = [ // List of corresponding answers
///     it should be in the right order as questions
///    false, // the first answer is false 
///    true, // the second answer is false 
///    true, // the last answer is false 
///  ];



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                // get question from questionBank list
               // listName  [ index        ].field 
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        Expanded(
        
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0, 
                ),
                ), 
                onPressed: () { // the user picked true
                  // get the current answer
                  checkAnswer(true);
                },
            ),
          ),
        ),

        Expanded(
         
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0, 
                ),
                ), 

                onPressed: () { // the user picked false
                  checkAnswer(false);
                },
            ),
          ),
        ),

        new Row(
          children: scoreKeeper,
          
        ),


      ],
    );
  }
}

/// question 1: 'You can lead a cow down stairs but not upstairs', false,
/// question 1: 'Approximately one quarter of human bones are in the feet', true,
/// question 1: 'A slug\'s blood is green', true,