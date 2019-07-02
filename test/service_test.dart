import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_bloc/src/models/SearchResult.dart';
import 'package:github_search_bloc/src/services/GithubService.dart';


void main(){
  
  test('Busca termo api github', () async {
    GitHubService gitHubService = GitHubService();
    String term = 'flutter';

      SearchResult result = await gitHubService.search(term);

      expect( true , result.items.length > 0);
  });
}