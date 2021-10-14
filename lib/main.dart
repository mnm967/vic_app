import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vic_app/ui/home/placeholder_page.dart';
import 'package:vic_app/ui/home/translation_page.dart';
import 'package:vic_app/widgets/test_keyboard.dart';

void main() {
  NumberKeyboard.register();
  TestKeyboard.register();
  runApp(KeyboardRootWidget(child: MyApp()));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Floating',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Float'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.blue),
    TranslationPage(),
    PlaceholderWidget(Colors.orange),
    PlaceholderWidget(Colors.purple),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var myTheme = SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Color(0xff3168c5),
        statusBarColor: Color(0xff3168c5));

    SystemChrome.setSystemUIOverlayStyle(myTheme);

    return Stack(children: [
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: _children[_currentIndex],
        floatingActionButton: Container(
            height: 68,
            width: 68,
            child: FittedBox(
                child: FloatingActionButton(
              splashColor: Color(0xff3168c5),
              focusColor: Color(0xff3168c5),
              hoverColor: Color(0xff3168c5),
              highlightElevation: 0,
              onPressed: () => _onTabTapped(2),
              child: Container(
                child: Opacity(
                    opacity: _currentIndex == 2 ? 1.0 : 0.5,
                    child: Image(
                      image: AssetImage("assets/images/vic_icon.png"),
                      fit: BoxFit.contain,
                      height: 42,
                      width: 42,
                    )),
              ),
              backgroundColor: Color(0xff3E82F7),
              elevation: 3,
            ))),
        bottomNavigationBar: BottomAppBar(
          elevation: 3.0,
          child: Container(
              color: Color(0xff3E82F7),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.rssSquare),
                          onPressed: () => _onTabTapped(0),
                          color: _currentIndex == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.50),
                          iconSize: 26,
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.graduationCap),
                          onPressed: () => _onTabTapped(1),
                          color: _currentIndex == 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.50),
                          iconSize: 26,
                        ),
                      ),
                      Expanded(child: Text('')),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.people_alt_outlined),
                          onPressed: () => _onTabTapped(3),
                          color: _currentIndex == 3
                              ? Colors.white
                              : Colors.white.withOpacity(0.50),
                          iconSize: 26,
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(CupertinoIcons.person_alt_circle),
                          onPressed: () => _onTabTapped(4),
                          color: _currentIndex == 4
                              ? Colors.white
                              : Colors.white.withOpacity(0.50),
                          iconSize: 26,
                        ),
                      ),
                    ],
                  ))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      Visibility(
          visible: false,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 356,
                alignment: Alignment.bottomCenter,
                color: Color(0xFF7CACFF),
              ))),
    ]);
  }
}
