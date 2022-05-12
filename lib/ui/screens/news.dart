import 'package:flutter/material.dart';
import 'package:radiosurabhi/blocs/news_bloc.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/stream.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late NewsBloc newsListBloc;
  @override
  void initState() {
    super.initState();
    newsListBloc = NewsBloc();
    newsListBloc.getNewsListdata();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      heading: 'News and Events',
      back: true,
      body: SingleChildScrollView(
        child: StreamWidget(newsListBloc.newsListStream, _buildContent),
      ),
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
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Textwidget(
                  data: "News and Events",
                  isheading1: false,
                  isheading2: true,
                  isheading3: false,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: newstDataList.length,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: newsList(context, newstDataList[index]),
                    );
                  }),
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
                return Textwidget(
                  data:
                      filterData.description.blocks[index].data.text.toString(),
                  isheading1: false,
                  isheading2: false,
                  isheading3: false,
                );
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
      fit: BoxFit.cover,
    );
  }
}
