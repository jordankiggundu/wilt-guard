import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:wiltguard/controllers/user_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? _image;

  Future getImage() async {
    int? result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: const Text(
              'Do you want to select an image from gallery or capture one using camera?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.of(context).pop(1);
              },
            ),
            TextButton(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.of(context).pop(2);
              },
            ),
          ],
        );
      },
    );

    // Map the integer result to ImageSource
    ImageSource? source;
    if (result == 1) {
      source = ImageSource.gallery;
    } else if (result == 2) {
      source = ImageSource.camera;
    } else {
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }

  bool _isLoading = false;

  //gemini  model
  GenerativeModel model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCb9Eq57W632qWyjEbFaO47aQXoTqVuIYA');
  var responseData = '';
  Future<void> checkCoffeeWilt(String imagePath) async {
    // Read the image bytes
    final imageBytes = await File(imagePath).readAsBytes();
    const prompt =
        'Are the leaves in this image infected by coffee wilt? Reply with response only in json format {status: "true/false/unknown", comment:"here, you mention three brief reccomendations for preventions/control of coffee wilt if status:true (coffee wilt detected), None if status:false(not detected,leaves look healthy) or status:unknown(image is not of leaves/leaves have other disease, mention what you see instead)" }';
    // Prepare the content for the request
    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/png', imageBytes),
      ])
    ];
    //return response
    final response = await model.generateContent(content);
    responseData = response.text!;
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      Provider.of<UserController>(context, listen: false)
                          .setCurrentUser(null);
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const SizedBox(width: 8), // Space between icon and text
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
                'Diagnosis',
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
                      borderRadius: BorderRadius.circular(30),
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
        _isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green))
            : ElevatedButton(
                onPressed: () async {
                  if (_image != null) {
                    setState(() {
                      _isLoading = true;
                    });
                    await checkCoffeeWilt(_image!.path);
                    Map<String, dynamic> responseMap = jsonDecode(responseData);
                    String status = responseMap['status'];
                    String comment = responseMap['comment'];

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Infected: $status',
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 20),
                          ),
                          content: Text(
                            comment,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16), // Comment in green
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );

                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(300, 55),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
