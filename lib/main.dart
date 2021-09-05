import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String data = '0';
  String result = '';
  Color resultColor = Colors.grey;
  double dataSize = 40;
  double resultSize = 20;
  double num = 0.0;
  String history = '';
  String data2 = "";
  final List<String> buttons = [
    'C',
    'Del',
    '( )',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '='
  ];
  late List<String> text;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          data,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: dataSize,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          result,
                          maxLines: 3,
                          style: TextStyle(
                              color: resultColor, fontSize: resultSize),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                indent: 25,
                endIndent: 25,
              ),
              Container(
                height: 530,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: [
                    ...buttons.map((e) {
                      if (e == '÷' || e == '×' || e == '-' || e == '+') {
                        return RaisedButton(
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                dataSize = 40;
                                resultSize = 20;
                                resultColor = Colors.grey;
                                if (history.isNotEmpty) {
                                  data = history;
                                }
                                data += e;
                              });
                            },
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 25),
                            ));
                      } else if (e == '=') {
                        return RaisedButton(
                          onPressed: () {
                            Parser p = Parser();
                            if (data.contains('÷') || data.contains('×')) {
                              data2 = data.replaceAll('÷', '/');
                              data2 = data2.replaceAll('×', '*');
                            } else {
                              data2 = data;
                            }
                            setState(() {
                              dataSize = 20;
                              resultSize = 40;
                              resultColor = Colors.white;
                              try {
                                Expression exp = p.parse(data2);
                                ContextModel cm = ContextModel();
                                num = exp.evaluate(EvaluationType.REAL, cm);
                                text = num.toString().split('.');
                                if (text[1] == '0') {
                                  int firstNum = num.toInt();
                                  result = "= " + firstNum.toString();
                                } else if (text[1].length > 5) {
                                  result = "= " + num.toStringAsFixed(4);
                                } else {
                                  result = "= " + num.toString();
                                }
                                history = result.substring(2);
                              } catch (e) {
                                result = "Math Error";
                              }
                            });
                          },
                          child: Text(
                            e,
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          color: Colors.deepOrange,
                        );
                      } else if (e == 'C') {
                        return RaisedButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              dataSize = 40;
                              resultSize = 20;
                              resultColor = Colors.grey;
                              data = '0';
                              result = "";
                              history = '';
                            });
                          },
                          child: Text(
                            e,
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 25),
                          ),
                        );
                      } else if (e == '00') {
                        return RaisedButton(
                          color: Colors.grey[900],
                          onPressed: () {
                            setState(() {
                              data = data + '00';
                            });
                          },
                          child: Text(
                            e,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        );
                      } else if (e == '( )') {
                        return RaisedButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              dataSize = 40;
                              resultSize = 20;
                              resultColor = Colors.grey;
                              if (data[data.length - 1] == '-' ||
                                  data[data.length - 1] == '+' ||
                                  data[data.length - 1] == '×' ||
                                  data[data.length - 1] == '÷' ||
                                  data == '0' && !data.contains('(')) {
                                if (data == '0') {
                                  data = "";
                                }
                                data += '(';
                              } else if (data.contains('(')) {
                                data += ')';
                              }
                            });
                          },
                          child: Text(
                            e,
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 25),
                          ),
                        );
                      } else if (e == 'Del') {
                        return RaisedButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              dataSize = 40;
                              resultSize = 20;
                              resultColor = Colors.grey;
                              if (data.length > 1) {
                                data = data.substring(0, data.length - 1);
                              } else {
                                data = '0';
                              }
                            });
                          },
                          child: Icon(
                            Icons.backspace,
                            color: Colors.deepOrange,
                          ),
                        );
                      }
                      return RaisedButton(
                        color: Colors.grey[900],
                        onPressed: () {
                          setState(() {
                            dataSize = 40;
                            resultSize = 20;
                            resultColor = Colors.grey;
                            if (data == "0" && data.length <= 1) {
                              data = "";
                            }
                            data += e;
                          });
                        },
                        child: Text(
                          e,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
