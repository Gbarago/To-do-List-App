import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kan_do/screens/taskpage.dart';
import 'package:kan_do/widgets/widgets.dart';
import 'package:kan_do/data_base_helpers.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFD6CFCF),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24, top: 32),
                    child: const Image(
                      image: AssetImage('assets/images/task.png'),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: const [],
                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TaskPage(task: snapshot.data[index])),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: TaskCard(
                                title: snapshot.data[index].title,
                                desc: snapshot.data[index].description,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskPage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      //  color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width: 50,
                    child: const Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/add.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
