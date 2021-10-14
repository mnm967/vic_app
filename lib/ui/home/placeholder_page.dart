import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlaceholderWidget extends StatelessWidget {
 final Color color;

 PlaceholderWidget(this.color);

 @override
 Widget build(BuildContext context) {
   return Container(
     height: double.infinity,
     width: double.infinity,
     child: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(FontAwesomeIcons.hammer,
           size: 96,
           color: Color(0xff3168c5).withOpacity(0.75),),
           Padding(padding: EdgeInsets.only(top: 48),),
           Text("Work in Progress...", style: TextStyle(
             color: Color(0xff3168c5).withOpacity(0.75),
             fontWeight: FontWeight.w300,
             fontSize: 36
           ),)
         ],
        ),
      ),
   );
 }
}