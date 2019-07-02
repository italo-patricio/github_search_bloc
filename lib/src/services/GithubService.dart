import 'dart:convert';
import 'package:github_search_bloc/src/config/Config.dart';
import 'package:github_search_bloc/src/models/SearchResult.dart';
import 'package:http/http.dart' as http;

class GitHubService {

  Future<SearchResult> search(String term) async {
    print('Iniciando pesquisa..');
    final response = await http.get("$URL_API/search/repositories?q=$term");

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
