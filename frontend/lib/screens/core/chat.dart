import 'package:flutter/material.dart';
import 'package:frontend/screens/core/profile.dart';
import 'package:frontend/screens/home.dart';

class ChatPage extends StatelessWidget {
  final List<Message> messages = [
    Message(
      profile: Profile(
        imagePath: 'assets/images/kennoy.jpeg',
        name: 'Ahmad',
        description: 'Hey Rayhan...',
        gender: 'Female',
        about: '',
      ),
      time: '04:29 PM',
      isMe: false,
    ),
    Message(
      profile: Profile(
        imagePath: 'assets/images/kennoy.jpeg',
        name: 'Ahmad',
        description:
            'I was thinking about our first date today. Remember how nervous we both were?',
        gender: 'Male',
        about: '',
      ),
      time: '05:30 PM',
      isMe: false,
    ),
    Message(
      profile: Profile(
        imagePath: 'assets/images/kennoy.jpeg',
        name: 'Ahmad',
        description:
            'Oh, I remember! You could barely hold your fork steady. But it was endearing. I think that’s when I knew there was something special about you.',
        gender: 'Male',
        about: '',
      ),
      time: '06:30 PM',
      isMe: true,
    ),
    Message(
      profile: Profile(
        imagePath: 'assets/images/kennoy.jpeg',
        name: 'Ahmad',
        description:
            'Really? I thought you might have been put off by my clumsiness.',
        gender: 'Female',
        about: '',
      ),
      time: '04:29 PM',
      isMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/kennoy.jpeg'),
            ),
            SizedBox(width: 10),
            Text(
              'Ahmad',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(message: message);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 239, 235, 235),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Color(0xFFFF73C3),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final Profile profile;
  final String time;
  final bool isMe;

  Message({required this.profile, required this.time, this.isMe = false});
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!message.isMe) SizedBox(width: 15), // Add space on the left
          Expanded(
            child: Align(
              alignment:
                  message.isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: message.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!message.isMe)
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage(message.profile.imagePath),
                        ),
                        SizedBox(width: 10),
                        Text(
                          message.profile.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color:
                          message.isMe ? Color(0xFFFF73C3) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: message.isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.profile.description,
                          style: TextStyle(
                            color: message.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 3),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message.time,
                            style: TextStyle(
                              color: message.isMe ? Colors.white : Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe)
            SizedBox(
                width: 10), // Add space on the right for the user's messages
        ],
      ),
    );
  }
}
