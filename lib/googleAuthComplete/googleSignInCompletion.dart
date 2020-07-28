import 'package:flutter/material.dart';
import 'package:flutter_app/loginPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class googleSignInUser extends StatefulWidget {



  final String userName;
  final String email;
  final String pic;
  const googleSignInUser({Key key,this.userName,this.email,this.pic}):super(key:key);

  @override
  _googleSignInUserState createState() => _googleSignInUserState();
}

class _googleSignInUserState extends State<googleSignInUser> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile'], hostedDomain: "", clientId: "",);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage(widget.pic),
            ),
            Text(widget.userName,style: TextStyle(
                fontSize: 25.0,color: Colors.black,fontWeight: FontWeight.bold
            ),),
            Text(widget.email,style: TextStyle(
                fontSize: 25.0,color: Colors.black,fontWeight: FontWeight.bold
            ),),
            RaisedButton(
              padding: EdgeInsets.all(15.0),
              color: Colors.green,
              onPressed: () {
                gooleSignout();
              },
              child: Text("Logout",style: TextStyle(
                  fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (_)=>loginPage()),);
    });
  }
}
