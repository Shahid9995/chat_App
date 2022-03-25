import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {

  static const String id='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messege=TextEditingController();
  // late String message;
  final _firestore=FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  var  loginuser;
  void GetCurrentUser()async{
    var  user =await _auth.currentUser;
    if(user!=null){
      loginuser=user;
      print(loginuser.email);
      // print(loginuser.password);
    }
  }@override
  void initState() {
    // TODO: implement initState
    GetCurrentUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                print("Current User is going to logout ");
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller:messege,
                      onChanged: (value) {
                        // message=value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection('messeges').add(
                          {
                            'text': messege.text,
                            'sender': loginuser.email,
                          }
                      );
                      //Implement send functionality.
                    },
                    child: const Text(
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
