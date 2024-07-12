import 'package:flutter/material.dart';
import 'package:frontend/screens/home.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({super.key});

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF73C3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    height: 450,
                    width: 450,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 133, 202),
                        borderRadius: BorderRadius.circular(900)),
                  ),
                ),
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 254, 143, 206),
                        borderRadius: BorderRadius.circular(900)),
                  ),
                ),
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    height: 230,
                    width: 230,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 157, 210),
                        borderRadius: BorderRadius.circular(900)),
                  ),
                ),
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(900)),
                  child: const Icon(
                    Icons.check,
                    size: 90,
                    color: Color(0xFFFF73C3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            const Text(
              "Booking Success!",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                "Your request has successfully placed! Soon you will get a WhatsApp message confirming your booking details.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
