import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(AnimationPage());

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animCtrl;

  Animation<double> textSizeAnimation;

  Animation<double> marginAnimation;

  @override
  void initState() {
    super.initState();

    animCtrl = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    //now setup a curve
    final curvedAnimation = CurvedAnimation(
      parent: animCtrl,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    //setup tween- range of values
    // use tween to animate animCtrl
    //animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(animCtrl);

    // use tween to animate curves -
    animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation);

    textSizeAnimation =
        Tween<double>(begin: 16, end: 64).animate(curvedAnimation);

    marginAnimation =
        Tween<double>(begin: 0, end: 100).animate(curvedAnimation);

    //setstate is the listener..when animation values change --rebuild
    animCtrl.addListener(() {
      setState(() {});
    });

    //we also want to listen to when the animation status changes
    // status cane be - dismissed, forward, completed, reversed
    animCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animCtrl.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animCtrl.forward();
      }
    });

    //start the animation
    animCtrl.forward();
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                child: Image.asset(
                  'images/kitty-resized.png',
                  width: 250,
                  height: 250,
                ),
                margin: EdgeInsets.only(left: marginAnimation.value),
              ),
              Container(
                color: Colors.green,
                width: 250,
                height: 250,
              )
            ],
          ),
        ),
      ),
    );
  }
}
