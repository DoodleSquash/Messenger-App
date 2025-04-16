import 'package:flutter/material.dart';
import 'package:messenger/core/theme.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(
            icon:  Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
            color: Colors.white,
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Recent',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Container(
            height:100,
            padding: EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact('Aditya',context),
                _buildRecentContact('Omkar',context),
                _buildRecentContact('Yash',context), 
                _buildRecentContact('Vraj',context),
                _buildRecentContact('JK Gaming',context),
                
              ],
            ),
          ),

          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: [
                  _buildMessageTile('Aditya', 'Hey, how are you?', '10:30 AM'),
                  _buildMessageTile('Omkar', 'Are you coming to the party?', '9:15 AM'),
                  _buildMessageTile('Yash', 'Let\'s catch up later.', '8:45 AM'),
                  _buildMessageTile('Vraj', 'Did you finish the project?', '7:30 AM'),
                  _buildMessageTile('JK Gaming', 'Check out my new video!', '6:00 AM'),
                ],
              ),
            ),
          ),
        ],
      )
       
    );
  }


Widget _buildMessageTile(String name, String message ,String time) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          'https://cdn-icons-png.flaticon.com/512/3177/3177440.png'// Replace with your image URL
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
       style: TextStyle(color: Colors.grey),),
      trailing: Text(
        time,
       style: TextStyle(color: Colors.grey),
       overflow: TextOverflow.ellipsis,
       ),

    );
  }
Widget _buildRecentContact(String name,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/3177/3177440.png'// Replace with your image URL
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

        ],
      ),

  
    );
  }
}