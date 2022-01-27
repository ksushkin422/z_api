import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_game/bloc/base.dart';
import 'package:my_game/domain/model/item.dart';

class UpdateItem extends StatefulWidget {
  final Item item;
  const UpdateItem(this.item);
  @override
  _UpdateItemState createState() => _UpdateItemState(this.item);
}

class _UpdateItemState extends State<UpdateItem> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DateTime dt = DateTime.now();
  DateTime selectedDate = DateTime.now();
  bool checkBoxValue = true;
  String title = '';
  String text = '';
  int kind = 0;
  bool completed = false;
  int completed_change = 0;
  Item item;
  int date_change = 0;

  _UpdateItemState(this.item);

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dt,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dt = selectedDate;
        date_change = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal:
                Theme.of(context).textTheme.headline5!.fontSize!.toDouble(),
            vertical:
                Theme.of(context).textTheme.headline6!.fontSize!.toDouble(),
          ),
          child: Form(
              key: this._formKey,
              child: Material(
                  color: Color(0xFFFFFF),
                  child: Column(children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        // <-- Button color
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.lightBlue; // <-- Splash color
                        }),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Пожалуйста введите title';
                            },
                            autofocus: false,
                            onChanged: (val) {
                              title = val;
                            },
                            initialValue: item.title,
                            decoration: InputDecoration(
                              labelText: "title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                            ))),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Пожалуйста введите text';
                            },
                            onChanged: (val) {
                              text = val;
                            },
                            initialValue: item.text,
                            decoration: InputDecoration(
                              labelText: "text",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                            ))),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Пожалуйста введите kind';
                            },
                            onChanged: (val) {
                              kind = int.parse(val);
                            },
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            style: TextStyle(color: Color(0xFF364480)),
                            initialValue: (item.kind).toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              labelText: "kind",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                            ))),
                    const SizedBox(height: 10.0),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: SwitchListTile(
                          title: Text(
                            'completed',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          value: item.completed,
                          onChanged: (bool value) {
                            setState(() {
                              developer.log('${value}');
                              completed = value;
                              completed_change = 1;
                              // trainingTest=value;
                            });
                          },
                        )),
                    ListTile(
                      subtitle: Text(
                        '${DateFormat('dd-MM-yyyy – kk:mm').format(selectedDate)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w300),
                        // '${formatDate(DateFormat(r'''yyyy-MM-dd''').parse(item.dt), [d, ' ', MM, ' ', yyyy]).toLowerCase()}', textAlign: TextAlign.end, style: TextStyle( fontWeight: FontWeight.w300),
                      ),
                      title: Text(
                        'dt',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      leading: const Icon(
                        Icons.timer,
                        color: Colors.lightBlue,
                      ),
                      trailing: const Icon(
                        Icons.timer,
                        color: Colors.lightBlue,
                      ),
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        if (this._formKey.currentState!.validate()) {
                          //
                          // Map req_new_item = {
                          //   "title": title,
                          //   "text": text,
                          //   "kind": kind,
                          //   "completed": completed,
                          //   "dt": '$selectedDate'
                          // };
                          // developer.log('req_new_item');
                          // developer.log('${req_new_item}');
                          // bloc.newItem(req_new_item);
                          bloc.updateItem(
                              (title!='')?title:item.title,
                              (text!='')?text:item.text,
                              (kind!=0)?kind:item.kind,
                              (completed_change!=0)?completed:item.completed,
                              (date_change!=0)?dt:item.dt,
                            item.id
                          );
                          developer.log('обновился');
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(Icons.save_outlined),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        // <-- Button color
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.lightBlue; // <-- Splash color
                        }),
                      ),
                    ),
                  ])))),
    );
  }
}
