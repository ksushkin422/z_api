import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_game/bloc/base.dart';
import 'package:my_game/services/select_kind.dart';
import 'package:my_game/services/types_items.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
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
  String selected_kind = '';
  int selected_kind_id = 0;

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
                                return 'Пожалуйста введите Название';
                            },
                            autofocus: false,
                            onChanged: (val) {
                              title = val;
                            },
                            initialValue: title,
                            decoration: InputDecoration(
                              labelText: "Название",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                  width: 1.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,                                ),
                              ),
                            ))),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Пожалуйста введите Описание';
                            },
                            onChanged: (val) {
                              text = val;
                            },
                            initialValue: text,
                            decoration: InputDecoration(
                              labelText: "Описание",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                  width: 1.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF364480),
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,                                ),
                              ),
                            ))),
              Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ListTile(
                    leading: Icon(Icons.circle, color: getColorType(selected_kind_id),),
                    title: Text('Уровень сложности', style: TextStyle(fontWeight: FontWeight.w300),),
                    subtitle: (selected_kind_id==0)?Text('Выберите тип'):Text('$selected_kind'),
                    onTap: (){
                      selectKind();
                    },
                  )
              ),

                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (this._formKey.currentState!.validate()) {
                          Map req_new_item = {
                            "title": title,
                            "text": text,
                            "kind": kind,
                            "completed": false,
                            "dt": '$dt'
                          };
                          developer.log('req_new_item');
                          developer.log('${req_new_item}');
                          await bloc.newItem(req_new_item);
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(Icons.save_outlined),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
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

  selectKind(){
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            ...kinds.map((kind)=>
                CupertinoActionSheetAction(
                    onPressed: () {
                      setState(() {

                      developer.log('Данные');
                      developer.log('${kind['kind_str']}');
                      developer.log('${kind['kind_id']}');
                      selected_kind = kind['kind_str'];
                      selected_kind_id = kind['kind_id'];
                      Navigator.pop(context);
                      });
                    },
                    child: Text('${kind['kind_str']}',)
                )
            ).toList(),


          ],
          cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена')),
        )
        ;
      },
    );
  }
}
