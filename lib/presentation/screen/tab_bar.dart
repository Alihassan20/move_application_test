
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_application/presentation/screen/search/view.dart';

import '../../buisness_logic_cubit/movie_cubit.dart';
import '../../constant/theme_color.dart';
import '../../data/repositry/popular_movie_repo.dart';
import '../../data/web_services/popular_movie_web_services.dart';
import '../../main.dart';
import 'dart:io' show Platform;

import 'homePage/view.dart';

class AppTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppTabBarState();
  }
}

class _AppTabBarState extends State<AppTabBar> with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 1; //default index of a first screen

  final List<Widget> _children = [

    // const SearchPage(),
    // const LikePage()

    BlocProvider(
        create: (context) => MovieCubit( PopularMovieRepository(PopularMoviesWebServices())),
        child: const SearchPage()),
    BlocProvider(
        create: (context) => MovieCubit( PopularMovieRepository(PopularMoviesWebServices())),
        child: const PopularMovieScreen()),
    Container(color: AppColor.red)
  ];


  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Platform.isAndroid ? SystemUiOverlayStyle.light: SystemUiOverlayStyle.dark ,
      child: SafeArea(
        top: Platform.isAndroid,
        bottom: Platform.isAndroid,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBody: true,
            body: Stack(
              children: [
                Container(

                    color: AppColor.white,
                    child: _children[_bottomNavIndex]
                ),

              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: AppColor.black,
              index: _bottomNavIndex,
              items: const <Widget>[
                Icon(Icons.search, size: 30,color: AppColor.white),
                Icon(Icons.home, size: 30,color: AppColor.white,),
                Icon(CupertinoIcons.heart, size: 30,color: AppColor.white),
              ],
              onTap: (index) {
                //Handle button tap
                setState(() {
                  _bottomNavIndex = index;
                });
              },
            )
        ),
      ),
    );
  }

}