import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Mlverify.dart';
import 'drawer.dart';
import 'login_page.dart';
//import 'home.dart';



class menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFB2FF59),
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'JAN',
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'SUVIDHA',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ]),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.black)),
              onPressed: (){ Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));},
            ),
            //Icon(Icons.power_settings_new)
          ],
        ),
        backgroundColor: Colors.white,
        drawer: Drawer_File(),
        body: Ml(),
        // TabPage2(),
      ),
    );
  }
}