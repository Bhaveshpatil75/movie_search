import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:movie_search/widgets/movies_list.dart';
import 'package:provider/provider.dart';

import '../provider/imdb_provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  void _searchMovie(BuildContext context,String query) {
    final provider = Provider.of<ImdbProvider>(context, listen: false);
    provider.fetchMovies(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                controller: _controller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black,width: 2.0)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black,width: 3.0)
                  ),
                  hintText: 'Search',
                  suffixIcon: IconButton( onPressed: (){
                    _searchMovie(context,_controller.text);
                  }, icon:Icon(Icons.search)),
                ),
              ),
            ),
            Gap(20),
            Consumer<ImdbProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return CircularProgressIndicator();
                } else if (provider.error != null) {
                  return Text('Unexpected Error occured...');
                } else if (provider.movies != null) {
                  return Expanded(child: MoviesList(movies: provider.movies!));
                } else if(provider.movies==[]){
                  return Text('No data found');
                }else{
                  return Text("Search Something...");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
