import 'package:flutter/material.dart';
import 'package:move_application/constant/new_route.dart';
import 'package:move_application/constant/theme_color.dart';
import 'package:move_application/data/model/popular_model.dart';

import '../screen/movie_detail/view.dart';
class MovieItem extends StatelessWidget {
  final Results? movieItem;

  const MovieItem({Key? key, required this.movieItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          MagicRouter.navigateTo(MovieDetailsScreen( movieItem: movieItem!,));
        },
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black87.withOpacity(0.8),
            alignment: Alignment.bottomCenter,
            child: Text(
              '${movieItem!.title}',
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: AppColor.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: "${movieItem!.id}",
            child: Container(
              color: AppColor.white,
              child: movieItem!.posterPath!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/loading.gif',
                image: "https://image.tmdb.org/t/p/w500/${movieItem!.posterPath!}",
                fit: BoxFit.contain,
              )
                  : const Icon(Icons.close),
            ),
          ),
        ),
      ),
    );
  }
}