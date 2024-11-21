import 'package:flutter/material.dart';
import 'package:movie_search/pages/search_page.dart';
import 'package:movie_search/provider/imdb_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>ImdbProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Search',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home:  SearchPage(),
      ),
    );
  }
}