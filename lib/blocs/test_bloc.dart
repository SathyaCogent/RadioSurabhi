import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:radiosurabhi/model/archieves_model.dart';
import 'package:radiosurabhi/repositories/test_repo.dart';

import '../repositories/test_repo.dart';
import '../resources/api/app_exception.dart';

class TestBloc {
  late TestRepo _testListRepo;

  StreamController? _testListController;

  StreamSink<List<ArchivesModels>> get testListSink =>
      _testListController!.sink as StreamSink<List<ArchivesModels>>;

  Stream<List<ArchivesModels>> get testListStream =>
      _testListController!.stream as Stream<List<ArchivesModels>>;

  TestBloc() {
    _testListRepo = TestRepo();
    _testListController = StreamController<List<ArchivesModels>>.broadcast();
  }

  getTestListdata() async {
    try {
      List<ArchivesModels> response = await _testListRepo.getTestList();
      testListSink.add(response);
    } catch (e) {
      if (e is FetchDataException) {
      } else {}
      debugPrint(e.toString());
    }
  }

  dispose() {
    _testListController?.close();
  }
}
