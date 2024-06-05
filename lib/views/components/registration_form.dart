import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../../services/database.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
            child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.orange,
              ),
              labelText: 'Username',
              labelStyle: TextStyle(
                color: Colors.orange,
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            controller: _usernameController,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.orange,
              ),
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.orange,
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
            controller: _emailController,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.orange,
              ),
              labelText: 'Password',
              labelStyle: TextStyle(
                color: Colors.orange,
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            controller: _passwordController,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.orange,
              ),
              labelText: 'Confirm Password',
              labelStyle: TextStyle(
                color: Colors.orange,
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              String pass = _passwordController.text;
              if (value != pass) {
                return 'Passwords do not match';
              }
              return null;
            },
            // controller: _passwordController,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              _isLoading = true;
              if (_formKey.currentState!.validate()) {
                String id = randomAlphaNumeric(10);
                String username = _usernameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;

                Map<String, dynamic> userInfo = {
                  "username": username,
                  "email": email,
                  "password": password,
                };
                try {
                  await DatabaseMethods().addUser(userInfo, id);
                  _isLoading = false;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("REGISTERED"),
                        content: const Text("Account created successfully"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/login');
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  // Handle any errors that might occur during database operation
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "ERROR",
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text("Error occurred."),
                        actions: [
                          TextButton(
                            onPressed: () {},
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
              _isLoading = false;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(300, 55),
              padding: const EdgeInsets.all(16),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange))
                : const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Got an account? ',
                  style: TextStyle(
                    color: Color(0xFF9098B1),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                    letterSpacing: 0.50,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context,
                          '/login'); // Replace '/signup' with the actual route
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Color(0xFF39B54A),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
