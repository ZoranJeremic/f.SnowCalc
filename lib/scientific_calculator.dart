import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({super.key});

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  String _display = '';
  String _currentInput = '';
  double? _memory = null;

  void _appendNumber(String number) {
    setState(() {
      _currentInput += number;
      _display = _currentInput;
    });
  }

  void _clear() {
    setState(() {
      _display = '';
      _currentInput = '';
    });
  }

  void _calculate(String function) {
    if (_currentInput.isEmpty) return;

    double? result;
    double input = double.tryParse(_currentInput) ?? 0;

    switch (function) {
      case 'sin':
        result = math.sin(input * math.pi / 180); // Convert to radians
        break;
      case 'cos':
        result = math.cos(input * math.pi / 180);
        break;
      case 'tan':
        result = math.tan(input * math.pi / 180);
        break;
      case 'sqrt':
        result = math.sqrt(input);
        break;
      case 'log':
        result = math.log(input) / math.ln10; // log base 10
        break;
      case 'ln':
        result = math.log(input); // natural log
        break;
      case 'square':
        result = input * input;
        break;
      case 'factorial':
        result = _factorial(input.toInt()).toDouble();
        break;
      case 'π':
        result = math.pi;
        break;
      case 'e':
        result = math.e;
        break;
    }

    if (result != null) {
      setState(() {
        _currentInput = result.toString();
        _display = _currentInput;
      });
    }
  }

  int _factorial(int n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }

  void _memoryOperation(String op) {
    double? currentValue = double.tryParse(_currentInput);
    
    switch (op) {
      case 'MS': // Memory Store
        if (currentValue != null) {
          _memory = currentValue;
        }
        break;
      case 'MR': // Memory Recall
        if (_memory != null) {
          setState(() {
            _currentInput = _memory.toString();
            _display = _currentInput;
          });
        }
        break;
      case 'MC': // Memory Clear
        _memory = null;
        break;
    }
  }

  Widget _buildScientificButton(String text, {VoidCallback? onPressed, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color?.withOpacity(0.8) ?? Colors.grey[700]!,
            color?.withOpacity(0.6) ?? Colors.grey[800]!,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Display
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Text(
                  _display,
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              // Scientific Buttons
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildScientificButton('sin', 
                      onPressed: () => _calculate('sin'),
                      color: Colors.blue),
                    _buildScientificButton('cos', 
                      onPressed: () => _calculate('cos'),
                      color: Colors.blue),
                    _buildScientificButton('tan', 
                      onPressed: () => _calculate('tan'),
                      color: Colors.blue),
                    _buildScientificButton('√', 
                      onPressed: () => _calculate('sqrt'),
                      color: Colors.purple),
                    _buildScientificButton('log', 
                      onPressed: () => _calculate('log'),
                      color: Colors.blue),
                    _buildScientificButton('ln', 
                      onPressed: () => _calculate('ln'),
                      color: Colors.blue),
                    _buildScientificButton('x²', 
                      onPressed: () => _calculate('square'),
                      color: Colors.purple),
                    _buildScientificButton('n!', 
                      onPressed: () => _calculate('factorial'),
                      color: Colors.purple),
                    _buildScientificButton('π', 
                      onPressed: () => _calculate('π'),
                      color: Colors.green),
                    _buildScientificButton('e', 
                      onPressed: () => _calculate('e'),
                      color: Colors.green),
                    _buildScientificButton('MS', 
                      onPressed: () => _memoryOperation('MS'),
                      color: Colors.orange),
                    _buildScientificButton('MR', 
                      onPressed: () => _memoryOperation('MR'),
                      color: Colors.orange),
                    _buildScientificButton('7', 
                      onPressed: () => _appendNumber('7')),
                    _buildScientificButton('8', 
                      onPressed: () => _appendNumber('8')),
                    _buildScientificButton('9', 
                      onPressed: () => _appendNumber('9')),
                    _buildScientificButton('C', 
                      onPressed: _clear,
                      color: Colors.red),
                    _buildScientificButton('4', 
                      onPressed: () => _appendNumber('4')),
                    _buildScientificButton('5', 
                      onPressed: () => _appendNumber('5')),
                    _buildScientificButton('6', 
                      onPressed: () => _appendNumber('6')),
                    _buildScientificButton('MC', 
                      onPressed: () => _memoryOperation('MC'),
                      color: Colors.orange),
                    _buildScientificButton('1', 
                      onPressed: () => _appendNumber('1')),
                    _buildScientificButton('2', 
                      onPressed: () => _appendNumber('2')),
                    _buildScientificButton('3', 
                      onPressed: () => _appendNumber('3')),
                    _buildScientificButton('0', 
                      onPressed: () => _appendNumber('0')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
