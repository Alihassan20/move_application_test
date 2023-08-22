

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:move_application/constant/theme_color.dart';
import 'package:move_application/data/model/popular_model.dart';

import '../../../buisness_logic_cubit/movie_cubit.dart';
import '../../../buisness_logic_cubit/movie_state.dart';

import '../../widgets/movie_item.dart';
import '../../widgets/search_move_item.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List <Results> allPopularMovie;

  late List <Results> searchedForPopularMovie;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchTextController,
        cursorColor: AppColor.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.black,width: 2),
      ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black,width: 2),
          ),
          hintText: 'Find a movie...',
          filled: true,
          fillColor: Colors.white,

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black,width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black,width: 2),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),

        style: const TextStyle(color: AppColor.black, fontSize: 18),
        onChanged: (searchedCharacter) {
          addSearchedFOrItemsToSearchedList(searchedCharacter);
        },
      ),
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedMovie) {
    searchedForPopularMovie = allPopularMovie
        .where((character) =>
        character.title!.toLowerCase().startsWith(searchedMovie))
        .toList();
    setState(() {});
  }
  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: AppColor.black),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: AppColor.black,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

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
        color: AppColor.white,
        child: Column(
          children: [
            _buildSearchField(),
            buildPopularMovieList(),
          ],
        ),
      ),
    );
  }

  Widget buildPopularMovieList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount:
      _searchTextController.text.isEmpty
          ?allPopularMovie.length
          : searchedForPopularMovie.length,

      itemBuilder: (ctx, index) {
        return MovieItemSearch(
            movieItem: _searchTextController.text.isEmpty
                ?allPopularMovie[index]
                : searchedForPopularMovie[index],


        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Search For Movie',
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
      backgroundColor: AppColor.white,

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