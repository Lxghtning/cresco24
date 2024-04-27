import 'package:flutter/material.dart';
import 'package:cresco24/Components/NavBar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Home/backend.dart';
import 'dart:core';
import 'package:cresco24/Components/Navigators.dart';
import 'dart:math';
import '../Components/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    List items = ["1","2","3","4"];
    List questions = [];
    List optionsList = [];
    String ques = "";

    final quizBackend quizdb = quizBackend();

    @override
    void initState(){
      super.initState();
      runSetup();
    }


    void runSetup() async{
      var intValue = Random().nextInt(4);
      await fetchQuestions();
      await fetchOptions(questions[intValue]);
      setState(() {
        ques = questions[intValue];
      });
    }

    Future<void> fetchQuestions() async{
      List q = await quizdb.fetchQuestions("easy");
      setState(() {
        questions = q;
      });
    }

    Future<void> fetchOptions(String ques) async{
      List o = await quizdb.fetchOptions(ques, "easy");
      setState(() {
        optionsList = o;
      });
      print(optionsList);
    }


    @override
    Widget build(BuildContext context) {

      print(optionsList);
      return Scaffold(
        backgroundColor: HexColor("#174ac2"),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
          drawer: NavBar(),
          body: SafeArea(
            child: SingleChildScrollView(
            child: Column(
            children: [
              const SizedBox(height: 150.0),
              Align(
                alignment:  Alignment.center,
                child: Text(
                ques,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
          ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                shrinkWrap: true,
                itemCount: optionsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child :ListTile(
                      title: Text(optionsList[index]),
                        onTap: () async{
                          final state = await quizdb.verifyAnswer(optionsList[index], "easy" , ques);
                          print(state);
                          String s="";
                          if(state) s= "Right";
                          else s="Wrong";
                          Utils.showSnackBar(s);
                          setState(() {
                            navigation().navigateToPage(context, Home());
                          });
                        }
                    ),
                  );
                },
              ),
              ),
              const SizedBox(height: 10.0),
          ]

        ),
          ),
          ),

      );
    }
}
