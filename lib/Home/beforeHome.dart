import 'package:flutter/material.dart';
import 'package:cresco24/Components/NavBar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Home/backend.dart';
import 'dart:core';
import 'package:cresco24/Components/Navigators.dart';
import 'package:cresco24/Home/home.dart';

class BeforeHome extends StatefulWidget {
  const BeforeHome({super.key});

  @override
  State<BeforeHome> createState() => _BeforeHomeState();
}

class _BeforeHomeState extends State<BeforeHome> {

  List list = ["easy", "medium", "hard"];
  List questions = [];
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          backgroundColor: HexColor("#174ac2"),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child :ListTile(
                          title: Text(list[index]),
                          onTap: (){
                            navigation().navigateToPage(context, Home());
                            // setState(() {
                            //
                            //   // navigation().navigateToPage(context, Home());
                            // });
                          }
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        );
  }
}
