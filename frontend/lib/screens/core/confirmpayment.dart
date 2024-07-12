import 'package:flutter/material.dart';
import 'package:frontend/screens/core/completescreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class ConfirmPayment extends StatefulWidget {
  final int duration;
  final String phoneNumber;
  final String date;
  final String time;
  final double totalPrice;
  final int companionId;

  const ConfirmPayment(
      {super.key,
      required this.duration,
      required this.phoneNumber,
      required this.date,
      required this.time,
      required this.totalPrice,
      required this.companionId});

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  File? _selectedImage;
  final ApiService _apiService = ApiService();
  final TokenStorage _tokenStorage = TokenStorage();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _confirmOrder() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a payment proof.")),
      );
      return;
    }

    final userData = await _tokenStorage.getUserData();
    final userId = int.tryParse(userData['user_id'] ?? '');

    if (userId == null) {
      print("User ID is invalid.");
      return;
    }

    final formData = FormData.fromMap({
      "duration": widget.duration,
      "phone_number": widget.phoneNumber,
      "tanggal": widget.date,
      "waktu": widget.time,
      "total_price": widget.totalPrice.toStringAsFixed(2),
      "payment_proof": await MultipartFile.fromFile(_selectedImage!.path),
      "status": "pending",
      "user": userId,
      "companion": widget.companionId,
    });

    try {
      final response = await _apiService.bookCompanion(formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CompletePage()));
      } else {
        // Handle error
        print("Booking failed: ${response.data}");
      }
    } catch (e) {
      // Handle error
      print("Booking error: $e");
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account number copied to clipboard")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20), // Space from the top of the screen
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 30),
              child: Text(
                "Payment",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 19),
            Container(
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Bank BCA",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_up_outlined,
                            size: 40, color: Color(0xff6A6262)),
                      ],
                    ),
                    const Padding(
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
                            const Text(
                              "No. Rekening:",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            const Text(
                              "1290 8089 7789 1465",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                  color: Color(0xffD30202),
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _copyToClipboard("1290 8089 7789 1465"),
                          child: const Icon(
                            Icons.copy,
                            size: 27,
                            color: Color(0xff6A6262),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Divider(
                        thickness: 1.5,
                        color: Color(0xff6A6262),
                      ),
                    ),
                    // Image picker section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Upload Payment Proof",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickImage,
                      child: _selectedImage == null
                          ? Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.grey, width: 2)),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 50,
                              ),
                            )
                          : Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InkWell(
                onTap: _confirmOrder,
                child: Container(
                  height: 55,
                  width: double.infinity,
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
                      'Confirm Order',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), // Extra space to ensure button is at the bottom
          ],
        ),
      ),
    );
  }
}
