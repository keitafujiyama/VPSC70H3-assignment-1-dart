// PACKAGE
import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../global_file/global_method.dart';
import 'home_class.dart';



// HOME PAGE
class HomePage extends StatefulWidget {

  // CONSTRUCTOR
  const HomePage ({super.key});



  // MAIN
  @override
  State <HomePage> createState () => _HomePageState ();
}
class _HomePageState extends State <HomePage> {

  // METHOD
  double _addPosition () => Random ().nextDouble ();

  int _changeColor (int number) {
    var color = number + Random ().nextInt (5) - 2;

    if (color < 0) {
      color = 0;
    }

    if (color > 255) {
      color = 255;
    }

    return color;
  }

  void _addMinute () {
    final color = Color.fromRGBO (Random ().nextInt (256), Random ().nextInt (256), Random ().nextInt (256), 1);
    final minute = DateTime.now ().minute;
    setState (() => _minutes.add (MinuteClass ([LineClass (color, _addPosition ())], minute)));

    if (_minutes.length > 5) {
      setState (() => _minutes.removeAt (0));
    }

    debugPrint ('HOME: $minute (${color.toString ()})');
  }

  // PROPERTY
  final List <MinuteClass> _minutes = [];



  // MAIN
  @override
  void initState () {
    super.initState ();

    Timer.periodic (const Duration (milliseconds: 100), (_) {
      if (_minutes.isNotEmpty) {
        if (DateTime.now ().minute == _minutes.last.minute) {
          setState (() => _minutes.last.lines.add (LineClass (Color.fromRGBO (_changeColor (_minutes.last.lines.last.color.red), _changeColor (_minutes.last.lines.last.color.green), _changeColor (_minutes.last.lines.last.color.blue), 1), _addPosition ())));
        } else {
          _addMinute ();
        }
      } else {
        _addMinute ();
      }
    });
  }

  @override
  Widget build (BuildContext context) {
    final size = MediaQuery.of (context).size;
    return Scaffold (
      extendBodyBehindAppBar: true,
      appBar: AppBar (
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [Padding (
          padding: EdgeInsets.only (right: size.shortestSide * 0.05),
          child: GestureDetector (
            onTap: () => showDialog <void> (
              context: context,
              builder: (_) => AlertDialog (
                backgroundColor: Colors.grey.shade50,
                contentPadding: EdgeInsets.all (size.shortestSide * 0.05),
                shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular (5)),
                content: Column (
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text ('live',
                      textScaleFactor: 1,
                      style: TextStyle (
                        color: Theme.of (_).textTheme.bodyText1!.color,
                        fontSize: gSetSize (context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const ListTile (dense: true),
                    Text ('This application ticks the time using strings.',
                      textScaleFactor: 0.75,
                      style: TextStyle (
                        color: Theme.of (_).textTheme.bodyText1!.color,
                        fontSize: gSetSize (context),
                      ),
                    ),
                    const ListTile (dense: true),
                    Text.rich (TextSpan (children: [
                      TextSpan (text: '©KEITA FUJIYAMA ${DateTime.now ().year} | '),
                      TextSpan (
                        text: 'LICENSE',
                        recognizer: TapGestureRecognizer ()..onTap = () => showLicensePage (
                          applicationName: 'Assignment 1',
                          applicationLegalese: 'Keita Fujiyama',
                          context: context,
                        ),
                      ),
                      const TextSpan (text: ' | '),
                      TextSpan (
                        recognizer: TapGestureRecognizer ()..onTap = () => launchUrlString ('https://github.com/keitafujiyama/VPSC70H3-assignment-1/'),
                        text: 'REPOSITORY',
                      ),
                    ],),
                      textScaleFactor: 0.75,
                      style: TextStyle (
                        color: Colors.grey,
                        fontSize: gSetSize (context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: Icon (Icons.info_outline, size: gSetSize (context)),
          ),
        )],
      ),
      body: Stack (
        alignment: Alignment.center,
        children: [for (var i = 0; i < _minutes.length; i ++) Stack (children: [
          Container (
            alignment: Alignment.center,
            height: double.maxFinite,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric (
              horizontal: size.width * 0.05,
              vertical: size.height * 0.05,
            ),
            child: SizedBox (
              height: size.height * 0.5,
              width: size.width * 0.5,
              child: FittedBox (child: Text (_minutes [i].minute.toString (), style: TextStyle (
                color: Theme.of (context).primaryColor,
                fontWeight: FontWeight.bold,
              ),),),
            ),
          ),
          for (final line in _minutes [i].lines) Builder (builder: (_) {
            final weight = i > _minutes.length - 4 ? Random ().nextDouble () * 0.01 : 0.01;

            final height = size.height * weight;
            final width = size.width * weight;
            return Positioned (
              left: _minutes [i].minute.isOdd ? (line.position * size.width * 0.9) + (size.width * 0.05 - width * 0.5) : size.width * 0.05,
              top: _minutes [i].minute.isOdd ? size.height * 0.05 : (line.position * size.height * 0.9) + (size.height * 0.05 - height * 0.5),
              child: Container (
                color: line.color,
                height: _minutes [i].minute.isOdd ? size.height * 0.9 : height,
                width: _minutes [i].minute.isOdd ? width : size.width * 0.9,
              ),
            );
          },),
        ],)],
      ),
    );
  }
}
