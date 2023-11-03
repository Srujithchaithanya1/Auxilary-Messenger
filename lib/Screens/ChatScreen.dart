import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:translator/translator.dart'; // Import the translator package
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  String? userId;
  ChatScreen(String userId) {
    this.userId = userId;
  }

  @override
  Widget build(BuildContext context) {
    return MyChatScreen(userId!);
  }
}

class MyChatScreen extends StatefulWidget {
  final String userId;

  MyChatScreen(this.userId);

  @override
  _MyChatScreenState createState() => _MyChatScreenState();
}

class _MyChatScreenState extends State<MyChatScreen> {
  final myMessageController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final translator =
      GoogleTranslator(); // Create an instance of the GoogleTranslator
  String selectedLanguageCodeFrom = 'en';
  String selectedLanguageCode = 'en'; // Default language code
  List<Map<String, String>> supportedLanguages = [
    {'code': 'ar', 'name': 'Arabic'},
  {'code': 'bn', 'name': 'Bengali'},
  {'code': 'cs', 'name': 'Czech'},
  {'code': 'da', 'name': 'Danish'},
  {'code': 'en', 'name': 'English'},
  {'code': 'fa', 'name': 'Farsi (Persian)'},
  {'code': 'fr', 'name': 'French'},
  {'code': 'de', 'name': 'German'},
  {'code': 'el', 'name': 'Greek'},
  {'code': 'he', 'name': 'Hebrew'},
  {'code': 'hi', 'name': 'Hindi'},
  {'code': 'id', 'name': 'Indonesian'},
  {'code': 'it', 'name': 'Italian'},
  {'code': 'ja', 'name': 'Japanese'},
  {'code': 'ko', 'name': 'Korean'},
  {'code': 'nl', 'name': 'Dutch'},
  {'code': 'pl', 'name': 'Polish'},
  {'code': 'pt', 'name': 'Portuguese'},
  {'code': 'ro', 'name': 'Romanian'},
  {'code': 'ru', 'name': 'Russian'},
   {'code': 'es', 'name': 'Spanish'},
  {'code': 'sv', 'name': 'Swedish'},
  {'code': 'te', 'name': 'Telugu'},
  {'code': 'th', 'name': 'Thai'},
  {'code': 'tr', 'name': 'Turkish'},
  {'code': 'uk', 'name': 'Ukrainian'},
  {'code': 'vi', 'name': 'Vietnamese'},
    // Add more languages as needed
  ];

  Future<String> _translateMessage(String message) async {
    final translation = await translator.translate(
      message,
      to: selectedLanguageCode,
    );
    return translation.text;
  }

  Future<void> _deleteMessage(String messageId) async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(user.email)
        .collection(widget.userId)
        .doc(messageId)
        .delete();

    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(widget.userId)
        .collection(user.email!)
        .doc(messageId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            Text(widget.userId.split("@")[0]),
            
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Chats')
                .doc(user.email)
                .collection(widget.userId)
                .orderBy('timestamp', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    final messageId = doc.id;
                    final message = doc['message'];
                    final timestamp = doc['timestamp'] as Timestamp?;
                    final time =
                        timestamp?.toDate()?.toLocal() ?? DateTime.now();
                    final date = DateFormat('dd/MM/yyyy')
                        .format(timestamp?.toDate() ?? DateTime.now());
                    return FutureBuilder<String>(
                      future: _translateMessage(message),
                      builder: (context, translationSnapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        final translatedMessage =
                            translationSnapshot.data ?? message;
                        return Column(
                          children: [
                            SizedBox(height: 10),
                            Dismissible(
                              key: Key(messageId),
                              onDismissed: (direction) {
                                _deleteMessage(messageId);
                              },
                              background: Container(
                                color: Colors
                                    .red, // Background color when swiped to delete
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: doc["isSent"]
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 80,
                                    // maxHeight: 90,
                                    maxWidth: 300,
                                    minHeight: 50,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: doc["isSent"] ? Color(0xFF0A0E2C) : Color.fromARGB(217, 30, 233, 84),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0), // Add some padding for spacing
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                        children: [
                                          Text(
                                            translatedMessage,
                                            style: TextStyle(
                                              fontSize: 18, // Adjust the font size
                                              color: !doc["isSent"] ? Color(0xFF0A0E2C) : Color.fromARGB(255, 243, 247, 244),
                                              // fontWeight: FontWeight.w600, // Add font weight if needed
                                            ),
                                          ),
                                          SizedBox(height: 4), // Add vertical spacing between text elements
                                          Text(
                                            "$date ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: !doc["isSent"] ? Colors.black : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )

                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: selectedLanguageCode,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLanguageCode = newValue!;
                    });
                  },
                  items: supportedLanguages.map((language) {
                    return DropdownMenuItem<String>(
                      value: language['code'],
                      child: Text(language['name'].toString()),
                    );
                  }).toList(),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: myMessageController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('Chats')
                        .doc(user.email)
                        .collection(widget.userId)
                        .doc()
                        .set({
                      'user_id': user.uid,
                      'message': myMessageController.text,
                      'sender': user.email,
                      'receiver': widget.userId,
                      'isSent': true,
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    await FirebaseFirestore.instance
                        .collection('Chats')
                        .doc(widget.userId)
                        .collection(user.email!)
                        .doc()
                        .set({
                      'user_id': user.uid,
                      'message': myMessageController.text,
                      'receiver': user.email,
                      'sender': widget.userId,
                      'isSent': false,
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    myMessageController.clear();
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
