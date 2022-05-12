import 'package:flutter/material.dart';
import 'package:radiosurabhi/blocs/archives_bloc.dart';

import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/stream.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';
import 'package:radiosurabhi/ui/widgets/youtubecontroller.dart';

class Archives extends StatefulWidget {
  const Archives({Key? key, this.istestimonials = false}) : super(key: key);
  final bool istestimonials;
  @override
  State<Archives> createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  late ArchiveBloc archiveListBloc;
  @override
  void initState() {
    super.initState();

    archiveListBloc = ArchiveBloc();
    archiveListBloc.getArchiveListdata();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        heading: !widget.istestimonials ? "Archives" : "Testimonials",
        back: true,
        body: StreamWidget(archiveListBloc.archiveListStream, _buildContent));
  }

  Widget _buildContent(BuildContext context, var dataList) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Textwidget(
                  data: !widget.istestimonials ? "Archives" : "Testimonials",
                  isheading1: false,
                  isheading2: true,
                  isheading3: false,
                ),
              ),
              ListView.builder(
                  itemCount: dataList.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: YoutubeController(
                          url: dataList[index].videoUrl,
                        ),
                      ),
                    );
                  }),
            ]));
  }
}
