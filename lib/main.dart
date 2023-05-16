import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eval/flutter_eval.dart';
import 'package:flutter_eval_demo/api_impl.dart';

final api = ApiImpl();
final demoMaps = <String, dynamic>{
  "#centerText": {
    "params": []
  },
  "#centerTextWithParam": {
    "params": ["testString"]
  },
  "#myForm": {
    "params": [api]
  }
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Flutter Eval Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Uri? uri;
  String func = demoMaps.keys.first;
  Future

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final rootBundle.load("assets/evc/version_1.evc");
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final keys = demoMaps.keys.toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        children: [Column(
          children: [
            Text("EVC menu"),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              final item = demoMaps[keys[index]];
              return ListTile(onTap: () {
                setState(() {
                  func = keys[index];
                });
              } , title: Text(keys[index]),);
            }, itemCount: keys.length,))
          ],
        ), Flexible(child: Column(
          children: [
            Expanded(child: uri == null? const Center(child: Text("Eval not loaded"),) : RuntimeWidget(
              uri: Uri.dataFromBytes(bytes),
              id: func,
              args: demoMaps[func]['params'],
              childBuilder: ((context) => )))
          ],
        ))],
      )
    );
  }
}
