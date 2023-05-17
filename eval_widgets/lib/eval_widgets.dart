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
Widget testCenterTextWithParam(BuildContext context, String param) {
  return Center(
    child: Text("This is a centered text with string: $param", style: Theme.of(context).textTheme.bodyMedium,),
  );
}

@RuntimeOverride("#myForm")
Widget myForm(BuildContext context, Api api, void Function() cb) {
  return MyForm(cb);
}

class MyForm extends StatelessWidget {
  final Function() cb;
  const MyForm(this.cb, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(
        onTap: cb,
        title: Text("ListTile $index"),),
    );
  }
}