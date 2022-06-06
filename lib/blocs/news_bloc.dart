import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:radiosurabhi/model/hosts_model.dart';
import 'package:radiosurabhi/model/news_model.dart';

import 'package:radiosurabhi/repositories/host_repo.dart';
import 'package:radiosurabhi/repositories/news_repo.dart';

import '../resources/api/app_exception.dart';

class NewsBloc {
  late NewsRepo _newsListRepo;

  StreamController? _NewsListController;

  StreamSink<List<NewsModel>> get newsListSink =>
      _NewsListController!.sink as StreamSink<List<NewsModel>>;

  Stream<List<NewsModel>> get newsListStream =>
      _NewsListController!.stream as Stream<List<NewsModel>>;

  NewsBloc() {
    _newsListRepo = NewsRepo();
    _NewsListController = StreamController<List<NewsModel>>.broadcast();
  }

  getNewsListdata() async {
    try {
      List<NewsModel> response = await _newsListRepo.getNewsList();
      newsListSink.add(response);
    } catch (e) {
      if (e is FetchDataException) {
      } else {}
      debugPrint(e.toString());
    }
  }

  dispose() {
    _NewsListController?.close();
  }
}
