import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';

class CompanionRegister extends StatefulWidget {
  const CompanionRegister({super.key});

  @override
  State<CompanionRegister> createState() => _CompanionRegisterState();
}

class _CompanionRegisterState extends State<CompanionRegister> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'fullname': TextEditingController(),
    'id_card': TextEditingController(),
    'phone_number': TextEditingController(),
    'bank_account_number': TextEditingController(),
    'bio': TextEditingController(),
    'tags': TextEditingController(),
    'experience': TextEditingController(),
    'location': TextEditingController(),
    'instagram_account': TextEditingController(),
  };
  bool _isLoading = false;
  String? _selectedBank;
  List<String> _selectedServices = [];

  final List<String> _bankOptions = ['BCA', 'Mandiri', 'BSI', 'CIMB'];
  final List<String> _servicesOptions = [
    'Sleep Call',
    'Dating',
    'Gaming',
    'Hangout',
    'Kondangan',
    'Curhat'
  ];

  final ApiService _apiService = ApiService();

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF9EA1A8),
        fontWeight: FontWeight.normal,
        fontSize: 12,
        fontFamily: 'Outfit',
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF9EA1A8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF9EA1A8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF9EA1A8)),
      ),
      errorMaxLines: 2,
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 9,
        fontFamily: 'Outfit',
      ),
    );
  }

  Widget _buildTextField(String key, String hintText,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator,
      VoidCallback? onTap}) {
    return TextFormField(
      controller: _controllers[key],
      decoration: _inputDecoration(hintText),
      style: const TextStyle(color: Colors.black, fontFamily: 'Outfit'),
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      onTap: onTap,
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final servicesOffered = {
        for (var service in _selectedServices) service.toLowerCase(): service
      };

      final formattedServicesOffered = servicesOffered.map((key, value) => MapEntry('"$key"', '"$value"'));

      final data = {
        'fullname': _controllers['fullname']!.text,
        'id_card': _controllers['id_card']!.text,
        'phone_number': _controllers['phone_number']!.text,
        'bank_account': _selectedBank,
        'bank_account_number': _controllers['bank_account_number']!.text,
        'bio': _controllers['bio']!.text,
        'tags': _controllers['tags']!.text,
        'experience': _controllers['experience']!.text,
        'services_offered': formattedServicesOffered,
        'instagram_account': _controllers['instagram_account']!.text,
        'available': false,
        'location': _controllers['location']!.text,
      };

      print('Sending data: $data');

      try {
        final response = await _apiService.registerCompanion(data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Registration successful');
        } else {
          _showError('Registration failed: ${response.data}');
          print('Error: ${response.statusCode} ${response.data}');
        }
      } catch (e) {
        _showError('Error: $e');
        print('Error: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  Widget _buildLoadingOverlay() {
    if (!_isLoading) return Container();
    return Container(
      color: Colors.black54,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Companion Register'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Companion Register',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          'fullname',
                          'Full Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'id_card',
                          'ID Card',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your ID card number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'phone_number',
                          'Phone Number',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedBank,
                          hint: const Text('Select Bank'),
                          items: _bankOptions
                              .map((bank) => DropdownMenuItem<String>(
                                    value: bank,
                                    child: Text(bank),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedBank = value;
                            });
                          },
                          decoration: _inputDecoration('Select Bank'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your bank';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'bank_account_number',
                          'Bank Account Number',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your bank account number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'bio',
                          'Bio',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your bio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'tags',
                          'Tags',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your tags';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'experience',
                          'Experience',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your experience';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'location',
                          'Location',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your location';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'instagram_account',
                          'Instagram Account',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Instagram account';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        MultiSelectChip(
                          _servicesOptions,
                          onSelectionChanged: (selectedList) {
                            setState(() {
                              _selectedServices = selectedList;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : GestureDetector(
                                onTap: _submitForm,
                                child: Container(
                                  height: 48,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF73C3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildLoadingOverlay(),
          ],
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {required this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
