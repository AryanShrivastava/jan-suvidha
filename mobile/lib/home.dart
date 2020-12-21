import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
// import 'package:jansuvidha/tabscreen1.dart';
import 'Mlverify.dart';
// import 'accidentverify.dart';
// import 'animalverify.dart';
import 'drawer.dart';
import 'login_page.dart';

class TabPage1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TabScreen1();
}

class _TabScreen1 extends State<TabPage1> {
  // getLocationData() async {
  //   Location _location = Location();
  //   var _locationData = await _location.getLocation();

  //   print(_locationData);

  //   return _locationData;
  // }

  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    print(_locationData);
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.restaurant)),
                Tab(icon: Icon(Icons.laptop_chromebook)),
              ],
            ),
            backgroundColor: Color(0xff2c7744),
            title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Get',
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Jan',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    TextSpan(
                      text: 'Suvidha',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ]),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.black)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              //Icon(Icons.power_settings_new)
            ],
          ),
          backgroundColor: Colors.white,
          drawer: Drawer_File(),
          body: new TabBarView(
            children: [Ml(), Ml(), Ml()],
          ),
        ),
      ),
    );
  }
}

//  @override
//  int currentPage = 0;
//  Widget imageCarousel = new Container(
//    height: 220.0,
//    child: new Carousel(
//      boxFit: BoxFit.cover,
//      images: [
//        NetworkImage(
//            'https://thumbs.dreamstime.com/z/cartoon-people-fixing-hole-highway-industrial-city-roadwork-banner-repair-equipment-heavy-machinery-working-pothole-169603809.jpg'),
//        NetworkImage(
//            'https://thumbs.dreamstime.com/z/car-highway-falling-asphalt-hole-cartoon-man-looking-shock-automobile-pothole-accident-cityscape-backdrop-flat-193690324.jpg'),
//        NetworkImage(
//            'https://media.istockphoto.com/vectors/gift-card-with-blue-bow-vector-id1179439557?k=6&m=1179439557&s=612x612&w=0&h=Gj7OWfomEmRDIZZ_DbA15QImyDaW7-G0DW0AA89G6HY='),
//      ],
//      showIndicator: false,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
//    ),
//  );
//
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(primarySwatch: Colors.green),
//      home: Scaffold(
//        appBar: AppBar(
//          backgroundColor: Color(0xFFB2FF59),
//          title: RichText(
//            textAlign: TextAlign.center,
//            text: TextSpan(
//                text: 'JAN',
//                style: GoogleFonts.portLligatSans(
//                  textStyle: Theme.of(context).textTheme.display1,
//                  fontSize: 30,
//                  fontWeight: FontWeight.w700,
//                  color: Colors.black,
//                ),
//                children: [
//                  TextSpan(
//                    text: 'SUVIDHA',
//                    style: TextStyle(color: Colors.white, fontSize: 30),
//                  ),
//                ]),
//          ),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text('Logout',
//                  style: new TextStyle(fontSize: 17.0, color: Colors.black)),
//              onPressed: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => LoginPage()));
//              },
//            ),
//            //Icon(Icons.power_settings_new)
//          ],
//        ),
//        backgroundColor: Colors.white,
//        drawer: Drawer_File(),
//        body: new ListView(
//            padding:
//                EdgeInsets.only(left: 2.0, top: 10.0, right: 2.0, bottom: 10.0),
//            children: <Widget>[
//              imageCarousel,
//              SizedBox(height: 10),
//              RaisedButton(
//                  onPressed: () {
//                    Navigator.push(
//                        context, MaterialPageRoute(builder: (context) => Ml()));
//                  },
//                  child: Text(
//                    "ML model",
//                    style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 20.0,
//                      background: Paint()..color = Colors.white,
//                    ),
//                  )),
//              SizedBox(height: 20),
//            ]),
//      ),
//    );
//  }
//}
