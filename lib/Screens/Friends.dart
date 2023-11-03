import 'package:flutter/material.dart';
import 'package:miniproject/Screens/ChatScreen.dart';
import 'dart:core';
import 'package:miniproject/SignIn_Up/LoggedIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MyFriends();
  }
}

class _MyFriends extends StatefulWidget {
  @override
  _MyFriendsState createState() => _MyFriendsState();
}

class _MyFriendsState extends State<_MyFriends> {
  final friend_search = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Chats",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 8,
            ),
            SizedBox(
                child: TextField(
                  controller: friend_search,
                  decoration: InputDecoration(
                      hintText: "Find Friends", border: OutlineInputBorder()),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40),
            Text(friend_search.text),
            GestureDetector(
                onTap: () {
                  if (friend_search.text.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(friend_search.text)));
                  }
                  // friend_search.clear();
                },
                child: Icon(Icons.chat)),
          ],
        ),
        SizedBox(height: 20),

        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('F_User')
              
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Column(
              
              children: [
                SizedBox(
                  height:600,
                  
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final doc = documents[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChatScreen(doc.id)));
                                          
                            },
                            child: Container(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      size: 50, // Color for the icon
                                    ),
                                    SizedBox(width: 10), // Add some spacing between the icon and text
                                    Text(
                                      doc.id.split("@")[0][0].toUpperCase()+doc.id.split("@")[0].substring(1),
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                        color: Colors.black, // Color for the text
                                        // fontWeight: FontWeight.bold, // Add font weight if needed
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFFD3D3D3),

                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2), // Box shadow color
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 3, // Blur radius
                                    offset: Offset(0, 3), // Shadow offset
                                  ),
                                ],
                              ),
                            )

                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
