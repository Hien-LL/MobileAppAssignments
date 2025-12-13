import 'package:flutter/material.dart';

class Week02Screen2 extends StatefulWidget {
  const Week02Screen2({super.key});

  @override
  State<Week02Screen2> createState() => _Week02Screen2State();
}

enum Op { add, sub, mul, div }

class _Week02Screen2State extends State<Week02Screen2> {
  final _aCtrl = TextEditingController();
  final _bCtrl = TextEditingController();

  Op? _selected;
  String _resultText = "";

  @override
  void initState() {
    super.initState();
    _aCtrl.addListener(_recalcIfCan);
    _bCtrl.addListener(_recalcIfCan);
  }

  void _recalcIfCan() {
    if (_selected == null) return;
    _calculate(_selected!);
  }

  void _calculate(Op op) {
    final a = double.tryParse(_aCtrl.text.trim());
    final b = double.tryParse(_bCtrl.text.trim());

    if (a == null || b == null) {
      setState(() {
        _selected = op;
        _resultText = "";
      });
      return;
    }

    double? value;
    String? error;

    switch (op) {
      case Op.add:
        value = a + b;
        break;
      case Op.sub:
        value = a - b;
        break;
      case Op.mul:
        value = a * b;
        break;
      case Op.div:
        if (b == 0) {
          error = "Không thể chia cho 0";
        } else {
          value = a / b;
        }
        break;
    }

    setState(() {
      _selected = op;
      if (error != null) {
        _resultText = error;
      } else {
        final isInt = value! % 1 == 0;
        _resultText = isInt ? value.toInt().toString() : value.toString();
      }
    });
  }

  @override
  void dispose() {
    _aCtrl.dispose();
    _bCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              const Text(
                "Thực hành 03",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 18),

              _inputField(_aCtrl),
              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _opButton("+", const Color(0xFFE53935), Op.add),
                  _opButton("-", const Color(0xFFF2B233), Op.sub),
                  _opButton("*", const Color(0xFF5E35F2), Op.mul),
                  _opButton("/", const Color(0xFF222222), Op.div),
                ],
              ),

              const SizedBox(height: 18),
              _inputField(_bCtrl),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _resultText.isEmpty ? "Kết quả:" : "Kết quả: $_resultText",
                ),
              ),

              const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController ctrl) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _opButton(String label, Color color, Op op) {
    final isSelected = _selected == op;

    return GestureDetector(
      onTap: () => _calculate(op),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.black, width: 3)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
