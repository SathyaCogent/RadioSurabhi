import 'package:flutter/material.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  State<ShowsPage> createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      heading: "Shows",
      back: true,
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: HorizontalDataTable(
          leftHandSideColumnWidth: 100,
          rightHandSideColumnWidth: 1400,
          isFixedHeader: true,
          headerWidgets: _getTitleWidget(),
          leftSideItemBuilder: _generateFirstColumnRow,
          rightSideItemBuilder: _generateRightHandSideColumnRow,
          itemCount: showsModel.showsInfo.length,
          rowSeparatorWidget: const Divider(
            color: Colors.black54,
            height: 1.0,
            thickness: 0.0,
          ),
          leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
          rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
          verticalScrollbarStyle: const ScrollbarStyle(
            thumbColor: Colors.yellow,
            isAlwaysShown: true,
            thickness: 4.0,
            radius: Radius.circular(5.0),
          ),
          horizontalScrollbarStyle: const ScrollbarStyle(
            thumbColor: Colors.red,
            isAlwaysShown: true,
            thickness: 4.0,
            radius: Radius.circular(5.0),
          ),
        ),
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Timing', 100),
      _getTitleItemWidget('Monday', 200),
      _getTitleItemWidget('Tuesday', 200),
      _getTitleItemWidget('Wednesday', 200),
      _getTitleItemWidget('Thursday', 200),
      _getTitleItemWidget('Friday', 200),
      _getTitleItemWidget('Saturday', 200),
      _getTitleItemWidget('Sunday', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: label == "Timing"
          ? const Color.fromARGB(255, 136, 173, 192)
          : const Color.fromARGB(255, 52, 177, 240),
      child: Center(
          child: Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18))),
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: index % 2 == 0
          ? const Color.fromARGB(179, 175, 195, 205)
          : Colors.white,
      child: Center(
          child: Text(showsModel.showsInfo[index].timing,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(children: <Widget>[
      Row(children: <Widget>[
        Container(
          color: index % 2 == 0
              ? const Color.fromARGB(179, 71, 133, 158)
              : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].monday,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0
              ? const Color.fromARGB(179, 71, 133, 158)
              : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].tuesday,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0
              ? const Color.fromARGB(179, 71, 133, 158)
              : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].wednesday,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0
              ? const Color.fromARGB(179, 71, 133, 158)
              : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].thursday,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0
              ? const Color.fromARGB(179, 71, 133, 158)
              : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].friday,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0
              ? const Color.fromARGB(179, 71, 133, 158)
              : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].saturday,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0
              ? const Color.fromARGB(179, 71, 133, 158)
              : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].sunday,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ])
    ]);
  }
}

ShowsInfoModel showsModel = ShowsInfoModel();

class ShowsInfoModel {
  List<ShowsInfo> showsInfo = [
    ShowsInfo(
        "7.00 to 7.30",
        "Concious Living",
        "Concious Living",
        "Concious Living",
        "Concious Living",
        "Concious Living",
        "Concious Living",
        "Concious Living"),
    ShowsInfo(
        "7.30 to 10.00",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "None",
        "Aadivaram Madhurimalu"),
    ShowsInfo(
        "10.00 to 01.00",
        "Miscellaneous Muchatlu - Sweet n Spicy Potpourri",
        "Miscellaneous Muchatlu - Sweet n Spicy Potpourri",
        "Miscellaneous Muchatlu - Sweet n Spicy Potpourri",
        "Miscellaneous Muchatlu - Sweet n Spicy Potpourri",
        "Miscellaneous Muchatlu - Sweet n Spicy Potpourri",
        "Signature Show",
        "Signature Show"),
    ShowsInfo(
        "01.00 to 04.00",
        "Madhyanam Masti",
        "Madhyanam Masti",
        "Madhyanam Masti",
        "Madhyanam Masti",
        "Madhyanam Masti",
        "Bala Vinodam",
        "Sports Column with Giri"),
    ShowsInfo(
        "04.00 to 07.00",
        "Drive Time Special",
        "Drive Time Special",
        "Drive Time Special",
        "Drive Time Special",
        "Drive Time Special",
        "Drive Time With Ashwin",
        "Drive Time With Srikanth"),
    ShowsInfo(
        "07.00 to 10.00",
        "Vasa pitta Vaasavi",
        "Iqbal tho aa rojulloki",
        "Madhurimalu",
        "Chi.la.sow.Sravanthi",
        "Celebrity Time",
        "B Plus with Bhaskar",
        "none"),
  ];
}

class ShowsInfo {
  String timing;

  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  ShowsInfo(this.timing, this.monday, this.tuesday, this.wednesday,
      this.thursday, this.friday, this.saturday, this.sunday);
}
