import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '⌫') {
        if (_input.isNotEmpty) _input = _input.substring(0, _input.length - 1);
      } else if (value == '=') {
        _calculateResult();
      } else if (value == '%') {
        if (_input.isNotEmpty) _input += '/100';
      } else {
        _input += value;
      }
    });
  }

  void _calculateResult() {
    try {
      String finalInput = _input
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      final result = _evaluate(finalInput);
      _result = result.toString();
    } catch (e) {
      _result = 'Error';
    }
  }

  double _evaluate(String expression) {
    // Basic expression evaluator using Dart's Expression logic
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  Widget _buildButton(String text, {Color? color}) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey[200],
        foregroundColor: Colors.black,
        padding: const EdgeInsets.all(20),
        shape: const CircleBorder(),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ['C', '⌫', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '=', ''],
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style: const TextStyle(fontSize: 32, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _result,
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons Grid
            ...buttons.map((row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row.map((btnText) {
                  if (btnText == '') return const Spacer();
                  Color? btnColor = (btnText == '=')
                      ? Colors.orange
                      : (['+', '-', '×', '÷'].contains(btnText)
                      ? Colors.blue[100]
                      : null);
                  return _buildButton(btnText, color: btnColor);
                }).toList(),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// Below is a very lightweight expression evaluator used by the _evaluate() function.
class Parser {
  Expression parse(String expression) {
    return Expression(expression);
  }
}

class Expression {
  final String exp;
  Expression(this.exp);

  double evaluate(EvaluationType type, ContextModel cm) {
    // Note: this is very basic and doesn't handle parentheses or complex math
    try {
      return _evaluateSimple(exp);
    } catch (e) {
      throw Exception("Invalid expression");
    }
  }

  double _evaluateSimple(String expr) {
    expr = expr.replaceAll(' ', '');

    List<String> tokens = expr.split(RegExp(r'(?<=[-+*/])|(?=[-+*/])'));

    List<double> values = [];
    List<String> ops = [];

    for (String token in tokens) {
      if (token == '') continue;
      if (RegExp(r'^-?\d+(\.\d+)?$').hasMatch(token)) {
        values.add(double.parse(token));
      } else if ('+-*/'.contains(token)) {
        while (ops.isNotEmpty && _precedence(ops.last) >= _precedence(token)) {
          _applyOp(values, ops.removeLast());
        }
        ops.add(token);
      }
    }

    while (ops.isNotEmpty) {
      _applyOp(values, ops.removeLast());
    }

    return values.first;
  }

  void _applyOp(List<double> values, String op) {
    double b = values.removeLast();
    double a = values.removeLast();
    switch (op) {
      case '+':
        values.add(a + b);
        break;
      case '-':
        values.add(a - b);
        break;
      case '*':
        values.add(a * b);
        break;
      case '/':
        values.add(a / b);
        break;
    }
  }

  int _precedence(String op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
  }
}

enum EvaluationType { REAL }

class ContextModel {}
