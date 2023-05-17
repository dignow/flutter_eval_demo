import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eval/flutter_eval.dart';
import 'package:flutter_eval/widgets.dart';
import 'package:flutter_eval_demo/api_impl.dart';
import 'package:get/route_manager.dart';

final api = ApiImpl();
final demoMaps = <String, dynamic>{
  "#centerText": {"params": [], 'func': "testCenterText", "needContextFirst": true,},
  "#centerTextWithParam": {
    "params": [$String("testString")],
    "func": "testCenterTextWithParam",
    "needContextFirst": true,
  },
  "#myForm": {
    "params": [$Function((runtime, target, args) {
      api.toast();
      return null;
    }), null],
    "func": "MyForm.",
    "needContextFirst": false,
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
    return GetMaterialApp(
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
  String func = "";
  final keys = demoMaps.keys.toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text(widget.title),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("EVC menu", style: Theme.of(context).textTheme.titleLarge,),
                      ],
                    ),
                    const SizedBox(height: 8.0,),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        final item = demoMaps[keys[index]];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              func = keys[index];
                            });
                          },
                          title: Text(keys[index]),
                        );
                      },
                      itemCount: keys.length,
                    ))
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                  child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: rootBundle.load("assets/evc/version_1.evc"),
                      builder: (context, data) {
                        if (data.hasData) {
                          return func.isEmpty
                              ? const Center(
                                  child: Text("Please select one of dynamic widget"),
                                )
                              : RuntimeWidget(
                                  uri: Uri(scheme: "asset", path: "assets/evc/version_1.evc"),
                                  args: demoMaps[func]['needContextFirst'] ? 
                                  [$BuildContext.wrap(context), ...demoMaps[func]['params']]
                                   : demoMaps[func]['params'], library: 'package:eval_widgets/eval_widgets.dart', function: demoMaps[func]['func'],
                                );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
