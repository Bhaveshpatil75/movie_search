import 'package:flutter/material.dart';
import '../models/movie.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;

  const MoviesList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Stack(
          children: [
            Card(
              margin: EdgeInsets.only(left: 8, right: 8, top: 80, bottom: 8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width/1.1,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3 + 20, top:10,right: 5),
                  title: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    movie.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        movie.genres.join(" | "),
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: double.parse(movie.rating)<7.0?double.parse(movie.rating)<4.0?Colors.red:Colors.blue:Colors.green,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          movie.rating+" IMDB",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 16,
              bottom: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  movie.poster,
                  width: MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.height/5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}