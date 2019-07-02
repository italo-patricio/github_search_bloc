import 'dart:async';

import 'package:github_search_bloc/src/models/SearchResult.dart';
import 'package:github_search_bloc/src/services/GithubService.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  GitHubService _service = GitHubService();

  final _searchController = BehaviorSubject<String>();

  Observable<String> get searchFlux => _searchController.stream;
  Sink<String> get searchSink => _searchController.sink;

  Stream<SearchResult> apiResultFlux;

  SearchBloc() {
    apiResultFlux = searchFlux
        .distinct()
        .where((valor) => valor.length > 2)
        .debounceTime(Duration(milliseconds: 500))
        .asyncMap(_service.search)
        .switchMap((valor) => Observable.just(valor));
  }

  void dispose() {
    _searchController?.close();
  }
}
