import 'package:flutter/material.dart';

class Week02Screen extends StatefulWidget {
  const Week02Screen({super.key});

  @override
  State<Week02Screen> createState() => _Week02ScreenState();
}

class _Week02ScreenState extends State<Week02Screen> {
  final TextEditingController _controller = TextEditingController();

  String? errorText;
  List<int> numbers = [];

  void createList() {
    final input = _controller.text.trim();
    final n = int.tryParse(input);

    if (n == null || n <= 0) {
      setState(() {
        errorText = "Dữ liệu bạn nhập không hợp lệ";
        numbers.clear();
      });
      return;
    }

    setState(() {
      errorText = null;
      numbers = List.generate(n, (index) => index + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(flex: 1), //

              // ===== KHỐI NHẬP =====
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Thực hành 02",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Nhập vào số lượng",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: createList,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,

                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Tạo",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (errorText != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 20),

              // ===== DANH SÁCH THẺ ĐỎ =====
              Expanded(
                child: ListView.builder(
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        numbers[index].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
