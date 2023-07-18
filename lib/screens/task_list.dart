import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo_application_flutter/Tasks.dart';
import 'package:todo_application_flutter/screens/task_details.dart';

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskListState();
  }
}

class TaskListState extends State<TaskList> {
  int count = 0;
   List<dynamic> list=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Center(
        child: StreamBuilder(
          builder: (context,snapshot){
            return ListView.builder(
              //Paste Here
              itemCount: 5,
              itemBuilder:(context,index)
              {
                // DocumentSnapshot data = snapshot.data!.docs[index];
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: getColorByPriority("High"),
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                    title: Text(
                      "My Task",
                    ),
                    subtitle: Text(
                        "Sub Title of My Task"
                    ),
                    trailing: GestureDetector(
                      child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are You Sure Want to Delete this Task?"),
                                actions: [
                                  GestureDetector(
                                    child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text("Yes")),
                                    onTap: () async{
                                      print("Hii");
                                    },
                                  ),
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
                      },
                    ),
                    onTap: () {
                      // Tasks task = Tasks(data["Priority"],data["Title"],data["Description"],data["Date"]);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => TaskDetail("Edit Task",task)));
                      print("Hii");
                    },
                  ),
                );
              } ,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Tasks task = Tasks("","","","");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskDetail("Add New Task",task)));
        },
        tooltip: 'Add New Task',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTaskListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.bodyMedium;

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColorByPriority(list[position]["Priority"]),
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text(
              list[position]["Title"],
              style: titleStyle,
            ),
            subtitle: list[position]["Title"],
            trailing: GestureDetector(
              child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Are You Sure Want to Mark this Task As Completed?"),
                        actions: [
                          GestureDetector(
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text("Yes")),
                            onTap: () {},
                          ),
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
              },
            ),
            onTap: () {
              Tasks task = Tasks("","","","");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskDetail("Edit Task",task)));
            },
          ),
        );
      },
    );
  }

  Color getColorByPriority(String priority) {
    if (priority == "High") {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }
}
