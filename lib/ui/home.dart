import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:my_game/bloc/base.dart';
import 'dart:developer' as developer;

import 'package:my_game/domain/response.dart';
import 'package:my_game/services/types_items.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateFormat dateFormat = DateFormat("dd-M-yyyy HH:mm");

  @override
  void initState() {
    super.initState();
    bloc.getItems();
  }

  @override
  Widget build(BuildContext context) {
    developer.log('${bloc.getItems()}');
    return Scaffold(
      backgroundColor: const Color(0xEEFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _steramBuilder(),
        ),
      ),
    );
  }

  _steramBuilder(){
    return StreamBuilder<ItemResponse>(
      stream: bloc.items.stream,
      builder: (context, AsyncSnapshot<ItemResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error.length > 0) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildCardWidget(snapshot.data?.results);
        } else if (snapshot.hasError) {
          return _buildErrorWidget('${snapshot.error}');
        } else {
          return _buildLoadingWidget();
        }
      }
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading data from API...",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildCardWidget(content) {
    developer.log('${content}');
    return MasonryGrid(
        column: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? 2
            : 4,
        children: [
          ...content
              .map((item) => InkWell(
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                stops: [0.02, 0.02],
                                colors: [getColorType(item.kind), Colors.white]),
                            borderRadius:
                                BorderRadius.all(const Radius.circular(6.0))),
                        width: Theme.of(context).textTheme.headline2!.fontSize,
                        child: Column(children: [
                          ListTile(
                            title: Text(
                              '${item.title}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .fontSize),
                            ),
                            trailing: Icon((item.completed)?Icons.check_box:Icons.check_box_outline_blank, color: (item.completed)?Colors.green:Colors.grey,),
                          ),
                          Container(
                            height: .1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          ListTile(
                            title: Text(
                              '${item.text}',
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                          Container(
                            height: .1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                           Container(
                             width: double.infinity,
                             padding: EdgeInsets.symmetric( vertical: 5, horizontal: 5),
                             child: Text(
                              '${DateFormat('dd-MM-yyyy – kk:mm').format(item.dt)}', textAlign: TextAlign.end, style: TextStyle(fontSize: Theme.of(context).textTheme.headline6!.fontSize!*.5, fontWeight: FontWeight.w300),
                              // '${formatDate(DateFormat(r'''yyyy-MM-dd''').parse(item.dt), [d, ' ', MM, ' ', yyyy]).toLowerCase()}', textAlign: TextAlign.end, style: TextStyle( fontWeight: FontWeight.w300),
                            ),
                           )
                        ])),
                    onTap: () {

                    },
                    onLongPress: (){
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            actions: [

                              CupertinoActionSheetAction(
                                  onPressed: () {

                                  },
                                  child: Text('Изменить',)),
                              CupertinoActionSheetAction(
                                  onPressed: () {

                                  },
                                  child: Text('Удалить',)),

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
                    },
                  ))
              .toList(),
        ]);
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }
}