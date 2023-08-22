import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:move_application/constant/new_route.dart';
import 'package:move_application/constant/theme_color.dart';
import 'package:move_application/data/model/popular_model.dart';

import '../../../buisness_logic_cubit/movie_cubit.dart';
import '../../../buisness_logic_cubit/movie_state.dart';
import '../../../data/repositry/popular_movie_repo.dart';
import '../../../data/web_services/popular_movie_web_services.dart';
import '../../widgets/movie_item.dart';
import '../movie_detail/view.dart';


class PopularMovieScreen extends StatefulWidget {
  const PopularMovieScreen({Key? key}) : super(key: key);

  @override
  _PopularMovieScreenState createState() => _PopularMovieScreenState();
}

class _PopularMovieScreenState extends State<PopularMovieScreen> {
  late List <Results> allPopularMovie;
  @override
  void initState() {
    BlocProvider.of<MovieCubit>(context).getMovie();
    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MovieCubit, MoviesState>(
      builder: (context, state) {
        if (state is MovieLoaded) {
          allPopularMovie = (state).popularMovie!;
          return buildLoadedListWidgets();
        } else {
          print(state);
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.primary,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: AppColor.black,
        child: Column(
          children: [
            buildPopularMovieList(),
          ],
        ),
      ),
    );
  }

  Widget buildPopularMovieList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allPopularMovie.length,
      itemBuilder: (ctx, index) {
        return MovieItem(
            movieItem: allPopularMovie[index]
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'PopularMovie',
      style: TextStyle(color: AppColor.white),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: AppColor.secondary,
              ),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        title: _buildAppBarTitle(),

      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity,
            Widget child,) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}