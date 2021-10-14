import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NumberKeyboard extends StatelessWidget {
  static const CKTextInputType inputType =
      const CKTextInputType(name: 'CKNumberKeyboard');
  static double getHeight(BuildContext ctx) {
    return 356;
  }

  final KeyboardController controller;
  const NumberKeyboard({this.controller});

  static register() {
    CoolKeyboard.addKeyboard(
        NumberKeyboard.inputType,
        KeyboardConfig(
            builder: (context, controller, params) {
              return NumberKeyboard(controller: controller);
            },
            getHeight: NumberKeyboard.getHeight));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text('1'),
        ),
        onTap: () {
          controller.addText('1');
        },
      ),
    );
  }
}
