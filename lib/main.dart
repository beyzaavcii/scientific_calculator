import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const ScientificCalculatorApp());
}

class ScientificCalculatorApp extends StatelessWidget {
  const ScientificCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scientific Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _expression = "";

  // Çalışacak fonksiyonumuz
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
      } else if (buttonText == "⌫") {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
        if (_expression.isEmpty) {
          _output = "0";
        } else {
          _output = _expression;
        }
      } else if (buttonText == "=") {
        try {
          _output = _evaluateExpression();
        } catch (e) {
          _output = "Hata";
        }
      } else {
        if (_output == "0" && !["+", "-", "×", "÷", "^"].contains(buttonText)) {
          _expression = buttonText;
        } else {
          _expression += buttonText;
        }
        _output = _expression;
      }
    });
  }

  // İfadeyi matematiksel olarak çözen fonksiyon
  String _evaluateExpression() {
    try {
      String expression = _expression;
      
      // 1. Durum: sin(x) için radyan dönüşümü
      if (expression.contains('sin(')) {
        int startIndex = expression.indexOf('sin(') + 4;
        int endIndex = expression.indexOf(')', startIndex);
        String valueStr = expression.substring(startIndex, endIndex);
        double angle = double.parse(valueStr);
        
        double result = math.sin(angle * math.pi / 180);
        return result.toStringAsFixed(4).replaceAll(RegExp(r'\.?0+$'), '');
      }

      // 2. Durum: cos(x) için radyan dönüşümü
      if (expression.contains('cos(')) {
        int startIndex = expression.indexOf('cos(') + 4;
        int endIndex = expression.indexOf(')', startIndex);
        String valueStr = expression.substring(startIndex, endIndex);
        double angle = double.parse(valueStr);
        
        double result = math.cos(angle * math.pi / 180);
        return result.toStringAsFixed(4).replaceAll(RegExp(r'\.?0+$'), '');
      }

      // 3. Durum: tan(x) için radyan dönüşümü
      if (expression.contains('tan(')) {
        int startIndex = expression.indexOf('tan(') + 4;
        int endIndex = expression.indexOf(')', startIndex);
        String valueStr = expression.substring(startIndex, endIndex);
        double angle = double.parse(valueStr);
        
        double result = math.tan(angle * math.pi / 180);
        if (result.abs() > 100000) return "Hata";
        return result.toStringAsFixed(4).replaceAll(RegExp(r'\.?0+$'), '');
      }

      // 4. Durum: log(x) fonksiyonu (10 tabanına çevirme)
      if (expression.contains('log(')) {
        int startIndex = expression.indexOf('log(') + 4;
        int endIndex = expression.indexOf(')', startIndex);
        String valueStr = expression.substring(startIndex, endIndex);
        double value = double.parse(valueStr);
        
        if (value <= 0) return "Hata";
        double result = math.log(value) / math.ln10;
        return result.toStringAsFixed(4).replaceAll(RegExp(r'\.?0+$'), '');
      }

      // 5. Durum: Standart matematiksel işlemler (Karekök, toplama, çarpma vb.)
      String parseExpression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(parseExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      if (eval % 1 == 0) {
        return eval.toInt().toString();
      }
      return eval.toStringAsFixed(4);
      
    } catch (e) {
      return "Hata";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Ekran Bölümü
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: Colors.black,
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          
          // Butonlar Bölümü
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildButtonRow(["sin(", "cos(", "tan(", "log("], [
                  const Color(0xFF4A6572),
                  const Color(0xFF4A6572),
                  const Color(0xFF4A6572),
                  const Color(0xFF4A6572),
                ]),
                const SizedBox(height: 8),
                _buildButtonRow(["sqrt(", "^", "(", ")"], [
                  const Color(0xFF4A6572),
                  const Color(0xFF4A6572),
                  const Color(0xFF4A6572),
                  const Color(0xFF4A6572),
                ]),
                const SizedBox(height: 8),
                _buildButtonRow(["7", "8", "9", "÷"], [
                  const Color(0xFF333333),
                  const Color(0xFF333333),
                  const Color(0xFF333333),
                  const Color(0xFFE68F00), // Turuncu
                ]),
                const SizedBox(height: 8),
                _buildButtonRow(["4", "5", "6", "×"], [
                  const Color(0xFF333333),
                  const Color(0xFF333333),
                  const Color(0xFF333333),
                  const Color(0xFFE68F00),
                ]),
                const SizedBox(height: 8),
                _buildButtonRow(["1", "2", "3", "-"], [
                  const Color(0xFF333333),
                  const Color(0xFF333333),
                  const Color(0xFF333333),
                  const Color(0xFFE68F00),
                ]),
                const SizedBox(height: 8),
                _buildButtonRow(["0", ".", "⌫", "+"], [
                  const Color(0xFF333333),
                  const Color(0xFF333333),
                  const Color(0xFFE65100), 
                  const Color(0xFFE68F00),
                ]),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD32F2F), 
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () => _buttonPressed("C"),
                        child: const Text("C", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF388E3C), 
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () => _buttonPressed("="),
                        child: const Text("=", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> labels, List<Color> colors) {
    return Row(
      children: List.generate(labels.length, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors[index],
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
              onPressed: () => _buttonPressed(labels[index]),
              child: Text(
                labels[index],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}