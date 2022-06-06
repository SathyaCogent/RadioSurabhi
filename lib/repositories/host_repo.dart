import 'dart:convert';

import 'package:radiosurabhi/model/hosts_model.dart';
import 'package:radiosurabhi/resources/api/api_base_helper.dart';

class HostsRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<HostsModel>> gethostsList() async {
    List<HostsModel> hostsdataList = <HostsModel>[];
    var dataResponse = await _helper.get('im/v1/hosts');

    json
        .decode(dataResponse)["data"]
        .forEach((e) => hostsdataList.add(HostsModel.fromJson(e)));
    return hostsdataList;
  }
}
