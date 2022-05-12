import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:radiosurabhi/model/hosts_model.dart';

import 'package:radiosurabhi/repositories/host_repo.dart';

import '../resources/api/app_exception.dart';

class HostsBloc {
  late HostsRepo _hostsListRepo;

  StreamController? _hostsListController;

  StreamSink<List<HostsModel>> get hostsListSink =>
      _hostsListController!.sink as StreamSink<List<HostsModel>>;

  Stream<List<HostsModel>> get hostsListStream =>
      _hostsListController!.stream as Stream<List<HostsModel>>;

  HostsBloc() {
    _hostsListRepo = HostsRepo();
    _hostsListController = StreamController<List<HostsModel>>.broadcast();
  }

  getHostsListdata() async {
    try {
      List<HostsModel> response = await _hostsListRepo.gethostsList();
      hostsListSink.add(response);
    } catch (e) {
      if (e is FetchDataException) {
      } else {}
      debugPrint(e.toString());
    }
  }

  dispose() {
    _hostsListController?.close();
  }
}
