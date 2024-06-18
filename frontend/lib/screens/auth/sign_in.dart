import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/sign_up.dart';
import '../../services/api_service.dart';
import '../../services/token_storage.dart';
import 'package:frontend/screens/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'username': TextEditingController(),
    'password': TextEditingController(),
  };
  String? _errorMessage;
  final ApiService _apiService = ApiService();
  final TokenStorage _tokenStorage = TokenStorage();

  Widget _buildTextField(String key, String hintText,
      {bool obscureText = false, String? Function(String?)? validator}) {
    return SizedBox(
      height: 68, // Increased height to accommodate error message
      child: TextFormField(
        controller: _controllers[key],
        decoration: _inputDecoration(hintText),
        style: const TextStyle(color: Colors.black),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Color(0xFF9EA1A8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Color(0xFF9EA1A8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Color(0xFF9EA1A8)),
      ),
      errorMaxLines: 2, // Allows the error text to wrap into multiple lines
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 14, // Increased font size for better readability
      ),
      hintStyle: TextStyle(
          color: Color(0xFF9EA1A8),
          fontWeight: FontWeight.normal,
          fontSize: 12),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'username': _controllers['username']!.text,
        'password': _controllers['password']!.text,
      };

      try {
        final response = await _apiService.loginUser(data);
        if (response.statusCode == 200) {
          setState(() {
            _errorMessage = null;
          });
          final accessToken = response.data['access'];
          final refreshToken = response.data['refresh'];
          final userId = response.data['user_id'];

          await _tokenStorage.saveTokens(accessToken, refreshToken);
          await _tokenStorage.saveUserId(userId.toString());

          final userDetailsResponse =
              await _apiService.getUserDetails(userId, accessToken);

          if (userDetailsResponse.statusCode == 200) {
            final userData = userDetailsResponse.data;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home(userData: userData)),
            );
          } else {
            setState(() {
              _errorMessage = 'Failed to retrieve user details.';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Incorrect email or password.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
      }
    }
  }

  void _navigateToSignUp() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  void _navigateToForgotPassword() {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
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
                      'Welcome to Rent Companion',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your credentials to login.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _buildTextField(
                      'username',
                      'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'password',
                      'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _navigateToForgotPassword,
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: _submitForm,
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF73C3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: _navigateToSignUp,
                          child: const Text(
                            'Create Account',
                            style: TextStyle(color: Colors.black),
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
