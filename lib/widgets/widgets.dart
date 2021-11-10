import 'package:flutter/material.dart';
import 'dart:math';

import 'package:kan_do/data_base_helpers.dart';
import '../task.dart';

class TaskCard extends StatelessWidget {
  final String? title;
  final String? desc;
  TaskCard({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'Untitled Task',
            style: const TextStyle(color: Colors.white, fontSize: 24
                //Color(0xff211517),
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child:
//                 if(desc !=""){
//               Text(desc)
//             }else{
// Text(' Please Add Task Description');
//             }
                Text(
              desc ?? ' Please Add Task Description',
              style: const TextStyle(
                  color: Color(0xFFE0DEEB),
                  // color: Colors.white,
                  height: 1.2,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  final String? text;
  final bool isDone;

  const ToDoWidget({Key? key, required this.text, required this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 12),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                //Color(0xFF0517B4)
                color: isDone ? Colors.purpleAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: isDone
                    ? null
                    : Border.all(
                        color: Colors.purple,
                        //color: Color(0xFF0517B4),
                        width: 1.5,
                      )),
            child: Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Text(
              text ?? 'Untitled  Task',
              style: TextStyle(
                fontSize: 18,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w400,
                color: isDone ? Color(0xFF4F4A61) : Color(0xFF868199),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buidViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class PopWidget extends StatefulWidget {
  final Task? task;
  final String popMsg;
  final String alertMsg;
  final String confirm;
  final String close;
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  // ignore: prefer_typing_uninitialized_variables
  final onTapClose;

  PopWidget(BuildContext context, this.task,
      {required this.popMsg,
      required this.alertMsg,
      required this.confirm,
      required this.close,
      this.onTap,
      this.onTapClose});

  @override
  _PopWidgetState createState() => _PopWidgetState();
}

class _PopWidgetState extends State<PopWidget> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int _taskId = 0;

  @override
  void initState() {
    if (widget.task != null) {
      _taskId = widget.task!.id!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple,
      title: Text(
        widget.alertMsg,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.popMsg),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: widget.onTapClose,
          textColor: Theme.of(context).primaryColor,
          child: Text(
            widget.close,
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: widget.onTap,
          textColor: Theme.of(context).primaryColor,
          child: Text(
            widget.confirm,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
