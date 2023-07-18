import 'package:flutter/material.dart';
import 'package:todo_application_flutter/firebase_options.dart';
import 'package:todo_application_flutter/screens/task_list.dart';
import 'package:todo_application_flutter/screens/task_details.dart';
Future main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'To Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.orange
      ),
      home: TaskList(),
    );
  }
}