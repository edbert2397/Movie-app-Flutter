import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/movie_credit.dart';
import 'package:movieapp/models/movie_detail.dart';
import 'package:movieapp/models/people_detail.dart';

class Api{
  static const popularUrl = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1";
  static const accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMGZmY2Y2MTIwNjE5YmY0MWFlOGFiYmFlN2M5MmY4YSIsInN1YiI6IjY1YjM1ZjZjYTBmMWEyMDE3YWJlNDNiOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.q7sleN_TxbOzsMKAiYOqVtwJ2Mw38Qk5R-4zpM1KnxM";
  static const detailUrl = "https://api.themoviedb.org/3/movie/";
  static const creditUrl = "https://api.themoviedb.org/3/movie/";
  static const PersonUrl = "https://api.themoviedb.org/3/person/";
  Future<Movie> fetchPopulerMovie() async{
    final response = await http.get(Uri.parse(popularUrl),
      headers:{
        "Authorization": "Bearer $accessToken",
      }
    );
    if(response.statusCode == 200){
      // print(response.body);
      return movieFromJson(response.body);
    }
    else{
      throw Exception("Failed to load popular movies");
    }
  } 

  Future<MovieDetail> fetchPopulerMovieDetail(int id) async{
    final response = await http.get(Uri.parse(detailUrl + id.toString() + "?language=en-US" ),
      headers: {
        "Authorization": "Bearer $accessToken",
      }
    );
    if(response.statusCode == 200){
      return movieDetailFromJson(response.body);
    }
    else{
      throw Exception("Failed to load detail movie with id = $id");
    }

  }

  Future<MovieCredits> fetchPopulerMovieCredits(int id) async{
    final response = await http.get(Uri.parse(creditUrl + id.toString() + "/credits?language=en-US"),
      headers: {
        "Authorization": "Bearer $accessToken",
      }
    );
    if(response.statusCode == 200){
      return movieCreditsFromJson(response.body);
    }
    else{
      throw Exception("Failed to load credit movie with id = $id");
    }
  }
  Future<PeopleDetail> fetchPeopleDetail(int id) async{
    final response = await http.get(Uri.parse(PersonUrl + id.toString() + "?language=en-US"),
      headers: {
        "Authorization": "Bearer $accessToken",
      }
    );
    if(response.statusCode == 200){
      return peopleDetailFromJson(response.body);
    }
    else{
      throw Exception("failed to load person detail with id = $id");
    }
  }
}