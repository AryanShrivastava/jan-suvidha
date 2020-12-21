import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:jansuvidha/model/login.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/uploadimages.dart';

var url = "https://jan-suvidha.herokuapp.com";

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    Login login = await mobileAuth(authResult.user.email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', login.token);

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

Future<Login> mobileAuth(String email) async {
  try {
    final response =
        await Dio().post(url + '/api/v1/users/login', data: {"email": email});
    print(response);

    return Login.fromJson(response.data);
  } on DioError catch (e) {
    throw e;
  }
}

Future<UploadImage> sendImg(
  File image,
  String department,
  String description,
) async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  _locationData = await location.getLocation();

  print(_locationData);
  String fileName = image.path.split('/').last;
  FormData formData = new FormData.fromMap({
    'file': await MultipartFile.fromFile(
      image.path,
      filename: fileName,
    ),
    'long': _locationData.longitude,
    'lat': _locationData.latitude,
    'department': department,
    'description': description,
    'location_text': "PUT LOCATION HERE"
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var pre = prefs.getString('token');

  try {
    final response = await Dio().post(url + '/api/v1/image/upload',
        data: formData,
        options: Options(headers: {
          'x-auth-token': pre,
        }));
    print(response);

    return UploadImage.fromJson(response.data);
  } on DioError catch (e) {
    print(e.message);
  }
}
