// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clipboarda/dataModel.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'HomeViewModel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) async {
        await model.getSupaData();
      },
      builder: (context, model, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await model.addData();
            },
            child: model.busy('add')
                ? CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.white,
                  )
                : Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text('Home'),
            actions: [
              IconButton(
                onPressed: () async {
                  await model.getSupaData();
                },
                icon: model.isBusy
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      )
                    : Icon(Icons.refresh),
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await model.signOut();
                },
              )
            ],
          ),
          body: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            itemBuilder: (c, index) {
              DataModel selected = model.data[index];
              return Container(
                constraints: BoxConstraints(minHeight: 100),
                child: Material(
                  elevation: 3,
                  color: Color(0xff383838),
                  child: InkWell(
                    onTap: () async {
                      await model.addToClipBoard(selected);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              model.expand(selected);
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      iconSize: 25,
                                      onPressed: () async {
                                        model.expand(selected);
                                      },
                                      icon: Icon(!selected.expanded
                                          ? EvaIcons.chevronDown
                                          : EvaIcons.chevronUp)),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            model.launchURL(selected);
                                          },
                                          icon: Icon(
                                              EvaIcons.arrowCircleUpOutline)),
                                      IconButton(
                                          onPressed: () async {
                                            model.share(selected);
                                          },
                                          icon: Icon(EvaIcons.share))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Text(
                            selected.data.toString(),
                            overflow: selected.expanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: EdgeInsets.all(5));
            },
            itemCount: model.data.length,
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
