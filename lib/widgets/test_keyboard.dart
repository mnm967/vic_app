import 'dart:async';

import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestKeyboard extends StatefulWidget {
  static const CKTextInputType inputType =
      const CKTextInputType(name: 'CKTestKeyboard');

  static register() {
    CoolKeyboard.addKeyboard(
        TestKeyboard.inputType,
        KeyboardConfig(
            builder: (context, controller, params) {
              return TestKeyboard(controller: controller);
            },
            getHeight: _TestKeyboardState.getHeight));
  }

  final KeyboardController controller;

  TestKeyboard({Key key, this.controller}) : super(key: key);

  @override
  _TestKeyboardState createState() =>
      _TestKeyboardState(controller: controller);
}

class _TestKeyboardState extends State<TestKeyboard> {
  bool isCapital = false;
  bool isNumbersActive = false;

  static double getHeight(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return mediaQuery.size.width / 3 / 2 * 5.4;
  }

  final KeyboardController controller;
  _TestKeyboardState({this.controller});

  Timer backspaceTimer;
  
  void startBackspace(){
    backspaceTimer = Timer.periodic(Duration(milliseconds: 50), (Timer t) => {
      controller.deleteOne()
    });
  }
  void stopBackspace(){
    if(backspaceTimer != null){
      backspaceTimer.cancel();
      backspaceTimer = null;
    }
  }

  @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Material(
      child: DefaultTextStyle(
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 23.0),
          child: Container(
              height: getHeight(context),
              width: mediaQuery.size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 7), // changes position of shadow
                  ),
                ],
                color: Color(0xff3E82F7),
              ),
              child: Column(children: [
                Container(
                  height: 48,
                  color: Color(0xff3E82F7),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            padding: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                "Letters",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            padding: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                "Words",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.45),
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Visibility(
                        visible: !isNumbersActive,
                        child: Container(
                            color: Color(0xff3E82F7), child: lettersGrid())),
                    Visibility(
                        visible: isNumbersActive,
                        child: Container(
                            color: Color(0xff3E82F7), child: numbersGrid())),
                  ],
                )),
                Container(
                  height: 64,
                  padding: EdgeInsets.all(8),
                  color: Color(0xff3E82F7),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.25)),
                        height: double.infinity,
                        width: 48,
                        child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                isNumbersActive = !isNumbersActive;
                              });
                            },
                            child: Center(
                                child: Text(isNumbersActive ? "ABC" : "123",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    )))),
                      ),
                      Visibility(visible: !isNumbersActive, child : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.25)),
                        height: double.infinity,
                        width: 48,
                        child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                isCapital = !isCapital;
                              });
                            },
                            child: Center(
                                child: Icon(
                              isCapital
                                  ? FontAwesomeIcons.solidArrowAltCircleUp
                                  : FontAwesomeIcons.arrowAltCircleUp,
                              size: 24,
                              color: Colors.white,
                            )))),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: isNumbersActive ? 0:8, right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white.withOpacity(0.25)),
                          height: double.infinity,
                          child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.addText(" ");
                              },
                              child: Center(
                                  child: Text("space",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      )))),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.25)),
                        height: double.infinity,
                        width: 48,
                        child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              controller.deleteOne();
                            },
                            onLongPressStart:  (details) => startBackspace(),
                            onLongPressEnd: (details) => stopBackspace(),
                            child: Center(
                                child: Icon(
                              FontAwesomeIcons.arrowCircleLeft,
                              size: 24,
                              color: Colors.white,
                            ))),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.25)),
                        height: double.infinity,
                        width: 48,
                        child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              controller.doneAction();
                            },
                            child: Center(
                                child: Text("GO",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    )))),
                      ),
                    ],
                  ),
                )
              ]))),
    );
  }

  final double runSpacing = 0.5;
  final double spacing = 0.5;
  final columns = 10;

  Widget lettersGrid() {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;
    return SingleChildScrollView(
        child: Wrap(
            runSpacing: runSpacing,
            spacing: spacing,
            alignment: WrapAlignment.center,
            children: <Widget>[
          buildButton('Q', w),
          buildButton('W', w),
          buildButton('E', w),
          buildButton('R', w),
          buildButton('T', w),
          buildButton('Y', w),
          buildButton('U', w),
          buildButton('I', w),
          buildButton('O', w),
          buildButton('P', w),
          Padding(
            padding: EdgeInsets.zero,
          ),
          buildButton('A', w),
          buildButton('S', w),
          buildButton('D', w),
          buildButton('F', w),
          buildButton('G', w),
          buildButton('H', w),
          buildButton('J', w),
          buildButton('K', w),
          buildButton('L', w),
          buildButton('Z', w),
          buildButton('X', w),
          buildButton('C', w),
          buildButton('V', w),
          buildButton('B', w),
          buildButton('N', w),
          buildButton('M', w),
        ]));
  }

  Widget numbersGrid() {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;
    return SingleChildScrollView(
        child: Wrap(
            runSpacing: runSpacing,
            spacing: spacing,
            alignment: WrapAlignment.center,
            children: <Widget>[
          buildButton('1', w),
          buildButton('2', w),
          buildButton('3', w),
          buildButton('4', w),
          buildButton('5', w),
          buildButton('6', w),
          buildButton('7', w),
          buildButton('8', w),
          buildButton('9', w),
          buildButton('0', w),
          buildButton('-', w),
          buildTextButton('/', w),
          buildTextButton(':', w),
          buildTextButton(';', w),
          buildTextButton('(', w),
          buildTextButton(')', w),
          buildTextButton('+', w),
          buildTextButton('&', w),
          buildTextButton('@', w),
          buildTextButton('"', w),
          buildTextButton('.', w),
          buildTextButton(',', w),
          buildTextButton('?', w),
          buildTextButton('!', w),
          buildTextButton('\'', w),
        ]));
  }

  // Widget lettersGrid() {
  //   return GridView.count(
  //       childAspectRatio: 0.5 / 1,
  //       mainAxisSpacing: 0.5,
  //       crossAxisSpacing: 0.5,
  //       padding: EdgeInsets.all(0.0),
  //       crossAxisCount: 10,
  //       children: <Widget>[
  //         buildButton('Q'),
  //         buildButton('W'),
  //         buildButton('E'),
  //         buildButton('R'),
  //         buildButton('T'),
  //         buildButton('Y'),
  //         buildButton('U'),
  //         buildButton('I'),
  //         buildButton('O'),
  //         buildButton('P'),
  //         buildButton(''),
  //         buildButton('A'),
  //         buildButton('S'),
  //         buildButton('D'),
  //         buildButton('F'),
  //         buildButton('G'),
  //         buildButton('H'),
  //         buildButton('J'),
  //         buildButton('K'),
  //         buildButton('L'),
  //         buildButton(''),
  //         buildButton('Z'),
  //         buildButton('X'),
  //         buildButton('C'),
  //         buildButton('V'),
  //         buildButton('B'),
  //         buildButton('N'),
  //         buildButton('M'),
  //       ]);
  // }

  // Widget lettersGrid() {
  //   return GridView.count(
  //       childAspectRatio: 0.5 / 1,
  //       mainAxisSpacing: 0.5,
  //       crossAxisSpacing: 0.5,
  //       padding: EdgeInsets.all(0.0),
  //       crossAxisCount: 10,
  //       children: <Widget>[
  //         buildButton('A'),
  //         buildButton('B'),
  //         buildButton('C'),
  //         buildButton('D'),
  //         buildButton('E'),
  //         buildButton('F'),
  //         buildButton('G'),
  //         buildButton('H'),
  //         buildButton('I'),
  //         buildButton('J'),
  //         buildButton('K'),
  //         buildButton('L'),
  //         buildButton('M'),
  //         buildButton('N'),
  //         buildButton('O'),
  //         buildButton('P'),
  //         buildButton('Q'),
  //         buildButton('R'),
  //         buildButton('S'),
  //         buildButton('T'),
  //         buildButton('U'),
  //         buildButton('V'),
  //         buildButton('W'),
  //         buildButton('X'),
  //         buildButton('Y'),
  //         buildButton('Z'),
  //         buildButton('0'),
  //         buildButton('1'),
  //         buildButton('2'),
  //         buildButton('3'),
  //         buildButton('4'),
  //         buildButton('5'),
  //         buildButton('6'),
  //         buildButton('7'),
  //         buildButton('8'),
  //         buildButton('9'),
  //         buildTextButton(','),
  //         buildTextButton('.'),
  //         buildTextButton('?'),
  //         buildTextButton('!'),
  //       ]);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   MediaQueryData mediaQuery = MediaQuery.of(context);
  //   return Material(
  //     child: DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 23.0), child: Container(
  //       height:getHeight(context),
  //       width: mediaQuery.size.width,
  //       decoration: BoxDecoration(
  //         color: Color(0xffafafaf),
  //       ),
  //       child: GridView.count(
  //           childAspectRatio: 1/1,
  //           mainAxisSpacing:0.5,
  //           crossAxisSpacing:0.5,
  //           padding: EdgeInsets.all(0.0),
  //           crossAxisCount: 6,
  //           children: <Widget>[
  //             buildButton('A'),
  //             buildButton('B'),
  //             buildButton('C'),
  //             buildButton('D'),
  //             buildButton('E'),
  //             buildButton('F'),
  //             buildButton('G'),
  //             buildButton('H'),
  //             buildButton('I'),
  //             buildButton('J'),
  //             buildButton('K'),
  //             buildButton('L'),
  //             buildButton('M'),
  //             buildButton('N'),
  //             buildButton('O'),
  //             buildButton('P'),
  //             buildButton('Q'),
  //             buildButton('R'),
  //             buildButton('S'),
  //             buildButton('T'),
  //             buildButton('U'),
  //             buildButton('V'),
  //             buildButton('W'),
  //             buildButton('X'),
  //             buildButton('Y'),
  //             buildButton('Z'),
  //             Container(
  //               color: Color(0xFFd3d6dd),
  //               child: GestureDetector(
  //                 behavior: HitTestBehavior.translucent,
  //                 child: Center(child: Icon(Icons.expand_more),),
  //                 onTap: (){
  //                   controller.doneAction();
  //                 },
  //               ),
  //             ),
  //             buildButton('0'),
  //             Container(
  //               color: Color(0xFFd3d6dd),
  //               child: GestureDetector(
  //                 behavior: HitTestBehavior.translucent,
  //                 child: Center(child: Text('X'),),
  //   onTap: (){
  //     controller.deleteOne();
  //   },
  // ),
  //             ),
  //           ]),
  //     )),
  //   );
  // }

  Widget buildButton(String title, double w, {String value}) {
    if (value == null) {
      value = isCapital ? title.toUpperCase() : title.toLowerCase();
    }
    return Container(
      width: w,
      height: w / 0.5,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Material(color: Colors.transparent, child : InkWell(child : Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontSize: 50, fontFamily: "Gallaudet"),
            ),
            Text(
              isCapital ? title.toUpperCase() : title.toLowerCase(),
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        )),
        onTap: () {
          controller.addText(value);
        },
      ),
    )));
  }

  Widget buildTextButton(String title, double w, {String value}) {
    if (value == null) {
      value = title;
    }
    return Container(
      width: w,
      height: w / 0.5,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        
        child: Material(color: Colors.transparent, child : InkWell(child : Center(
          
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            // Text(
            //   title,
            //   style: TextStyle(color: Colors.white, fontSize: 12),
            // ),
          ],
        )),
        onTap: () {
          controller.addText(value);
        },
      ),
    )));
  }
}
