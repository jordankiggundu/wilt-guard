import 'package:flutter/material.dart';
import './components/registration_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.32,
              top: MediaQuery.of(context).size.height * 0.3,
              child: const Material(
                  child: Text(
                'Create an new account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9098B1),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0.15,
                  letterSpacing: 0.50,
                ),
              )),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.3,
              top: MediaQuery.of(context).size.height * 0.25,
              child: const SizedBox(
                width: 170,
                height: 25,
                child: Material(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Wilt ',
                          style: TextStyle(
                            color: Color(0xFF39B54A),
                            fontSize: 32,
                            fontFamily: 'Sarala',
                            fontWeight: FontWeight.w700,
                            height: 0.02,
                            letterSpacing: 0.50,
                          ),
                        ),
                        TextSpan(
                          text: 'Guard',
                          style: TextStyle(
                            color: Color(0xFFF7931E),
                            fontSize: 32,
                            fontFamily: 'Sarala',
                            fontWeight: FontWeight.w700,
                            height: 0.02,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.4,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                width: 80,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.32,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const RegistrationForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
