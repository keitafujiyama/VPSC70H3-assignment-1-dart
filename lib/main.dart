// PACKAGE
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page/home_page.dart';
import 'splash_page.dart';



// MAIN
void main () {
  setUrlStrategy (PathUrlStrategy ());

  runApp (const MyApp ());
}

class MyApp extends StatelessWidget {

  // CONSTRUCTOR
  const MyApp ({super.key});



  // MAIN
  @override
  Widget build (BuildContext context) {
    rootBundle.loadString ('asset/openFontLicense.txt').then ((String txt) => LicenseRegistry.addLicense (() => Stream <LicenseEntry>.fromIterable (<LicenseEntry> [LicenseEntryWithLineBreaks (<String> ['google_fonts'], txt)])));
    return WillPopScope (
      onWillPop: () async => false,
      child: MaterialApp (
        initialRoute: '/',
        title: 'live',
        onGenerateRoute: (RouteSettings setting) {
          switch (setting.name) {
            case '/home':
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => const HomePage ());

            case '/splash':
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => const SplashPage2 ());

            default:
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => const SplashPage1 ());
          }
        },
        theme: ThemeData (
          brightness: Brightness.light,
          fontFamily: GoogleFonts.domine ().fontFamily,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme (
            actionsIconTheme: const IconThemeData (color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: double.minPositive,
            iconTheme: const IconThemeData (color: Colors.black),
            titleTextStyle: TextStyle (
              color: Colors.black,
              fontFamily: GoogleFonts.domine ().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
