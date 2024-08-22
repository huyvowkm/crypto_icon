import 'package:crypto_icon/crypto_icon.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CryptoIcon.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Crypto Icon')),
        body: Center(
          child: FutureBuilder(
            future: CryptoIcon.fromSymbol('ada'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.hasError) {
                return const Text('Error loading SVG');
              }
              return snapshot.data!;
            },
          ),
        ),
      ),
    );
  }
}
