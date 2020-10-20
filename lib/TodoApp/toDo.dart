import 'AddPage.dart';
import 'toDoList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class toDo extends StatefulWidget {
  @override
  _toDoState createState() => _toDoState();
}

class _toDoState extends State<toDo> {
  Box<Map> todoBox;
  DateTime slectedDate = DateTime.now();

  @override
  void initState() {
    todoBox = Hive.box<Map>("todoBox");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff3499ff),
                    Color(0xff3a3985),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slectedDate.day.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 60),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('EEEE')
                                      .format(slectedDate)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  DateFormat.MMMM()
                                          .format(slectedDate)
                                          .toString()
                                          .substring(0, 3) +
                                      ', ' +
                                      slectedDate.year.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showRoundedDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2021),
                                theme: ThemeData(primarySwatch: Colors.blue))
                            .then((date) {
                          setState(() {
                            slectedDate = date;
                          });
                          print(slectedDate);
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: toDoList(todoBox: todoBox, slectedDate: slectedDate),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new addPage(),
          );
          Navigator.of(context).push(route);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff3a3985),
      ),
    );
  }
}

