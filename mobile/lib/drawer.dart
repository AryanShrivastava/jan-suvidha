import 'package:flutter/material.dart';

class Drawer_File extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: logo(),
              decoration: BoxDecoration(),
            ),




            ListTile(
              title: Text(
                'About Us',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18.0,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              onTap: () {
              },
            ),

          ],
        ),
      ),
    );
  }
}
class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/hi.png');
    Image image = Image(image: assetImage, width: 300, height: 300.0);
    return Scaffold(
      body: Container(
        child: image,
      ),
    );
  }
}
