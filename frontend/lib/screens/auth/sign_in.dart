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

  Widget _buildTextField(String key, String hintText, IconData icon,
      {bool obscureText = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: _controllers[key],
      decoration: _inputDecoration(hintText, icon),
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: validator,
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
          await _tokenStorage.saveTokens(accessToken, refreshToken);

          final userId = response.data['user']['id'];
          final userDetailsResponse = await _apiService.getUserDetails(userId, accessToken);

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
                      'Enter your credentials to login.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _buildTextField(
                      'username',
                      'Username',
                      Icons.person,
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
                      Icons.lock,
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
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: _navigateToSignUp,
                          child: const Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white),
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
