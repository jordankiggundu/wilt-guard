import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? _image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Choose image for diagnosis',
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
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: _image == null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            getImage();
                          },
                          icon: const Icon(Icons.add),
                          color: Colors.green,
                          iconSize: 90,
                        ),
                      ),
                    ),
                  ),
                )
              : Image.file(File(_image!.path)),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(300, 55),
            padding: const EdgeInsets.all(16),
          ),
          child: const Text('UPLOAD', style: TextStyle(color: Colors.white),),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
