import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {
   static const String id = 'chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
 User loggedInUSer;
 String messageText;


 @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()async {
    try{
    final TheUser = await _auth.currentUser;
    if(TheUser != null){
    loggedInUSer = TheUser;

    }
    }catch(e){
      print(e);
    }
  }
 // TODO: for(var message in messages.docs.map((e) => Text(e.toString())).toList()){
  //   print(message);
  //    }


  // void getMessage()async {
  //  //this is to access the documents in the cloud collection which is named messages
  //   final messagesInCloud = await _firestore.collection('messages').get();
  //
  //  }
  // }

  //the method is used to listen to the stream of message from the firebase
  // void messageStream() {
  //   //looping through the snapshot is a list of future objects.
  //   // it listens for changes or updates in my database collection which in this case is messages
  //   for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // getMessage();
                _auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             MessageStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text' : messageText,
                          'sender' :  loggedInUSer.email,
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      //the stream property tells us where the data comes from
        stream: _firestore.collection('messages').snapshots(),
        builder: ( context,  snapshot) {

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyan,
              ),
            );
          }
          //the snapshot is an async snapshot from flutter
          // the data  is a property from firebase
          final messages = snapshot.data?.docs;
          List messageBubbles = [];
          for (var message in messages) {
            print(message);
            final messageText = message['text'];
            final messageSender = message['Sender'];

            final messageBubble = MessageBubble(sender: messageSender, text: messageText);
            print(messageBubble);
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );

        }
    );
  }
}



class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text});
final String text;
final String sender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        color: Colors.blue,
        child: Column(
          children: [
            Text(sender,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(text ,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
