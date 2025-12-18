import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment Selection OOP',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const PaymentScreen(),
    );
  }
}

// --- PHẦN OOP: ABSTRACT CLASS (TÍNH TRỪU TƯỢNG) ---
abstract class PaymentMethod {
  final String name;
  final String iconAsset;
  final String bannerAsset;
  final double iconWidth; // Thuộc tính điều khiển độ rộng logo

  PaymentMethod({
    this.iconWidth = 40.0, // Giá trị mặc định cho các bên khác
    required this.name,
    required this.iconAsset,
    required this.bannerAsset,
  });

  void process() {
    print("Đang xử lý thanh toán qua $name...");
  }
}

// --- INHERITANCE (TÍNH KẾ THỪA) ---
class PayPalMethod extends PaymentMethod {
  PayPalMethod() : super(
    name: "PayPal",
    iconAsset: "assets/paypal.webp",
    bannerAsset: "assets/paypal.webp",
    iconWidth: 90.0, // Chỉnh PayPal to hẳn lên ở đây
  );
}

class GooglePayMethod extends PaymentMethod {
  GooglePayMethod() : super(
    name: "GooglePay",
    iconAsset: "assets/gg.png",
    bannerAsset: "assets/gg.png",
    iconWidth: 50.0,
  );
}

class ApplePayMethod extends PaymentMethod {
  ApplePayMethod() : super(
    name: "ApplePay",
    iconAsset: "assets/apple.png",
    bannerAsset: "assets/apple.png",
    iconWidth: 40.0,
  );
}

// --- GIAO DIỆN CHÍNH ---
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<PaymentMethod> methods = [
    PayPalMethod(),
    GooglePayMethod(),
    ApplePayMethod(),
  ];

  PaymentMethod? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chọn hình thức thanh toán",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Banner hiển thị ảnh to
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: selectedMethod == null
                    ? const Icon(Icons.add_business_rounded, size: 100, color: Colors.grey)
                    : Image.asset(selectedMethod!.bannerAsset, fit: BoxFit.contain),
              ),
            ),
          ),

          // Danh sách lựa chọn
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  final item = methods[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: selectedMethod == item ? Colors.blue : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: RadioListTile<PaymentMethod>(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),

                      // CẬP NHẬT Ở ĐÂY: Sử dụng item.iconWidth thay vì số 60 cố định
                      secondary: SizedBox(
                        width: 100, // Cố định khung chứa để các radio button thẳng hàng
                        child: Center(
                          child: Image.asset(item.iconAsset, width: item.iconWidth),
                        ),
                      ),

                      value: item,
                      groupValue: selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedMethod = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Nút Continue
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: selectedMethod == null ? null : () {
                  selectedMethod!.process();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Continue", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}