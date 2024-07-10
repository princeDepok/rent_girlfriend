import 'package:flutter/material.dart';
import 'package:frontend/screens/core/confirmpayment.dart';

class OrderSummary extends StatefulWidget {
  final String profileName;
  final String imagePath;

  const OrderSummary(
      {super.key, required this.profileName, required this.imagePath});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
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
          const SizedBox(height: 18),
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
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 260, // Adjusted height to accommodate new field
            width: 360,
            decoration: BoxDecoration(
                color: const Color(0xFFFF73C3),
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
                        "Name",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Nata",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Age",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "20",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone Number",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "+62 123 456 7890", // Example phone number
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "3 jam",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price",
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
          const SizedBox(height: 18),
          const Spacer(),
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
                            color: const Color(0xFFFF73C3),
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
