import 'package:flutter/material.dart';
import 'package:frontend/screens/core/paymentpage/confirmpayment.dart';

class PaymentScreen extends StatefulWidget {
  final String profileName;
  final String imagePath;

  const PaymentScreen(
      {super.key, required this.profileName, required this.imagePath});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 54),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.profileName,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
              height: 200,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFFE8E8E8),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              )),
          const SizedBox(
            height: 18,
          ),
          Container(
            height: 200,
            width: 360,
            decoration: BoxDecoration(
                color: Color(0xFFFF73C3),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4)
                ]),
            child: const Padding(
              padding: EdgeInsets.only(top: 20, left: 24, right: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Summary",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "21 June 2024",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 6, 1, 6),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Package",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Teman Curhat",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Rp15.000",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Order",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp17.000",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            height: 156,
            width: 360,
            decoration: BoxDecoration(
                color: Color(0xFFFF73C3),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Methods",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 38),
                        child: Icon(
                          Icons.keyboard_arrow_up_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(1, 0, 1, 12),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 51,
                        width: 312,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              // offset: Offset(0, 4),
                              color: Colors.white,
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                              child: Text(
                                'BANK BCA',
                                style: TextStyle(
                                  fontSize:
                                      24, // Adjust the font size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          Stack(
            children: [
              Container(
                height: 90,
                width: double.maxFinite,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'Rp17.000',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xffd30202),
                                fontSize: 30,
                                fontWeight: FontWeight.w400)),
                        // TextSpan(
                        //     text: '/malam',
                        //     style: TextStyle(
                        //         fontFamily: 'Poppins',
                        //         fontSize: 11,
                        //         color: Color(0xff6a6262),
                        //         fontWeight: FontWeight.normal))
                      ])),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ConfirmPayment()));
                      },
                      child: Container(
                        height: 60,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFFF73C3),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4)
                            ]),
                        child: const Center(
                          child: Text(
                            'Pay Now',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
