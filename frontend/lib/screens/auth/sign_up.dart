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

  // Input decoration for TextFields
  InputDecoration _inputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.white),
      filled: true,
      fillColor: Colors.white12,
      hintStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
    );
  }

  // Build TextFormField with custom properties
  Widget _buildTextField(String key, String hintText, IconData icon,
      {bool obscureText = false,
      String? Function(String?)? validator,
      VoidCallback? onTap}) {
    return TextFormField(
      controller: _controllers[key],
      decoration: _inputDecoration(hintText, icon),
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: validator,
      onTap: onTap,
    );
  }

  // Submit form and handle API response
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
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
        final response = await _apiService.registerUser(data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Registration successful');

          final loginData = {
            'username': data['email'],
            'password': data['password'],
          };

          final loginResponse = await _apiService.loginUser(loginData);
          if (loginResponse.statusCode == 200) {
            // Save the tokens
            final tokens = loginResponse.data;
            await _apiService.tokenStorage
                .saveTokens(tokens['access'], tokens['refresh']);

            _navigateToHome(response.data);
          } else {
            print('Login failed after registration');
          }
        } else {
          print('Registration failed: ${response.data}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  // Navigate to SignIn screen
  void _navigateToSignIn() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  void _navigateToHome(userData) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Home(userData: userData)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1B2D),
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
                      'Welcome to Chat book',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your details to sign up.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
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
                            Icons.person,
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
                            Icons.person,
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
                      Icons.person,
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
                      Icons.email,
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
                      Icons.lock,
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
                      Icons.lock,
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
                      Icons.phone,
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
                      decoration: _inputDecoration('Gender', Icons.person),
                      dropdownColor: const Color(0xFF1C1B2D),
                      style: const TextStyle(color: Colors.white),
                      value: _gender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                      items: <String>['Laki-Laki', 'Wanita']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
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
                      Icons.location_city,
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
                      Icons.calendar_today,
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
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                      ),
                      child:
                          const Text('Sign Up', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: _navigateToSignIn,
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.purple),
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
