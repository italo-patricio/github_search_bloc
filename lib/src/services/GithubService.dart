import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:github_search_bloc/src/config/Config.dart';
import 'package:github_search_bloc/src/models/SearchResult.dart';
import 'package:http/http.dart' as http;

class GitHubService {
  Dio _dio ;

  GitHubService() {
    _dio = Dio() ;
    _dio.options.baseUrl = URL_API;
  }


  Future<SearchResult> search(String term) async {
    print('Iniciando pesquisa..');
    final response = await _dio.get("/search/repositories?q=$term");

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return SearchResult.fromJson(response.data);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
