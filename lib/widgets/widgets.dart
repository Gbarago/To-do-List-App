import 'package:flutter/material.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'Untitled Task',
            style: const TextStyle(color: Color(0xff211517), fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              desc ?? ' Please Add Task Description',
              style: const TextStyle(
                  color: Color(0xff868295), height: 1.2, fontSize: 16),
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
                color: isDone ? const Color(0xFF0517B4) : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: isDone
                    ? null
                    : Border.all(
                        color: Color(0xFF0517B4),
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
