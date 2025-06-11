// lib/features/auth/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await context.read<AuthService>().login(
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;
    } catch (e) {
      setState(() {
        _error = 'Invalid credentials. Try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child:
                  _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
