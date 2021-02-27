import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation, delayedAnimation, muchDelayAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: -1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    delayedAnimation = Tween<double>(begin: -1, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
    muchDelayAnimation =
        Tween<double>(begin: -1, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Transform(
            transform:
                Matrix4.translationValues(animation.value * width, 0.0, 0.0),
            child: child,
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Center(
                    child: FlutterLogo(
                      size: 80,
                    ),
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.translationValues(
                      delayedAnimation.value * width, 0.0, 0.0),
                  child: child,
                );
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                width: width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "User Name",
                            labelText: "User Name",
                            contentPadding: EdgeInsets.all(5.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            contentPadding: EdgeInsets.all(5.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.translationValues(
                              muchDelayAnimation.value * width, 0.0, 0.0),
                          child: child,
                        );
                      },
                      child: RaisedButton(
                        color: Colors.amber,
                        onPressed: () => print("Bas"),
                        child: Text("Sign In"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
