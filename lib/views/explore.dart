import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Feed',
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
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        feed(context),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

feed(context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: 104,
    padding: const EdgeInsets.only(left: 2, right: 44, bottom: 8),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: Color(0xFFF6F6F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 283,
          child: Text(
            'Header',
            style: TextStyle(
              color: Color(0xFF223263),
              fontSize: 14,
              height: 1.5,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.50,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 283,
          child: Text(
            'A sample text just siting here as a placeholder for this part.',
            style: TextStyle(
              color: Color(0xFF9098B1),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0.50,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 283,
          child: Text(
            'June 3, 2015 5:06 PM',
            style: TextStyle(
              color: Color(0xFF223263),
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0.50,
            ),
          ),
        ),
      ],
    ),
  );
}
