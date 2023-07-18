import 'package:flutter/cupertino.dart';

class Tasks{
  late String Priority;
  late String Date;
  late String Title;
  late String Description;

  Tasks(@required this.Priority,@required this.Title,@required this.Description,@required this.Date);
}