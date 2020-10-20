import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TodoModel.dart';

class listElement extends StatelessWidget {

  final TodoModel toDo;



  const listElement({
    Key key, this.toDo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color(0xff3499ff),
                Color(0xff3a3985),
              ],
            )
        ),
        child: ListTile(
          title: Text(toDo.title, style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),),
          subtitle: Text(toDo.description+'\nat '+
              DateTime.parse(toDo.time).hour.toString()+':'+
              DateTime.parse(toDo.time).minute.toString(),
            style: TextStyle(
                color: Colors.white
            ),
          ),
          trailing: toDo.reminder ? IconButton(icon: Icon(Icons.notifications_active, color: Colors.white),
             onPressed: (){
                print(toDo.toJson());
             },
          ) :
    IconButton(icon: Icon(Icons.notifications_off, color: Colors.white,),
              onPressed: (){
                print(toDo.toJson());
              },
           ),
        ),
      ),
    );
  }
}