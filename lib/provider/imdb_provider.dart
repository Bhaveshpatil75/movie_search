import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search/private/api_keys.dart';
import '../models/movie.dart';

class ImdbProvider with ChangeNotifier {
  final String apiKey = omdbApikey;
  final String baseUrl = 'http://www.omdbapi.com';

  List<Movie>? _movies;
  bool _isLoading = false;
  String? _error;

  List<Movie>? get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMovies(String query) async {
    _isLoading = true;
    _error=null;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('http://www.omdbapi.com/?s=$query&apikey=$apiKey'));
      if (response.statusCode == 200) {
        log(response.body);
        final List<dynamic> searchResults = json.decode(
            response.body)['Search'];
        List<Movie> movies = [];
        for (var result in searchResults) {
          final movieResponse = await http.get(Uri.parse(
              'http://www.omdbapi.com/?i=${result['imdbID']}&apikey=$apiKey'));
          if (movieResponse.statusCode == 200) {
            movies.add(Movie.fromJson(json.decode(movieResponse.body)));
          }
        }
        _movies = movies;
      } else {
        _movies = [];
      }
    }
    catch (e) {
      _error = e.toString();
      _movies = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
