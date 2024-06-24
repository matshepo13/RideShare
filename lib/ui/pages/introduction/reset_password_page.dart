import 'package:flutter/material.dart';
import 'package:lifts_app/services/auth_service.dart';
import 'package:lifts_app/utilities/form_validator.dart';
import 'package:lifts_app/utilities/toast_helper.dart';
import 'package:lifts_app/ui/components/gradient_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  void _resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text.trim();

      try {
        await _authService.resetPassword(email);
        ToastHelper.showSuccessToast(context, 'Password reset email sent!');
        Navigator.pop(context); // Navigate back after successful reset
      } catch (e) {
        ToastHelper.showErrorToast(context, 'Failed to reset password: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15203C),
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: const Color(0xFF15203C),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40.0),
              const Text(
                'Reset your password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email, color: Colors.white),
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => FormValidator.validateEmail(value),
                      ),
                      const SizedBox(height: 20.0),
                      GradientButton(
                        onPressed: _resetPassword,
                        text: 'Send Reset Link',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
