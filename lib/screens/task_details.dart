import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_application_flutter/Tasks.dart';
import 'package:todo_application_flutter/screens/task_list.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class TaskDetail extends StatefulWidget {
  String? title;
  late Tasks task;
  TaskDetail(String value, Tasks tasks){
    this.title = value;
    this.task = tasks;
  }

  @override
  State<StatefulWidget> createState(){
    return TaskDetailState(title.toString(), task);
  }
}

class TaskDetailState extends State<TaskDetail> {
  static var _priorities = ['High', 'Low'];
  var selectedvalue = "Low";
  String? title;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tec = TextEditingController();
  late Tasks task;

  TaskDetailState(String value, Tasks t){
    this.title = value;
    this.task = t;
  }
  //PERFECT
  @override
  Widget build(BuildContext context) {
    if(title == "Edit Task"){
      titleController.text = task.Title;
      descriptionController.text = task.Description;
      tec.text = task.Date;
      this.selectedvalue = task.Priority;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toString()),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // First element
            ListTile(
              title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  value: selectedvalue,
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      this.selectedvalue = valueSelectedByUser.toString();
                    });
                  }),
            ),

            // Second Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                  controller: tec,
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Select Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),

                  readOnly: true,

                  //--------------------------------------------------------
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime
                            .now(),
                        lastDate: DateTime(2025));

                    if (pickedDate != null) {
                      debugPrint(pickedDate
                          .toString());
                      String formattedDate = DateFormat('dd-MM-yyyy').format(
                          pickedDate);
                      print(
                          formattedDate);

                      tec.text =
                          formattedDate;


                    } else {
                      debugPrint("Date is not selected");
                    }
                  }),
            ),

            // Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () async {
                        setState(() {
                          if(titleController.text =="" || descriptionController.text =="" || tec.text ==""){
                            SnackBar snackBar = SnackBar(
                              content: Text("All The Data Mandatory to Fill"),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.deepPurple,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          else{
                            if(title=="Edit Task"){
                              Navigator.pop(context);
                            }
                            else{
                              print("HII");
                            }
                          }
                        });

                        //EXCELLENT NOW IT IS WORKING!!
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      "Are You Sure Want to Delete This Task?"),
                                  actions: [
                                    GestureDetector(
                                      child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text("Yes")),
                                      onTap: () async{
                                        // final doc = FirebaseFirestore.instance.collection("TBLTasks").where("Title",isEqualTo: this.task.Title);
                                        // QuerySnapshot query = await doc.get();
                                        // query.docs.forEach((docs) {
                                        //   docs.reference.delete();
                                        // });
                                        // Navigator.push(context,MaterialPageRoute(builder: (context)=> TaskList()));
                                      },
                                    ),
                                    //DONE KHATAM
                                    GestureDetector(
                                      child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text("No")),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // void insertion() async{
  //   var doc = FirebaseFirestore.instance.collection("TBLTasks").doc();
  //   final json = {
  //     "Title": titleController.text,
  //     "Description": descriptionController.text,
  //     "Priority":selectedvalue,
  //     "Date":tec.text
  //   };
  //   await doc.set(json);
  //   SnackBar snackBar = SnackBar(
  //     content: Text("Data Inserted Prabhu!"),
  //     duration: const Duration(seconds: 5),
  //     backgroundColor: Colors.black,
  //     action: SnackBarAction(
  //       label: 'Done',
  //       onPressed: () {
  //         tec.text = "";
  //       },
  //     ),
  //   );
  //
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   Navigator.pop(context);
  // }
}
