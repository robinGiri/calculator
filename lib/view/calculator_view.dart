import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  List<String> button = [
    'C',
    '*',
    '/',
    '<--',
    '1',
    '2',
    '3',
    '-',
    '4',
    '5',
    '6',
    '%',
    '7',
    '8',
    '9',
    '%', // Note: You have '%' twice in your list, you might want to check this.
    '+',
    '0',
    '.',
    '=',
  ];
  final numberController = TextEditingController();
  String currentOperator = '';
  double firstOperand = 0.0;
  String displayedOperand =
      ''; // State variable to store the operand before operator is pressed

  void handleButtonPress(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          numberController.text = '';
          currentOperator = '';
          firstOperand = 0.0;
          displayedOperand = ''; // Reset the displayed operand
          break;
        case '<--':
          if (numberController.text.isNotEmpty) {
            numberController.text = numberController.text
                .substring(0, numberController.text.length - 1);
          }
          break;
        case '=':
          if (currentOperator.isNotEmpty && numberController.text.isNotEmpty) {
            double secondOperand = double.parse(numberController.text);
            double result =
                performOperation(firstOperand, secondOperand, currentOperator);
            numberController.text = result.toString();
            currentOperator = '';
            displayedOperand = ''; // Clear displayed operand after calculation
          }
          break;
        case '*':
        case '/':
        case '+':
        case '-':
        case '%':
          if (numberController.text.isNotEmpty) {
            firstOperand = double.parse(numberController.text);
            displayedOperand = numberController
                .text; // Store the first operand before clearing
            currentOperator = buttonText;
            numberController.text = '';
          }
          break;
        default:
          numberController.text += buttonText;
      }
    });
  }

  double performOperation(
      double firstOperand, double secondOperand, String operator) {
    switch (operator) {
      case '*':
        return firstOperand * secondOperand;
      case '/':
        return firstOperand / secondOperand;
      case '+':
        return firstOperand + secondOperand;
      case '-':
        return firstOperand - secondOperand;
      case '%':
        return firstOperand % secondOperand;
      default:
        throw Exception('Invalid operator: $operator');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Robin Calculator"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: numberController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Number',
                labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                prefixText:
                    displayedOperand.isNotEmpty ? '$displayedOperand ' : null,
                prefixStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              style: TextStyle(fontSize: 24),
              validator: (value) =>
                  value!.isEmpty ? "Please enter a number" : null,
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(8),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: 4,
              children: [
                for (int i = 0; i < button.length; i++) ...{
                  SizedBox(
                    child: ElevatedButton(
                      child: Text(
                        button[i],
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () => handleButtonPress(button[i]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}
