import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../loginPage.dart';



class fbUserDetails extends StatefulWidget {

  String name;
  String photoUrl;
  String first_name;
  String last_name;
  String email;
  String id;

  fbUserDetails({Key key,this.name,this.photoUrl,this.first_name,this.last_name,this.email,this.id}):super(key:key);

  @override
  _fbUserDetailsState createState() => _fbUserDetailsState();
}

class _fbUserDetailsState extends State<fbUserDetails> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseUser _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(backgroundColor:Colors.blue,maxRadius:50.0 ,child: Image.network(widget.photoUrl)),
              Text(widget.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
              Text(widget.first_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
              Text(widget.last_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
              Text(widget.email,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
              Text(widget.id,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0)),
              FlatButton(
                onPressed: (){
                  _signOut();
                },
                padding: EdgeInsets.all(12.0),
                hoverColor: Colors.black26,
                color: Colors.redAccent,
                child: Text("Log Out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void>_signOut() async{
    await _facebookLogin.logOut();
    await _auth.signOut();
    _user=null;
    Navigator.push(context, MaterialPageRoute(builder: (_)=>loginPage()),);

  }
}
//child: Image.network(widget.photoUrl)),