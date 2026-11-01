import 'package:flutter/material.dart';

void main() => runApp(const IndiangramApp());

class IndiangramApp extends StatelessWidget {
  const IndiangramApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Indiangram',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: const VerifyPage(),
      );
}

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});
  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  int step = 0; // 0 phone, 1 otp, 2 selfie
  final phone = TextEditingController();
  final otp = TextEditingController();
  String error = '';

  void next() {
    setState(() {
      error = '';
      if (step == 0) {
        if (phone.text.length != 10) {
          error = 'Enter 10 digit number';
        } else {
          step = 1;
        }
      } else if (step == 1) {
        if (otp.text == '123456') {
          step = 2;
        } else {
          error = 'Wrong OTP (test OTP: 123456)';
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const FeedPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Phone number', 'Enter OTP', 'Selfie verification'];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Indiangram',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('One person, one account'),
            const SizedBox(height: 32),
            Text(titles[step], style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            if (step == 0)
              TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      prefixText: '+91 ', border: OutlineInputBorder())),
            if (step == 1)
              TextField(
                  controller: otp,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder())),
            if (step == 2)
              const Column(children: [
                Icon(Icons.face, size: 100),
                Text('Selfie liveness check (real camera check coming next)'),
              ]),
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.redAccent)),
            const SizedBox(height: 16),
            FilledButton(
                onPressed: next,
                child: Text(step == 2 ? 'Verify & continue' : 'Next')),
          ],
        ),
      ),
    );
  }
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.deepPurple,
      Colors.teal,
      Colors.orange,
      Colors.pink,
      Colors.indigo
    ];
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: colors.length,
        itemBuilder: (_, i) => Container(
          color: colors[i],
          child: Stack(children: [
            Center(
                child: Text('Video ${i + 1}',
                    style: const TextStyle(fontSize: 32))),
            const Positioned(
              right: 16,
              bottom: 120,
              child: Column(children: [
                Icon(Icons.favorite, size: 36),
                SizedBox(height: 20),
                Icon(Icons.comment, size: 36),
                SizedBox(height: 20),
                Icon(Icons.share, size: 36),
              ]),
            ),
            Positioned(
                left: 16,
                bottom: 40,
                child: Text('@creator${i + 1}',
                    style: const TextStyle(fontSize: 18))),
          ]),
        ),
      ),
    );
  }
}
