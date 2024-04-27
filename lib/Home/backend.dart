import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:core';

class quizBackend{
  Future<List> fetchQuestions(String difficulty) async{
    List questions = [];
    final collectionReference = await FirebaseFirestore
        .instance
        .collection('questions')
        .doc(difficulty)
        .collection("questionList")
        .get();

    final documentNames = collectionReference.docs.map((doc) => doc.id).toList();
    // for(int i=0; i<documentNames.length; i++){
    //   print(documentNames[i]);
    //   DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore
    //       .instance
    //       .collection('questions')
    //       .doc(difficulty)
    //       .collection("questionList")
    //       .doc(documentNames[i])
    //       .get();
    //     var q = documentSnapshot.data()!['question'];
    //     questions.add(q);
    //     print(q);
    // }
    // return questions;
    return documentNames;
  }

  Future<List> fetchOptions(String question, String difficulty) async{
    print("hey");
    List optionsList = [];
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore
        .instance
        .collection('questions')
        .doc(difficulty)
        .collection("questionList")
        .doc(question)
        .get();

    String a = documentSnapshot.data()!['A'];
    String b = documentSnapshot.data()!['B'];
    String c = documentSnapshot.data()!['C'];
    String d = documentSnapshot.data()!['D'];

    optionsList.add(a);
    optionsList.add(b);
    optionsList.add(c);
    optionsList.add(d);

    return optionsList;
  }

  Future<bool> verifyAnswer(String answer, String difficulty, String question) async{
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore
        .instance
        .collection('questions')
        .doc(difficulty)
        .collection("questionList")
        .doc(question)
        .get();

    final correct = documentSnapshot.data()!['answer'];
    if(correct==answer){
      return true;
    }
    return false;
  }

}