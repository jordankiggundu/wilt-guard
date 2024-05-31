import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: <Widget>[
                Center(
                    child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Align(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/login');
                        },
                        minWidth: 306,
                        height: 57,
                        color: const Color(0xFF39B54A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 10,
                        child: const Text(
                          'Get started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0.13,
                            letterSpacing: 0.50,
                          ),
                        ),
                      )),
                )),
                const Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Material(
                      child: SizedBox(
                        width: 170,
                        height: 34,
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
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    width: 84.90,
                    height: 129.59,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
