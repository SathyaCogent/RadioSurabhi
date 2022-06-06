import 'package:flutter/material.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';

class Newshomepageview extends StatefulWidget {
  const Newshomepageview({Key? key, this.newsdata}) : super(key: key);

  final dynamic newsdata;
  @override
  State<Newshomepageview> createState() => _NewshomepageviewState();
}

class _NewshomepageviewState extends State<Newshomepageview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      heading: widget.newsdata.name,
      appicon: true,
      back: true,
      body:
          SingleChildScrollView(child: _buildContent(context, widget.newsdata)),
    );
  }

  Widget _buildContent(BuildContext context, var newstDataList) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: newsList(context, newstDataList),
              )
            ]));
  }

  Widget newsList(BuildContext context, var filterData) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: imagecard(
                context, filterData.coverImageP, screenwidth, screenheight),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Textwidget(
            data: filterData.name,
            isheading1: false,
            isheading2: false,
            isheading3: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: filterData.description.blocks.length,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (filterData.description.blocks[index].data.text ==
                    '&nbsp;&nbsp;') {
                  return Container();
                } else {
                  return Padding(
                      padding: EdgeInsets.only(bottom: 13),
                      child: Text(
                          filterData.description.blocks[index].data.text
                              .toString()
                              .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                          style: TextStyle(fontSize: 14, height: 1.6)));
                }

                /* return Textwidget(
                  data:
                      filterData.description.blocks[index].data.text.toString(),
                  isheading1: false,
                  isheading2: false,
                  isheading3: false,
                );*/
              }),
        ),
      ],
    );
  }

  Widget imagecard(BuildContext context, String assetname, double screenwidth,
      double screenheight) {
    return Image.network(
      assetname,
      width: screenwidth * 0.85,
      height: screenheight * 0.3,
      fit: BoxFit.contain,
    );
  }
}
