import 'dart:convert';

import 'package:radiosurabhi/model/news_model.dart';
import 'package:radiosurabhi/resources/api/api_base_helper.dart';

class NewsRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<NewsModel>> getNewsList() async {
    List<NewsModel> dataList = <NewsModel>[];
    var dataResponse = await _helper.get('im/v1/news');

    json
        .decode(dataResponse)["data"]
        .forEach((e) => dataList.add(NewsModel.fromJson(e)));
    return dataList;
  }
}
