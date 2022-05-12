import 'dart:convert';

import 'package:radiosurabhi/model/sponsors_model.dart';
import 'package:radiosurabhi/resources/api/api_base_helper.dart';

class SponsorsRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<SponsorsModel>> getsponsorsList() async {
    List<SponsorsModel> sponsorssdataList = <SponsorsModel>[];
    var dataResponse = await _helper.get('im/v1/sponsors');

    json
        .decode(dataResponse)["data"]
        .forEach((e) => sponsorssdataList.add(SponsorsModel.fromJson(e)));
    return sponsorssdataList;
  }
}
