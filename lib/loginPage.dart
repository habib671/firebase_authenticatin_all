import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fbAuthComplete/fbSignInCompletion.dart';
import 'file:///C:/Users/Habib/AndroidStudioProjects/flutter_app/lib/mobileAuthComplete/mobileLogin.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'googleAuthComplete/googleSignInCompletion.dart';


class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {


  String userName;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile'], hostedDomain: "", clientId: "",);
  FirebaseUser UserDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              //padding:  EdgeInsets.fromLTRB(20, 30, 20, 20),
              padding:  EdgeInsets.all(20.0),
              child: TextField(
                //controller: userNameController,
                style: TextStyle(color: Colors.white),
                keyboardType:TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.green[300]),
                  ),
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.grey[300],
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                onChanged: (val) {
                  userName = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
               // controller: passController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.green[300]),
                  ),
                  prefixIcon: Icon(
                    Icons.screen_lock_portrait,
                    color: Colors.grey[300],
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                onChanged: (val) {
                  password = val;
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 0.0),
              child: Text(
                'Forger password?',
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) =>login_page()),);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'LOGIN WITH MOBILE',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap:() => signInWithEmailPass(userName,password),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Text(
                  'OR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () =>_fbSignIn(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    alignment: Alignment.center,
                    //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.facebook,
                              color:Colors.white),
                          SizedBox(width: 15.0,),
                          Text(
                            "Facebook",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>_gsignIn(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    alignment: Alignment.center,
                    //margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.google,
                            color: Colors.red,),
                          SizedBox(width: 15.0,),
                          Text(
                            "Google",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Container(
                child: Text(
                  'Don\'t have an account ?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 30.0),
              child: Container(
                child: Text(
                  'REGISTER',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      )

    );
  }

  // CREATE USER WITH EMAIL & PASS SECTION:
  Future signInWithEmailPass(userName,pass)async{
    try{
      AuthResult result = (await _auth.createUserWithEmailAndPassword(email: userName, password: pass));
      FirebaseUser user =result.user;
      return user;
    }
    catch(error){
      print(error.message);
    }
  }


  // FACEBOOK SIGN IN SECTION:
  _fbSignIn() async{
    try{
      final FacebookLogin facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(['email']);
      final token = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${token}');
      print(graphResponse.body);
      final profile = json.decode(graphResponse.body);
      var photoUrl = profile["picture"]["data"]["url"];
      var first_name = profile["first_name"];
      var last_name = profile["last_name"];
      var name = profile["name"];
      var email = profile["email"];
      var id = profile["id"];
/*      print(photoUrl);
      print(name);
      print(first_name);
      print(last_name);
      print(email);
      print(id);*/
      if(result.status == FacebookLoginStatus.loggedIn) {
        final credential = FacebookAuthProvider.getCredential(
          accessToken: token);
        _auth.signInWithCredential(credential);
        Navigator.push(context, MaterialPageRoute(
            builder: (_) => fbUserDetails(
              name:name,
              first_name:first_name,
              last_name:last_name,
              email:email,
              id:id,
              photoUrl:photoUrl,

                )
        ));
      }
    }

    catch (error){
      print(error.message);
    }
   /* setState(() {
      _fbisSignIn = true;
    });*/
  }

  //GOOGLE SIGN IN SECTION:
  Future<void>_gsignIn() async{
    try{
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserDetails = (await _auth.signInWithCredential(credential)).user;

      Navigator.push(context, MaterialPageRoute(
          builder: (_) => googleSignInUser(
              userName:UserDetails.displayName,
              email:UserDetails.email,
              pic:UserDetails.photoUrl)
      ));
    }
    catch (error){
      print(error.message);
    }

  }
}