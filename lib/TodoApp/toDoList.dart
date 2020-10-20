import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'toDoListElement.dart';
import 'TodoModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class toDoList extends StatelessWidget {
  const toDoList({
    Key key,
    @required this.todoBox,
    @required this.slectedDate,
  }) : super(key: key);

  final Box<Map> todoBox;
  final DateTime slectedDate;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todoBox.listenable(),
      builder: (context, Box<Map> todo, _) {
        return ListView.builder(
          itemCount: todo.keys.toList().length,
          itemBuilder: (context, index) {
            if (DateTime.parse(todo.get(todo.keys.toList()[index])['time'])
                        .day ==
                    slectedDate.day &&
                DateTime.parse(todo.get(todo.keys.toList()[index])['time'])
                        .month ==
                    slectedDate.month &&
                DateTime.parse(todo.get(todo.keys.toList()[index])['time'])
                        .year ==
                    slectedDate.year) {
              return Dismissible(
                key: ValueKey(todo.get(todo.keys.toList()[index])['time']),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async{
                  if (direction == DismissDirection.endToStart) {
                    if(todo.get(todo.keys.toList()[index])['reminder']){
                      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
                      await flutterLocalNotificationsPlugin.cancel(todo.get(todo.keys.toList()[index])['notificationId']);
                    }
                    todo.delete(todo.get(todo.keys.toList()[index])['time']);
                  }
                },
                background: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.red,
                            ]
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(width: 40,),
                        Icon(Icons.delete, color: Colors.white,)
                      ],
                    )
                ),
                child: listElement(
                  toDo: TodoModel.fromJson(todo.get(todo.keys.toList()[index])),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
