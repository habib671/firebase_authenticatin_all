import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Habib/AndroidStudioProjects/flutter_app/lib/mobileAuthComplete/mobileUser.dart';

class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final _phoneCOntroller = TextEditingController();
  final _codeCOntroller = TextEditingController();

  Future<bool> loginUser(String phone,BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();
         AuthResult result = await _auth.signInWithCredential(credential);
         FirebaseUser user = result.user;
         if(user!=null){
           Navigator.push(context, MaterialPageRoute(
            builder: (_) => mobileUser(user: user,),
           ));
         }
         else{
           print("Error");
         }
         // This callback would gets called when verification is done automaticlally by codeAutoRetrieval
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        //codeSent: manually code send korbe and seta bosabte hbe
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
            builder: (context){
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeCOntroller,
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async{
                        final code = _codeCOntroller.text.trim();
                        AuthCredential credential = PhoneAuthProvider.getCredential(
                            verificationId: verificationId,
                            smsCode: code);
                       AuthResult result = await _auth.signInWithCredential(credential);
                       FirebaseUser user = result.user;
                        if(user!=null){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => mobileUser(user: user,),
                          ));
                        }else{
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Mobile Authentication Login",
                style: TextStyle(
                  fontSize: 25.0, fontWeight: FontWeight.bold,color: Colors.blue,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _phoneCOntroller,
                decoration: InputDecoration(

                ),


              ),
              SizedBox(height: 20.0,),
              Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("LOGIN"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    onPressed: (){
                    final phone = _phoneCOntroller.text.trim();
                    loginUser(phone, context);
                    },
                  )

              )
            ],
          ),
        ),
      ),
    );
  }
}
