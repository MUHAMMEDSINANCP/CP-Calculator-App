import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CalculatorUi extends StatefulWidget {
  const CalculatorUi({Key? key}) : super(key: key);

  @override
  State<CalculatorUi> createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  List<String> buttons = [
    'AC',
    'DEL',
    '(',
    ')',
    '7',
    '8',
    '9',
    '÷',
    '4',
    '5',
    '6',
    '×',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  bool enableDark = false;
  String ans = '0';
  String val = '';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: enableDark
            ? Theme.of(context).hintColor
            : Theme.of(context).primaryColor,
        body: Column(
          children: [
            SizedBox(height: 5),
            Container(
              width: w,
              height: h * 0.28,
              color: enableDark
                  ? Theme.of(context).hintColor
                  : Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 1, top: 25, right: 1),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ToggleSwitch(
                                totalSwitches: 2,
                                iconSize: 20,
                                initialLabelIndex: 0,
                                activeFgColor: enableDark
                                    ? Color(0xff6b6f77)
                                    : Theme.of(context).hintColor,
                                inactiveFgColor: enableDark
                                    ? Theme.of(context).primaryColor
                                    : Color(0xffdddddd),
                                activeBgColors: [
                                  [
                                    enableDark
                                        ? Color(0xff2a2d37)
                                        : Color(0xfff4f1f2),
                                  ],
                                  [
                                    enableDark
                                        ? Color(0xfff4f1f2)
                                        : Color(0xff2a2d37),
                                  ],
                                ],
                                inactiveBgColor: enableDark
                                    ? Color(0xff2a2d37)
                                    : Color(0xfff4f1f2),
                                minHeight: 40,
                                minWidth: 50,
                                onToggle: (index) {
                                  setState(() {
                                    enableDark = index == 1;
                                  });
                                },
                                icons: [
                                  CupertinoIcons.sun_max,
                                  CupertinoIcons.moon,
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            '$val',
                            style: TextStyle(
                              color: enableDark
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).hintColor,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '$ans',
                            style: TextStyle(
                              color: enableDark
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).hintColor,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: enableDark ? Color(0xff2a2d37) : Color(0xfff4f1f2),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 17,
                  children: [
                    for (String icon in buttons)
                      GestureDetector(
                        onTap: () {
                          valUpdate(icon);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: (icon == 'AC' || icon == 'DEL')
                                  ? Colors.redAccent
                                  : (icon == '+' ||
                                  icon == '-' ||
                                  icon == '×' ||
                                  icon == '÷' ||
                                  icon == '=')
                                  ? Colors.greenAccent
                                  : (icon == '(' || icon == ')')
                                  ? Colors.blueAccent
                                  : enableDark
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).hintColor,
                              width: 4,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              icon,
                              style: TextStyle(
                                fontSize: 22,
                                color: (icon == 'AC' || icon == 'DEL')
                                    ? Colors.redAccent
                                    : (icon == '+' ||
                                    icon == '-' ||
                                    icon == '×' ||
                                    icon == '÷' ||
                                    icon == '=')
                                    ? Colors.greenAccent.shade400
                                    : (icon == '(' || icon == ')')
                                    ? Colors.blueAccent
                                    : enableDark
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void valUpdate(String s) {
    if (s == 'AC') {
      val = '';
      ans = '0';
    } else if (s == 'DEL') {
      if (val.isNotEmpty) {
        val = val.substring(0, val.length - 1);
      }
    } else if (s == '=') {
      ans = calculator(val);
      val = '';
    } else {
      val += s;
    }
    setState(() {});
  }

  String calculator(String v) {
    String modVal = v;
    modVal = modVal.replaceAll('×', '*').replaceAll('÷', '/');
    Parser p = Parser();
    Expression e = p.parse(modVal);
    ContextModel cm = ContextModel();
    double eval = e.evaluate(EvaluationType.REAL, cm);
    String result = eval.toString();
    if(result.contains('e')){
      result = eval.toStringAsPrecision(14);
    }
    return result;
  }
}
