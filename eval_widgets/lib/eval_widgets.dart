library eval_widgets;

import 'package:eval_annotation/eval_annotation.dart';
import 'package:eval_widgets/api.dart';
import 'package:flutter/material.dart';

@RuntimeOverride("#centerText")
Widget testCenterText(BuildContext context) {
  return const Center(
    child: Text("This is a centered text"),
  );
}

@RuntimeOverride("#centerTextWithParam")
Widget testCenterTextWithParam(BuildContext context, dynamic param) {
  return Center(
    child: Text("This is a centered text with param: $param"),
  );
}

@RuntimeOverride("#myForm")
Widget myForm(BuildContext context, Api api) {
  return MyForm(api: api);
}

class MyForm extends StatelessWidget {
  final Api api;
  const MyForm({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          api.toast();
        },
        title: Text("ListTile $index"),),
    );
  }
}