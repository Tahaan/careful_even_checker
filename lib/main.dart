import 'dart:async';

import 'package:evenator/core/checker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum BoolCheckResult { notChecked, isEven, isOdd }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evenator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  TextEditingController numberInputController = TextEditingController();

  bool isWorking = false;

  StreamController<BoolCheckResult> results =
      StreamController<BoolCheckResult>();

  @override
  void initState() {
    numberInputController.addListener(() {
      results.sink.add(BoolCheckResult.notChecked);
    });
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dismissKeyboardNow();
    });
  }

  void dismissKeyboardNow() {
    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evenator'),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 77,
                      letterSpacing: 4,
                    ),
                    controller: numberInputController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 88),
                  child: StreamBuilder<BoolCheckResult>(
                    stream: results.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData != true) {
                        return Container();
                      }
                      String resultDescription = '';
                      if (numberInputController.text == null ||
                          numberInputController.text.length == 0) {
                        resultDescription = 'Type a number';
                      } else {
                        switch (snapshot.data) {
                          case BoolCheckResult.isEven:
                            {
                              resultDescription =
                                  '${numberInputController.text} is Even.';
                              break;
                            }
                          case BoolCheckResult.isOdd:
                            {
                              resultDescription =
                                  '${numberInputController.text} is Odd.';
                              break;
                            }
                          case BoolCheckResult.notChecked:
                            {
                              resultDescription =
                                  '${numberInputController.text} needs checking.';
                              break;
                            }
                          default:
                            {
                              resultDescription = 'Hello';
                              break;
                            }
                        }
                      }
                      return Text(
                        resultDescription,
                        style: TextStyle(fontSize: 30),
                      );
                    },
                  ),
                ),
              ],
            ),
            if (isWorking) Center(child: CircularProgressIndicator())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dismissKeyboardNow();
          if (isWorking) {
            reportIsBusy();
          } else {
            _testValue();
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.restart_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void reportIsBusy() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Still working on the last one....')));
  }

  _testValue() async {
    try {
      int numberToCheck = int.parse(numberInputController.text);
      bool? isBool;
      try {
        setState(() {
          isWorking = true;
        });
        isBool = await EvenChecker.isEven(numberToCheck);
      } finally {
        setState(() {
          isWorking = false;
        });
      }
      if (isBool == true) {
        results.sink.add(BoolCheckResult.isEven);
      } else if (isBool == false) {
        results.sink.add(BoolCheckResult.isOdd);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went wrong.')));
      }
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You could try an actual number.')));
    }
  }
}
