
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {


  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  void initState() {
    super.initState();
  }

  DateTime dt = DateTime.now();
  DateTime selectedDate = DateTime.now();
  bool checkBoxValue = true;
  String title = '';
  String text = '';
  int kind = 0;
  bool completed = false;


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
              key: GlobalKey<FormState>(),
              child: Material(
                  color: Color(0xFFFFFF),
                  child: Column( children: [
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child:
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) return 'Пожалуйста введите title';
                      },
                      autofocus: false,
                      onChanged: (val) {
                        title = val;
                      },
                      initialValue: title,
                        decoration: InputDecoration(
                          labelText: "title",
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
                        )
                    )
                  ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child:
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) return 'Пожалуйста введите text';
                      },
                      onChanged: (val) {
                        text = val;
                      },
                      initialValue: text,
                        decoration: InputDecoration(
                          labelText: "text",
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
                        )
                    )
              ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child:
                      TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) return 'Пожалуйста введите kind';
                      },
                      onChanged: (val) {
                        kind = int.parse(val);
                      },
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          style: TextStyle(color: Color(0xFF364480)),
                      initialValue: (kind).toString(),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                        decoration: InputDecoration(
                            labelText: "kind",
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
                        )

                    )),
                    const SizedBox(height: 10.0),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: SwitchListTile(
                          title: Text('completed', style: TextStyle(fontWeight: FontWeight.w300),),
                          value: completed,
                          onChanged: (bool value) {
                          setState(() {
                            developer.log('${value}');
                            completed = value;
                            // trainingTest=value;
                          });
                        },
                        )
                    ),


                    ListTile(
                      subtitle: Text(
                        '${DateFormat('dd-MM-yyyy – kk:mm').format(selectedDate)}',  style: TextStyle(fontWeight: FontWeight.w300),
                        // '${formatDate(DateFormat(r'''yyyy-MM-dd''').parse(item.dt), [d, ' ', MM, ' ', yyyy]).toLowerCase()}', textAlign: TextAlign.end, style: TextStyle( fontWeight: FontWeight.w300),
                      ),
                      title: Text(
                        'dt',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      leading: Icon(Icons.timer),

                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 10.0),
                  ])
              )
          )
      ),
    );
  }
}