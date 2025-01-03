import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  double num1 = 0;
  double num2 = 0;
  String operator = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
        num1 = 0;
        num2 = 0;
        operator = '';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷') {
        num1 = double.parse(display);
        operator = buttonText;
        display = '0';
      } else if (buttonText == '=') {
        num2 = double.parse(display);
        if (operator == '+') {
          display = (num1 + num2).toString();
        } else if (operator == '-') {
          display = (num1 - num2).toString();
        } else if (operator == '×') {
          display = (num1 * num2).toString();
        } else if (operator == '÷') {
          if (num2 != 0) {
            display = (num1 / num2).toString();
          } else {
            display = 'Erro';
          }
        }
        num1 = 0;
        num2 = 0;
        operator = '';
      } else {
        display = display == '0' ? buttonText : display + buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Fundo escuro para um contraste legal
      appBar: AppBar(
        title: Text(
          'Calculadora',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.white30,
          ),
          Column(
            children: <Widget>[
              _buildButtonRow(['7', '8', '9', '÷']),
              _buildButtonRow(['4', '5', '6', '×']),
              _buildButtonRow(['1', '2', '3', '-']),
              _buildButtonRow(['C', '0', '=', '+']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttonText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonText.map((text) {
        return _buildButton(text);
      }).toList(),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => buttonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: buttonText == 'C' || buttonText == '=' ? Colors.black : Colors.white,
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
        shape: MaterialStateProperty.all(CircleBorder()),
        backgroundColor: MaterialStateProperty.all(
          buttonText == 'C' || buttonText == '=' ? Colors.greenAccent : Colors.blueAccent,
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(8),
      ),
    );
  }
}

