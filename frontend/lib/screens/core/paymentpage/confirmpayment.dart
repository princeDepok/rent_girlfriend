import 'package:flutter/material.dart';
import 'package:frontend/screens/core/paymentpage/completescreen.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 15),
            child: Text(
              "Payment",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            height: 19,
          ),
          Container(
            height: 630,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4)
                ]),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Bank BCA",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 201),
                        child: Icon(Icons.keyboard_arrow_up_outlined,
                            size: 40, color: Color(0xff6A6262)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 0, 1, 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xff6A6262),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No. Rekening:",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "1290 8089 7789 1465",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                color: Color(0xffD30202),
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 128),
                        child: Icon(
                          Icons.copy,
                          size: 27,
                          color: Color(0xff6A6262),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xff6A6262),
                    ),
                  ),
                  Text(
                    "The verification process takes less than 10 minutes after a successful payment",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Color(0xff008E9B),
                        fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 8, 1, 8),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xff6A6262),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "mBanking Transfer Instructions",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xff6A6262),
                            fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 86.4),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 40,
                          color: Color(0xff6A6262),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 8, 1, 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xff6A6262),
                    ),
                  ),
                  Text(
                    "1. Open your mobile banking app and select the    'transfer' option.\n2. Choose 'virtual account' as the transfer method and enter the recipient's virtual account number.\n3. Verify the recipient's name and account number before confirming the transfer amount.\n4. Enter any necessary transfer details, such as a description or reference number.\n5. Confirm the transfer and wait for the confirmation message to ensure that the transaction was successful.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Color(0xff6A6262),
                        fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 8, 1, 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xff6A6262),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "iBanking Transfer Instructions",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xff6A6262),
                            fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 97.4),
                        child: Icon(
                          Icons.keyboard_arrow_up_outlined,
                          size: 40,
                          color: Color(0xff6A6262),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 8, 1, 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xff6A6262),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "ATM Transfer Instructions",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xff6A6262),
                            fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 129),
                        child: Icon(
                          Icons.keyboard_arrow_up_outlined,
                          size: 40,
                          color: Color(0xff6A6262),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompletePage()));
            },
            child: Container(
              height: 55,
              width: 360,
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
                  'OK',
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
    );
  }
}
