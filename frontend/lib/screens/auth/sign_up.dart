import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_in.dart';
import 'package:frontend/screens/home.dart';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'userName': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'phone': TextEditingController(),
    'placeOfBirth': TextEditingController(),
    'dateOfBirth': TextEditingController(),
  };
  String? _gender;
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

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

      final data = {
        'first_name': _controllers['firstName']!.text,
        'last_name': _controllers['lastName']!.text,
        'username': _controllers['userName']!.text,
        'email': _controllers['email']!.text,
        'password': _controllers['password']!.text,
        'phone_number': _controllers['phone']!.text,
        'gender': _gender,
        'birth_place': _controllers['placeOfBirth']!.text,
        'birth_date': _controllers['dateOfBirth']!.text,
      };

      try {
        final success = await _apiService.registerAndLoginUser(data);
        if (success) {
          _navigateToHome(data);
        } else {
          _showError('Registration or login failed. Please try again.');
        }
      } catch (e) {
        _showError('Error: $e');
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

  void _navigateToSignIn() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  void _navigateToHome(userData) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Home(userData: userData)));
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Welcome to Rent Companion',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your details to sign up.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'Outfit',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            'firstName',
                            'First Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            'lastName',
                            'Last Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'userName',
                      'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'email',
                      'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'password',
                      'Pick a strong password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'confirmPassword',
                      'Confirm Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _controllers['password']!.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'phone',
                      'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Gender'),
                      dropdownColor: Colors.white,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Outfit'),
                      value: _gender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                      items: <String>['Laki-laki', 'Wanita']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'Outfit'),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'placeOfBirth',
                      'Place of Birth',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your place of birth';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'dateOfBirth',
                      'Date of Birth (yyyy-mm-dd)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                        if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                          return 'Please enter a valid date (yyyy-mm-dd)';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          _controllers['dateOfBirth']!.text = formattedDate;
                        }
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
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account? ",
                          style: TextStyle(
                              color: Colors.black54, fontFamily: 'Outfit'),
                        ),
                        GestureDetector(
                          onTap: _navigateToSignIn,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Color(0xFFFF73C3), fontFamily: 'Outfit'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
