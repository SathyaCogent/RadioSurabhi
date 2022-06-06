

import 'dart:convert';

import 'package:radiosurabhi/model/archieves_model.dart';
import 'package:radiosurabhi/resources/api/api_base_helper.dart';

class ArchiveRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<ArchivesModels>> getArchiveList() async {
    List<ArchivesModels> dataList = <ArchivesModels>[];
    var dataResponse = await _helper.get('im/v1/archives');

    json
        .decode(dataResponse)["data"]
        .forEach((e) => dataList.add(ArchivesModels.fromJson(e)));
    return dataList;
  }
}
