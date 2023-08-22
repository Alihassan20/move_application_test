import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings)=> null;

class MagicRouter {

  static BuildContext currentContext = navigatorKey.currentContext!;

  static Future<dynamic> navigateTo(Widget page) => navigatorKey.currentState!.push(_materialPageRoute(MediaQuery(
      data: MediaQuery.of(currentContext).copyWith(textScaleFactor: 1, ), //set desired text scale factor here
      child: page)));

  static Future<dynamic> navigateAndPopAll(Widget page) => navigatorKey.currentState!.pushAndRemoveUntil(_materialPageRoute(MediaQuery(
      data: MediaQuery.of(currentContext).copyWith(textScaleFactor: 1, ), //set desired text scale factor here
      child: page)),(_)=> false,);

  static Future<dynamic> navigateAndPopUntilFirstPage(Widget page) => navigatorKey.currentState!.pushAndRemoveUntil(_materialPageRoute(MediaQuery(
      data: MediaQuery.of(currentContext).copyWith(textScaleFactor: 1, ), //set desired text scale factor here
      child: page)),(route) => route.isFirst);

  static Future<dynamic> navigateAndReplacement(Widget page) => navigatorKey.currentState!.pushReplacement(_materialPageRoute(MediaQuery(
      data: MediaQuery.of(currentContext).copyWith(textScaleFactor: 1, ), //set desired text scale factor here
      child: page)));

  static void pop([Object? result]) => navigatorKey.currentState!.pop(result);

  static Route<dynamic> _materialPageRoute(Widget page)=> MaterialPageRoute(builder: (_) => MediaQuery(
      data: MediaQuery.of(currentContext).copyWith(textScaleFactor: 1, ), //set desired text scale factor here
      child: page));

}