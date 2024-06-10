import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiltguard/controllers/user_controller.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();

  final List<Message> _messages = [];

  // GenerativeModel model;
  GenerativeModel model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCb9Eq57W632qWyjEbFaO47aQXoTqVuIYA');
  bool _isLoading = false;

  Future<void> _sendMessage(String query) async {
    _isLoading = true;
    final content = [Content.text(query)];
    final response = await model.generateContent(content);
    final textResponse = response.text ?? '';

    if (textResponse.isNotEmpty) {
      setState(() {
        _messages.add(Message(query, textResponse));
        _controller.clear();
      });
    }
    _isLoading = false;
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
                'Chat',
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
          padding: EdgeInsets.only(right: 20),
          child: Text(
            'Chat with our Agriculture AI',
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
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _messages[index].query,
                  style: const TextStyle(
                      color: Colors.orange), // Set the title color to orange
                ),
                subtitle: Text(
                  _messages[index].answer,
                  style: const TextStyle(
                      color: Colors.green), // Set the subtitle color to green
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        messageBox(_controller),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget messageBox(TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(top: 11, left: 8, right: 7, bottom: 13),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF39B54A)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green))
                : TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Message here ...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9098B1),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                        letterSpacing: 0.50,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
          ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              color: Colors.green,
              icon: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green))
                  : const Icon(Icons.send),
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    _isLoading = true;
                  });
                  await _sendMessage(_controller.text);
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget message(context, mssg) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.5,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(10),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: const Color(0xFFF6F6F6),
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
          child: Text(
            mssg,
            style: const TextStyle(
              color: Color(0xFF9098B1),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0.50,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

class Message {
  final String query;
  final String answer;
  Message(this.query, this.answer);
}
