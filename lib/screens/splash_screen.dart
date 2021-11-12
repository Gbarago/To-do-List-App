import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'home.dart';

//import '/Screens/loggin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    _navigateToLaunch();
  }

  _navigateToLaunch() async {
    await Future.delayed(const Duration(seconds: 9), () {});

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.purple,
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.8,
              child: CircleAvatar(
                backgroundColor: Colors.purple,
                // radius: 10.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/done.png',
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.purple,
                child: Center(
                    child: Container(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'PRIORITISE',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      WavyAnimatedText(
                        'WITH',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      WavyAnimatedText(
                        'CAN DO APP',
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    ],

                    // 'CAN DO APP',
                    // style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 26),
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
