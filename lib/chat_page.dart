import 'package:flutter/material.dart';
import 'package:messenger/core/theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3177/3177440.png'),

            ),
            SizedBox(width: 10),
            Text(
              'Aditya',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
            color: Colors.white,
          )
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child:ListView(
            padding: EdgeInsets.all(20),
            children: [
              _buildReceivedMessage( context,"hey my self aditya"),
              _buildSentMessage( context," hi"),
              _buildReceivedMessage( context,"how are you?"),
              _buildSentMessage( context,"  i am fine"),
              _buildReceivedMessage( context," ✌"),
            ],
           
            ),

          ),
           _buildMessageInput(context),


        ]
      )
    );    
  }


  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

    Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: DefaultColors.senderMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  _buildMessageInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),

      child: Row(
        children: [
          GestureDetector(
            child: Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            onTap: () {
              // Handle camera action
            },
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            child: Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onTap: () {
              // Handle send action
            },
          ),
        ],

      ),
    );
  }
}
