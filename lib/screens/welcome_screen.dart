import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/round_button.dart';



class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //a variable of type AnimationController
  //creating a custom flutter animation with animation controller
  AnimationController controller;
  Animation animation;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //the vsync expect a ticker, the ticker is the object of the class
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    //building an animation to trasition betweeen colors and apply it to the controller
    animation = ColorTween(begin: Colors.green, end: Colors.amberAccent).animate(controller);
    //to get the animation to start working
    controller.forward();
    //to see the work of the controller,
    controller.addListener(() {
      setState(() {
      });
    });
  }
@override
  void dispose() {
    // TODO: implement dispose
  //dispose the controller once this screen is destroyed
  controller.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                      textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                    )
                  ]
                 ,

                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
           RoundedButton(
             buttonColor: Colors.lightBlueAccent,
             buttonTitle: 'Log In',
             buttonOnpressed: (){Navigator.pushNamed(context, LoginScreen.id);},
           ),
            RoundedButton(
              buttonColor: Colors.blueAccent,
              buttonTitle: 'Registration',
              buttonOnpressed: (){Navigator.pushNamed(context, RegistrationScreen.id);},
            ),
          ],
        ),
      ),
    );
  }
}
