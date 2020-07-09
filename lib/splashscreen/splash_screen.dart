import 'package:flutter/material.dart';

import './../const/_const.dart' as CONSTANTS;
import './../presentation/_presentation.dart' as PRESENTATION;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(18),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  CONSTANTS.APP_LOGO,
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                    text: CONSTANTS.SPLASH_LEFT_TEXT,
                    style: PRESENTATION.SPLASH_TEXT_LEFT_STYLE,
                    children: [
                      TextSpan(
                        text: CONSTANTS.SPLASH_CENTER_TEXT,
                        style: PRESENTATION.SPLASH_TEXT_RIGHT_STYLE,
                        children: [
                          TextSpan(
                            text: CONSTANTS.SPLASH_RIGHT_TEXT,
                            style: PRESENTATION.SPLASH_TEXT_LEFT_STYLE,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
