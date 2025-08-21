import 'package:flutter/material.dart';
import 'scientific_calculator.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '';
  String _currentInput = '';
  String _previousInput = '';
  String? _operation;

  void _appendNumber(String number) {
    setState(() {
      _currentInput += number;
      _display = _currentInput;
    });
  }

  void _appendOperator(String op) {
    if (_currentInput.isEmpty) return;

    if (_previousInput.isNotEmpty) {
      _calculate();
    }

    setState(() {
      _operation = op;
      _previousInput = _currentInput;
      _currentInput = '';
    });
  }

  void _calculate() {
    if (_currentInput.isEmpty || _previousInput.isEmpty || _operation == null) {
      return;
    }

    double result;
    double prev = double.parse(_previousInput);
    double current = double.parse(_currentInput);

    switch (_operation) {
      case '+':
        result = prev + current;
        break;
      case '-':
        result = prev - current;
        break;
      case '×':
        result = prev * current;
        break;
      case '÷':
        result = prev / current;
        break;
      default:
        return;
    }

    setState(() {
      _currentInput = result.toString();
      _display = _currentInput;
      _previousInput = '';
      _operation = null;
    });
  }

  void _clear() {
    setState(() {
      _display = '';
      _currentInput = '';
      _previousInput = '';
      _operation = null;
    });
  }

  Widget _buildButton(String text, {Color? color, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color?.withOpacity(0.8) ?? Colors.grey[800]!,
            color?.withOpacity(0.6) ?? Colors.grey[900]!,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 24, color: Colors.white),
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
        title: const Text('Calculator'),
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[850],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey[900]!,
                      Colors.grey[800]!,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Calculator Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Made with 💜 for bros',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.calculate_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  'Basic Calculator',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.science,
                  color: Colors.white,
                ),
                title: const Text(
                  'Scientific Calculator',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'For advanced calculations',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScientificCalculator(),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: Colors.white70,
                ),
                title: const Text(
                  'About',
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('About Calculator'),
                      content: const Text(
                        'A cool calculator app made with Flutter! 🚀\n\n'
                        'Features:\n'
                        '• Basic calculations\n'
                        '• Scientific functions\n'
                        '• Memory operations\n'
                        '• Awesome UI/UX',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cool!'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
              // Buttons
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildButton('C', 
                      color: Colors.red, 
                      onPressed: _clear),
                    _buildButton('7', 
                      onPressed: () => _appendNumber('7')),
                    _buildButton('8', 
                      onPressed: () => _appendNumber('8')),
                    _buildButton('9', 
                      onPressed: () => _appendNumber('9')),
                    _buildButton('÷', 
                      color: Colors.orange, 
                      onPressed: () => _appendOperator('÷')),
                    _buildButton('4', 
                      onPressed: () => _appendNumber('4')),
                    _buildButton('5', 
                      onPressed: () => _appendNumber('5')),
                    _buildButton('6', 
                      onPressed: () => _appendNumber('6')),
                    _buildButton('×', 
                      color: Colors.orange, 
                      onPressed: () => _appendOperator('×')),
                    _buildButton('1', 
                      onPressed: () => _appendNumber('1')),
                    _buildButton('2', 
                      onPressed: () => _appendNumber('2')),
                    _buildButton('3', 
                      onPressed: () => _appendNumber('3')),
                    _buildButton('-', 
                      color: Colors.orange, 
                      onPressed: () => _appendOperator('-')),
                    _buildButton('0', 
                      onPressed: () => _appendNumber('0')),
                    _buildButton('.', 
                      onPressed: () => _appendNumber('.')),
                    _buildButton('=', 
                      color: Colors.orange, 
                      onPressed: _calculate),
                    _buildButton('+', 
                      color: Colors.orange, 
                      onPressed: () => _appendOperator('+')),
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
