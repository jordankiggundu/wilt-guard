import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [
    "hello man",
    "hello word hello word hell word hello word hello word"
  ];

  void _sendMessage() {
    final String message = _controller.text;
    setState(() {
      _messages.insert(0, message);
      _controller.clear();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                'chat',
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
              return message(context, _messages[index]);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        messageBox(_controller, _sendMessage),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget messageBox(
      TextEditingController controller, VoidCallback sendMessage) {
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
            child: TextField(
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
              icon: const Icon(Icons.send),
              onPressed: sendMessage,
            ),
          )
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
