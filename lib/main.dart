import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Network/Remote/DioHelper.dart';
import 'modules/Auth/Login/LoginScreen.dart';
import 'modules/OnBoardingScreen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primaryColor: HexColor('#6C5CE7'),
          appBarTheme: AppBarTheme(
              toolbarHeight: 60,
              backgroundColor: HexColor('#6C5CE7'),
              actionsIconTheme: IconThemeData(color: Colors.white,size: 30),
              elevation: 0
          ),
          iconTheme: IconThemeData(
              color:  HexColor('#6C5CE7')
          )
      ),
      home: OnBoarding(),
    );
  }
}

