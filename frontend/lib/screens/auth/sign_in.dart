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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  final ApiService _apiService = ApiService();
  final TokenStorage _tokenStorage = TokenStorage();
  bool _isLoading = false;

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      bool obscureText = false,
      String? Function(String?)? validator}) {
    return SizedBox(
      height: 68,
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: _buildInputDecoration(hintText),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Outfit',
              ),
              obscureText: obscureText,
              validator: validator,
            ),
          ),
          SizedBox(
            height: _errorMessage != null ? 0 : 0,
            child: _errorMessage != null
                ? Text(
                    _errorMessage!,
                    style: const TextStyle(
                        color: Colors.red, fontFamily: 'Outfit'),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final data = {
        'username': _usernameController.text,
        'password': _passwordController.text,
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

            // Simpan user data ke secure storage
            await _tokenStorage.saveUserData(userData);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home(userData: userData)),
            );
          } else {
            setState(() {
              _errorMessage = 'Failed to retrieve user details.';
            });
            _showErrorSnackbar(_errorMessage!);
          }
        } else if (response.statusCode == 400) {
          setState(() {
            _errorMessage = 'Incorrect username or password.';
          });
          _showErrorSnackbar(_errorMessage!);
        } else {
          setState(() {
            _errorMessage = 'An error occurred. Please try again.';
          });
          _showErrorSnackbar(_errorMessage!);
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
        _showErrorSnackbar(_errorMessage!);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
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
        appBar: AppBar(
          title: const Text(
            'Sign In',
            style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: 75,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your credentials to login.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'Outfit',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _buildTextField(
                      controller: _usernameController,
                      hintText: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: _submitForm,
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF73C3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _navigateToForgotPassword,
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        GestureDetector(
                          onTap: _navigateToSignUp,
                          child: const Text(
                            'Create account',
                            style: TextStyle(
                              color: Color(0xFFFF73C3),
                              fontFamily: 'Outfit',
                            ),
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
