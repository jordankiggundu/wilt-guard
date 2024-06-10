import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiltguard/controllers/user_controller.dart';
import 'package:wiltguard/models/user_model.dart';
import 'package:wiltguard/services/database.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  String? userId;

  @override
  void initState() {
    super.initState();
    initializeControllers();
    _fetchUserId();
  }

  void initializeControllers() {
    emailController = TextEditingController(
        text: Provider.of<UserController>(context, listen: false)
                .currentUser
                ?.email ??
            '');
    usernameController = TextEditingController(
        text: Provider.of<UserController>(context, listen: false)
                .currentUser
                ?.username ??
            '');
    passwordController = TextEditingController(
        text: Provider.of<UserController>(context, listen: false)
                .currentUser
                ?.password ??
            '');
  }

  void _fetchUserId() async {
    var currentUser =
        Provider.of<UserController>(context, listen: false).currentUser;
    if (currentUser != null) {
      Map<String, dynamic> userDataMap = currentUser.toJson();
      userId = await DatabaseMethods().getUid(userDataMap);
    }
  }

  Future<void> _updateUserRecord() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userMap = {
        'email': emailController.text.trim(),
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim(),
      };

      await DatabaseMethods().updateUser(userMap, userId);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User updated successfully')));
      //update current user
      UserModel updatedUser = UserModel.fromJson(userMap);
      Provider.of<UserController>(context, listen: false)
          .setCurrentUser(updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.exit_to_app),
                            onPressed: () {
                              Provider.of<UserController>(context,
                                      listen: false)
                                  .setCurrentUser(null);
                              Navigator.pushNamed(context, '/login');
                            },
                          ),
                          const Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.red, // Adjust the color as needed
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          color: Color(0xFF9098B1),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                          letterSpacing: 0.50,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  color: Colors.green,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person_outlined,
                          color: Colors.grey, size: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.orange),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.orange),
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
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.orange),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.orange),
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
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.orange),
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
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateUserRecord,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(300, 55),
                    padding: const EdgeInsets.all(5),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
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
