import 'package:flutter/material.dart';
import 'package:kan_do/data_base_helpers.dart';
import 'package:kan_do/widgets/widgets.dart';

import '../task.dart';
import '../todo.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, this.task}) : super(key: key);
  final Task? task;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _taskTitle = '';
  int _taskId = 0;
  String _taskDescription = '';
  bool _contentVisible = false;

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;
  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task!.title!;
      _taskDescription = widget.task!.description!;
      _taskId = widget.task!.id!;

      _contentVisible = true;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _dbHelper = DatabaseHelper();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, top: 24),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Image(
                                image:
                                    AssetImage('assets/images/left-arrow.png'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              // checkif the field is not empty
                              if (value != '') {
                                //check task is null
                                if (widget.task == null) {
                                  Task _newTask = Task(title: value);

                                  _taskId =
                                      await _dbHelper.insertTask(_newTask);
                                  setState(() {
                                    _contentVisible = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _dbHelper.updateTaskTitle(
                                      _taskId, value);
                                }
                              }
                              _descriptionFocus.requestFocus();
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add Task Title'),
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff211551)),
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  //
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: TextEditingController()
                          ..text = _taskDescription,
                        onSubmitted: (value) async {
                          if (value != '') {
                            if (_taskId != 0) {
                              await _dbHelper.updateTaskDescription(
                                  _taskId, value);

                              _taskDescription = value;
                              print('desc value is $value');
                            }
                          }

                          _todoFocus.requestFocus();
                        },
                        focusNode: _descriptionFocus,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Task Descriptiom',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ////
                  //
                  Visibility(
                    visible: _contentVisible,
                    child: Expanded(
                      child: FutureBuilder(
                          initialData: [],
                          future: _dbHelper.getTodo(_taskId),
                          builder: (context, AsyncSnapshot snapshot) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (snapshot.data[index].isDone == 0) {
                                        await _dbHelper.updateTodoDone(
                                          snapshot.data[index].id,
                                          1,
                                        );
                                      } else {
                                        await _dbHelper.updateTodoDone(
                                          snapshot.data[index].id,
                                          0,
                                        );
                                      }
                                      setState(() {});
                                    },
                                    child: ToDoWidget(
                                      text: snapshot.data[index].title,
                                      isDone: snapshot.data[index].isDone == 0
                                          ? false
                                          : true,
                                    ),
                                  );
                                });
                          }),
                    ),
                  ),

                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 12),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: Color(0xFF0517B4),
                                  width: 1.5,
                                )),
                            // child: Image(
                            //   image: AssetImage('assets/images/check.png'),
                            // ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController()..text = "",
                              focusNode: _todoFocus,
                              onSubmitted: (value) async {
                                if (value != '') {
                                  //check task is null
                                  if (_taskId != 0) {
                                    DatabaseHelper _dbHelper = DatabaseHelper();
                                    Todo _newTodo = Todo(
                                      title: value,
                                      isDone: 0,
                                      taskId: _taskId,
                                    );
                                    await _dbHelper.insertTodo(_newTodo);
                                    setState(() {});
                                    _todoFocus.requestFocus();
                                  } else {
                                    print('error adding todo');
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Todo Item',
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 24,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: 50,
                      child: const Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/delete.png'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
