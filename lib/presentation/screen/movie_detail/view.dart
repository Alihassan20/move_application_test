import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_application/constant/theme_color.dart';
import '../../../data/model/popular_model.dart';


class MovieDetailsScreen extends StatelessWidget {
  final Results movieItem;

  const MovieDetailsScreen({Key? key, required this.movieItem})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColor.black,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movieItem.title!,
          style: const TextStyle(color: AppColor.white),
        ),
        background: Hero(
          tag: "${movieItem.id}",
          child: Image.network(
            "https://image.tmdb.org/t/p/w500/${movieItem.posterPath!}",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColor.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
  Widget characterInfo2(String title, String value) {
    return RichText(
      maxLines: 4,

      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColor.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color:AppColor.white,
      thickness: 4,
    );
  }



  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color:AppColor.purple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.black,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Name : ', "${movieItem.title}"),
                      buildDivider(315),
                      characterInfo('Language : ', "${movieItem.originalLanguage}"),
                      buildDivider(315),
                      characterInfo2('Overview : ',"${movieItem.overview}"),
                      buildDivider(250),
                      characterInfo('Date : ',"${movieItem.releaseDate}"),
                      buildDivider(280),  characterInfo('adult : ',"${movieItem.adult}"),
                      buildDivider(280),  characterInfo('genreIds : ',"${movieItem.genreIds}"),
                      buildDivider(280),  characterInfo('Rate : ',"${movieItem.voteCount}"),
                      buildDivider(280),
                      buildDivider(250),
                      characterInfo('Title : ',"${movieItem.originalTitle}"),
                      buildDivider(250),
                      characterInfo('Has Video : ',"${movieItem.video}"),
                      buildDivider(250),
                      Image.network(
                        "https://image.tmdb.org/t/p/w500/${movieItem.posterPath!}",
                        fit: BoxFit.contain,
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}