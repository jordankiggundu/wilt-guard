import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:wiltguard/models/user_model.dart";

import "../../controllers/user_controller.dart";
import "../../services/database.dart";

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.mail,
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
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              _isLoading = true;
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text;
                String password = _passwordController.text;

                Map<String, dynamic> userInfo = {
                  "email": email,
                  "password": password,
                };
                Map<String, dynamic> result;
                try {
                  result = await DatabaseMethods()
                      .getUser(userInfo["email"], userInfo["password"]);
                } catch (e) {
                  // Handle any errors that might occur during database operation
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text(
                          "ERROR",
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text("Please check your details"),
                      );
                    },
                  );
                  _isLoading = false;
                  return; // Exit early if there was an error
                }
                _isLoading = false;
                if (result["exists"]) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("WELCOME",
                            style: TextStyle(color: Colors.green)),
                        content: const Text("Logged in successfully :",
                            style: TextStyle(color: Colors.orange)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  ).then((_) {
                    // Check if response Data is not null before proceeding
                    if (result['data'] != null &&
                        result.containsKey('data') &&
                        result['data'] != null) {
                      Map<String, dynamic> userData = result['data'];
                      UserModel userModel = UserModel.fromJson(userData);
                      Provider.of<UserController>(context, listen: false)
                          .setCurrentUser(userModel);

                      Future.microtask(() {
                        Navigator.pushNamed(context, '/home');
                      });
                    }
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text(
                          "ERROR",
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text("Please check your details / connection"),
                      );
                    },
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(300, 55),
              padding: const EdgeInsets.all(16),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange))
                : const Text('LOGIN', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 30),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.3,
            child: Material(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(
                        color: Color(0xFF9098B1),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.50,
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          ' Sign Up',
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
            ),
          ),
        ],
      ),
    ));
  }
}
