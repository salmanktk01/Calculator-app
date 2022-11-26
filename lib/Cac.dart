import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Cac extends StatefulWidget {
  const Cac({Key? key}) : super(key: key);

  @override
  State<Cac> createState() => _CacState();
}

class _CacState extends State<Cac> {
  String equation = "0";
  String result = "0";
  double fontequ = 38.0;
  double fontres = 48.0;
  String expression = "";
  void buttonpressed(String buttontext) {
    setState(() {
      if (buttontext == 'C') {
        equation = '0';
        result = '0';
        double fontequ = 28.0;
        double fontres = 48.0;
      } else if (buttontext == 'skip') {
        double fontequ = 48.0;
        double fontres = 28.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '0') {
          equation = '0';
        }
      } else if (buttontext == '=') {
        double fontequ = 28.0;
        double fontres = 48.0;
        expression = equation;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "error";
        }
      } else {
        double fontequ = 48.0;
        double fontres = 28.0;
        if (equation == "0") {
          equation = buttontext;
        } else {
          equation = equation + buttontext;
        }
      }
    });
  }

  Widget buildbutton(
      String buttontext, double buttonheight, Color buttoncolor) {
    return Container(
      margin: EdgeInsets.all(2),
      height: MediaQuery.of(context).size.height * 0.1 * buttonheight,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => buttonpressed(buttontext),
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: buttoncolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid))),
          child: Text(
            buttontext,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Caculator"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.fromLTRB(20, 10, 10, 20),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${equation}',
                  style: TextStyle(
                    fontSize: fontequ,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.fromLTRB(20, 10, 10, 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${result}',
                  style:
                      TextStyle(fontSize: fontres, fontWeight: FontWeight.bold),
                ),
              )),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildbutton("C", 1, Colors.cyan),
                        buildbutton("/", 1, Colors.lightGreen),
                        buildbutton("skip", 1, Colors.purpleAccent),
                      ]),
                      TableRow(children: [
                        buildbutton("7", 1, Colors.black54),
                        buildbutton("8", 1, Colors.black54),
                        buildbutton("9", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildbutton("4", 1, Colors.black54),
                        buildbutton("5", 1, Colors.black54),
                        buildbutton("6", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildbutton("1", 1, Colors.black54),
                        buildbutton("2", 1, Colors.black54),
                        buildbutton("3", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildbutton(".", 1, Colors.black54),
                        buildbutton("0", 1, Colors.black54),
                        buildbutton("00", 1, Colors.black54),
                      ]),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildbutton("x", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildbutton("+", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildbutton("-", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildbutton("=", 2, Colors.black54),
                      ])
                    ],
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
