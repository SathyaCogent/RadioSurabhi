import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:radiosurabhi/model/archieves_model.dart';
import 'package:radiosurabhi/repositories/archives_repo.dart';

import '../resources/api/app_exception.dart';

class ArchiveBloc {
  late ArchiveRepo _archiveListRepo;

  StreamController? _archiveListController;

  StreamSink<List<ArchivesModels>> get archiveListSink =>
      _archiveListController!.sink as StreamSink<List<ArchivesModels>>;

  Stream<List<ArchivesModels>> get archiveListStream =>
      _archiveListController!.stream as Stream<List<ArchivesModels>>;

  ArchiveBloc() {
    _archiveListRepo = ArchiveRepo();
    _archiveListController = StreamController<List<ArchivesModels>>.broadcast();
  }

  getArchiveListdata() async {
    try {
      List<ArchivesModels> response = await _archiveListRepo.getArchiveList();
      archiveListSink.add(response);
    } catch (e) {
      if (e is FetchDataException) {
      } else {}
      debugPrint(e.toString());
    }
  }

  dispose() {
    _archiveListController?.close();
  }
}
