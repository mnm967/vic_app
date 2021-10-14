import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vic_app/widgets/test_keyboard.dart';

class TranslationPage extends StatefulWidget {
  TranslationPage({Key key}) : super(key: key);

  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  bool isEnglishSelected = true;
  String currentText = "";

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var myTheme = SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Color(0xff3168c5),
        statusBarColor: Color(0xff3168c5));

    SystemChrome.setSystemUIOverlayStyle(myTheme);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 46),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 72,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.only(left: 4, right: 5),
                            decoration: BoxDecoration(
                                color: isEnglishSelected
                                    ? Color(0xff3E82F7)
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            padding: EdgeInsets.zero,
                            child: FlatButton(
                              onPressed: () => {
                                setState(() {
                                  isEnglishSelected = true;
                                })
                              },
                              child: Text("English",
                                  style: TextStyle(
                                      color: isEnglishSelected
                                          ? Colors.white
                                          : Color(0xff3E82F7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Center(
                              child: Container(
                                  padding: EdgeInsets.all(1),
                                  height: 64.0,
                                  width: 64.0,
                                  child: FittedBox(
                                      child: FloatingActionButton(
                                    onPressed: () => {
                                      setState(() {
                                        isEnglishSelected = !isEnglishSelected;
                                      })
                                    },
                                    backgroundColor: Color(0xff3E82F7),
                                    child: Icon(FontAwesomeIcons.exchangeAlt),
                                    elevation: 4,
                                  ))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.only(left: 4, right: 5),
                            decoration: BoxDecoration(
                                color: !isEnglishSelected
                                    ? Color(0xff3E82F7)
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            padding: EdgeInsets.zero,
                            child: FlatButton(
                              onPressed: () => {
                                setState(() {
                                  isEnglishSelected = false;
                                })
                              },
                              child: Text("SASL",
                                  style: TextStyle(
                                      color: !isEnglishSelected
                                          ? Colors.white
                                          : Color(0xff3E82F7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Expanded(
                    child: Column(
                  children: isEnglishSelected
                      ? <Widget>[
                          englishTextCard(),
                          Padding(padding: EdgeInsets.only(top: 16)),
                          cameraButton(),
                          Padding(padding: EdgeInsets.only(top: 16)),
                          saslTextCard()
                        ]
                      : <Widget>[
                          englishTextCard(),
                          Padding(padding: EdgeInsets.only(top: 16)),
                          cameraButton(),
                          Padding(padding: EdgeInsets.only(top: 16)),
                          saslTextCard()
                        ].reversed.toList(),
                )),
              ],
            ),
          ),
        ));
  }

  Widget cameraButton() => Container(
        child: Center(
          child: Container(
            height: 64.0,
            width: 64.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () => {},
                backgroundColor: Color(0xff3E82F7),
                child: Icon(Icons.camera_alt),
                elevation: 4,
              ),
            ),
          ),
        ),
      );

  Widget saslTextCard() => Expanded(
        flex: 4,
        child: Container(
          child: SizedBox.expand(
            child: Card(
              elevation: 3.5,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: Color(0xff3E82F7),
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("South African Sign Language",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 23,
                            fontWeight: FontWeight.w500)),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                    ),
                    Expanded(
                        child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: TextField(
                                readOnly: isEnglishSelected,
                                cursorColor: Colors.white,
                                controller: textController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Sign Language Here",
                                  hintStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.4)),
                                ),
                                textInputAction: TextInputAction.go,
                                keyboardType: TestKeyboard.inputType,
                                maxLines: null,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontFamily: "Gallaudet",
                                    fontWeight: FontWeight.w400))))
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget englishTextCard() => Expanded(
        flex: 4,
        child: Container(
          child: SizedBox.expand(
            child: Card(
              elevation: 3.5,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: Colors.white,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Column(children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("English",
                            style: TextStyle(
                                color: Color(0xff3E82F7),
                                fontSize: 24,
                                fontWeight: FontWeight.w500)),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        Expanded(
                            child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: TextField(
                                    readOnly: !isEnglishSelected,
                                    controller: textController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: "Type Something Here",
                                      hintStyle: TextStyle(
                                          color: Color(0xff3E82F7)
                                              .withOpacity(0.55)),
                                    ),
                                    textInputAction: TextInputAction.go,
                                    keyboardType: TestKeyboard.inputType,
                                    maxLines: null,
                                    style: TextStyle(
                                        color: Color(0xff3E82F7),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400))))
                      ],
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    height: 64,
                    padding: EdgeInsets.only(top: 8),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image(
                            image: AssetImage("assets/images/vic_logo.png"),
                            height: 36,
                            alignment: Alignment.center,
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                    visible: isEnglishSelected,
                                    child: Container(
                                        height: 64.0,
                                        width: 64.0,
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: FittedBox(
                                            child: FloatingActionButton(
                                          onPressed: () => {},
                                          backgroundColor: Color(0xff3E82F7),
                                          child: Icon(Icons.mic, size: 28),
                                          elevation: 4,
                                        )))),
                                Visibility(
                                    visible: !isEnglishSelected,
                                    child: Container(
                                        height: 64.0,
                                        width: 64.0,
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: FittedBox(
                                            child: FloatingActionButton(
                                          onPressed: () => {},
                                          backgroundColor: Color(0xff3E82F7),
                                          child: Icon(Icons.record_voice_over,
                                              size: 28),
                                          elevation: 4,
                                        )))),
                              ],
                            ))
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
}
