import 'package:flutter/material.dart';
import 'WeatherHome.dart';
import 'WeatherSignUp.dart'; // Import your WeatherHome screen

class WeatherLogin extends StatefulWidget {
  const WeatherLogin({super.key});

  @override
  State<WeatherLogin> createState() => _WeatherLoginState();
}

class _WeatherLoginState extends State<WeatherLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  InputDecoration _buildInputDecoration(
      String label,
      IconData icon, {
        bool isPassword = false,
        VoidCallback? toggleVisibility,
        bool obscure = false,
      }) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade200,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.black87),
      suffixIcon: isPassword
          ? IconButton(
        icon: Icon(
          obscure ? Icons.visibility : Icons.visibility_off,
          color: Colors.deepPurple,
        ),
        onPressed: toggleVisibility,
      )
          : null,
    );
  }

  void _login() {


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WeatherHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: _buildInputDecoration('Username', Icons.account_circle),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration('Email', Icons.email),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: _buildInputDecoration(
                'Password',
                Icons.lock,
                isPassword: true,
                toggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                obscure: _obscurePassword,
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: _login,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WeatherSignUp()),
                    );
                  },
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
