import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_basic_1/rabbit.dart';

class StatefulSamplewidget extends StatefulWidget {
  String title;
  Rabbit rabbit;
  int value;
  StatefulSamplewidget({this.title, this.rabbit, this.value});
  @override
  _StatefulSamplewidgetState createState() => _StatefulSamplewidgetState();
}

class _StatefulSamplewidgetState extends State<StatefulSamplewidget> {
  bool stateBool = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateBool = false;
    print("init state!!");
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies!!");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("setState");
  }

  @override
  void didUpdateWidget(covariant StatefulSamplewidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("oldWidget : ${oldWidget.value} <>this widget : ${widget.value}");
    if (oldWidget.value != widget.value) {
      print("didUpdateWidget");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build!!");
    print(widget.value);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Center(
          child: Text(
            widget.rabbit.state.toString(),
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted)
            setState(() {
              stateBool = !stateBool;
            });
        },
        child: Text("Button"),
      ),
    );
  }
}
