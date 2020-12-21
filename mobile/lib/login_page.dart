import 'package:flutter/material.dart';

// import 'FirstScreen.dart';
import 'sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("images/gsignin.jpg");
    Image image = Image(image: assetImage, width: 380, height: 1000.0);
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: image,
        ),
        /*SizedBox(height: 60),*/
        Container(
          child: _signInButton(),
        ),
      ]),
//      Container(
//        color: Colors.white,
//        child: Center(
//          child: Column(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//
//              SizedBox(height: 50),
//              _signInButton(),
//            ],
//          ),
//        ),
//      ),
    );
  }

  Widget _signInButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 450.0, left: 60),
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          signInWithGoogle().then((result) {
            if (result != null) {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return FirstScreen();
              //     },
              //   ),
              // );
            }
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("images/google_logo.png"), height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
