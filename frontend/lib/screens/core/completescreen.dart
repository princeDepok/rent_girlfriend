import 'package:flutter/material.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({super.key});

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF73C3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 450,
                  width: 450,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 133, 202),
                      borderRadius: BorderRadius.circular(900)),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 254, 143, 206),
                          borderRadius: BorderRadius.circular(900)),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 110),
                    child: Container(
                      height: 230,
                      width: 230,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 157, 210),
                          borderRadius: BorderRadius.circular(900)),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 160),
                    child: Container(
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
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            const Text(
              "Booking Success!",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 60, right: 60),
              child: Text(
                "Your request has successfully placed! Soon you will get an email to confirming your booking details",
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
