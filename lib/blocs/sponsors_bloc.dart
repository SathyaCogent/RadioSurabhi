import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:radiosurabhi/model/archieves_model.dart';
import 'package:radiosurabhi/model/sponsors_model.dart';
import 'package:radiosurabhi/repositories/archives_repo.dart';
import 'package:radiosurabhi/repositories/sponsors_repo.dart';

import '../resources/api/app_exception.dart';

class SponsorsBloc {
  late SponsorsRepo _sponsorsListRepo;

  StreamController? _sponsorListController;

  StreamSink<List<SponsorsModel>> get sponsorListSink =>
      _sponsorListController!.sink as StreamSink<List<SponsorsModel>>;

  Stream<List<SponsorsModel>> get sponsorListStream =>
      _sponsorListController!.stream as Stream<List<SponsorsModel>>;

  SponsorsBloc() {
    _sponsorsListRepo = SponsorsRepo();
    _sponsorListController = StreamController<List<SponsorsModel>>.broadcast();
  }

  getSponsorsListdata() async {
    try {
      List<SponsorsModel> response = await _sponsorsListRepo.getsponsorsList();
      sponsorListSink.add(response);
    } catch (e) {
      if (e is FetchDataException) {
      } else {}
      debugPrint(e.toString());
    }
  }

  dispose() {
    _sponsorListController?.close();
  }
}
