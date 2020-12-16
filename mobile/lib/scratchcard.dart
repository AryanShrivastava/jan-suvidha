import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:jansuvidha/Mlverify.dart';
import 'package:scratcher/widgets.dart';


Random random = new Random();
int randomNumber = random.nextInt(100);

class ScratchCard extends StatefulWidget {
  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Scratcher(
              brushSize: 50,
              threshold: 75,
              color: Colors.red,
              image: Image.asset(
                "images/outerimage.png",
                fit: BoxFit.fill,
              ),
              onChange: (value) => print("Scratch progress: $value%"),
              onThreshold: () => _controller.play(),
              child: Container(
                height: 300,
                width: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/newimage.png",
                      fit: BoxFit.contain,
                      width: 150,
                      height: 150,
                    ),
                    Column(
                      children: [
                        ConfettiWidget(
                          blastDirectionality: BlastDirectionality.explosive,
                          confettiController: _controller,
                          particleDrag: 0.05,
                          emissionFrequency: 0.05,
                          numberOfParticles: 100,
                          gravity: 0.05,
                          shouldLoop: false,
                          colors: [
                            Colors.green,
                            Colors.red,
                            Colors.yellow,
                            Colors.blue,
                          ],
                        ),
                        Text(
                          "You won",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "Rs.$randomNumber",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Ml()));
              },
              child: Text(
                "Back To Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  background: Paint()..color = Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
