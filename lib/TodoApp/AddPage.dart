import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'AddPageStateController.dart';
import 'addReminder.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:math' as Dmath;


class addPage extends StatefulWidget {
  @override
  _addPageState createState() => _addPageState();
}

class _addPageState extends State<addPage> {

  AddPageStatecontroller aPController = Get.put(AddPageStatecontroller());
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = new TextEditingController();
    _descriptionController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white,
            ]),
          ),
        ),
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Text('Title', style: TextStyle(fontSize: 25)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Text('Description', style: TextStyle(fontSize: 25)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ),
/*              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Text('Set Time', style: TextStyle(fontSize: 25)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomDateTimePicker(
                    title: 'Time: ',
                    onChange: (dateTime) {
                      setState(() {
                        selectedDate = dateTime;
                      });
                      */ /*                print(DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime));
                  print(dateTime.difference(DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime))).inSeconds);*/ /*
                    },
                    mode: DateTimeMode.DATETIME,
                    dateTime: DateTime.now()),
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Set Date Range: ',
                        style: TextStyle(fontSize: 25)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff3499ff)),
                      child: IconButton(
                        icon: Icon(Icons.calendar_today),
                        iconSize: 25,
                        color: Colors.white,
                        onPressed: () {
                          aPController.setDateList(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<AddPageStatecontroller>(
                    builder: (context){
                      return Text(
                          context.dateList!=null && context.dateList.isNotEmpty
                            ? 'From:  ' +
                            DateFormat('yyyy-MM-dd').format(context.dateList.first) +
                            '\nTo:  ' +
                            DateFormat('yyyy-MM-dd').format(context.dateList.last)
                            : '',
                        style: TextStyle(fontSize: 20, color: Color(0xff3499ff)), textAlign: TextAlign.center,);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Set Time: ', style: TextStyle(fontSize: 25)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff3499ff)),
                      child: IconButton(
                        icon: Icon(Icons.watch_later),
                        iconSize: 25,
                        color: Colors.white,
                        onPressed: () {
                          aPController.selectTime(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<AddPageStatecontroller>(
                    builder: (context){
                      return Text(
                        context.selectedTime != null
                            ? '${context.selectedTime.hour} : ${context.selectedTime.minute}'
                            : '',
                        style: TextStyle(fontSize: 20, color: Color(0xff3499ff)), textAlign: TextAlign.center,);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Give me a reminder',
                        style: TextStyle(fontSize: 25)),
                  ),
                   GetBuilder<AddPageStatecontroller>(builder: (context){
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: AnimatedContainer(
                         duration: Duration(milliseconds: 200),
                         height: 40.0,
                         width: 70,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20.0),
                             color: context.toggleReminder
                                 ? Colors.greenAccent[100]
                                 : Colors.redAccent[100].withOpacity(0.5)),
                         child: Stack(
                           children: <Widget>[
                             AnimatedPositioned(
                               duration: Duration(milliseconds: 200),
                               curve: Curves.easeIn,
                               top: 3.0,
                               left: context.toggleReminder ? 30.0 : 0.0,
                               right: context.toggleReminder ? 0.0 : 30.0,
                               child: InkWell(
                                 onTap: context.toggleButton_for_reminder,
                                 child: AnimatedSwitcher(
                                     duration: Duration(milliseconds: 200),
                                     transitionBuilder: (Widget child,
                                         Animation<double> animation) {
                                       return RotationTransition(
                                         child: child,
                                         turns: animation,
                                       );
                                     },
                                     child: context.toggleReminder
                                         ? Icon(
                                       Icons.check_circle,
                                       color: Colors.green,
                                       size: 35.0,
                                       key: UniqueKey(),
                                     )
                                         : Icon(
                                       Icons.remove_circle_outline,
                                       color: Colors.red,
                                       size: 35.0,
                                       key: UniqueKey(),
                                     )),
                               ),
                             )
                           ],
                         ),
                       ),
                     );
                   }),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'Add',
                       style:  TextStyle(
                         color: Colors.white
                       ),
                    ),
                  ),
                  color: Color(0xff3499ff),
                  onPressed: () {
                    aPController.onDone(context,_titleController.text,_descriptionController.text);
                  },
                ),
              )
            ],
          )),
    );
  }
}
