import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosurabhi/ui/screens/home_page.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  State<ShowsPage> createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (HomePage.popupinfo) popup(context);
    });
  }

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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: HexColor('#c8d4df'), width: 2)),
        child: HorizontalDataTable(
          leftHandSideColumnWidth: 100,
          rightHandSideColumnWidth: 1400,
          isFixedHeader: true,
          headerWidgets: _getTitleWidget(),
          leftSideItemBuilder: _generateFirstColumnRow,
          rightSideItemBuilder: _generateRightHandSideColumnRow,
          itemCount: showsModel.showsInfo.length,
          rowSeparatorWidget: const Divider(
            color: Colors.grey,
            height: 1.0,
            thickness: 1,
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
        height: 420,
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Timing', 200),
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
      color: label == "Timing" ? HexColor('#71a1dd') : HexColor('#4d9de6'),
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
      color: index % 2 == 0 ? HexColor('#e6edf5') : Colors.white,
      child: Center(
          child: Text(showsModel.showsInfo[index].timing,
              style:
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 14))),
      width: 100,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(children: <Widget>[
      Row(children: <Widget>[
        Container(
          color: index % 2 == 0 ? HexColor('#4d9de6') : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].monday,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14))),
          width: 200,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0 ? HexColor('#4d9de6') : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].tuesday,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14))),
          width: 200,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0 ? HexColor('#4d9de6') : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].wednesday,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14))),
          width: 200,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0 ? HexColor('#4d9de6') : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].thursday,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14))),
          width: 200,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0 ? HexColor('#4d9de6') : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].friday,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14))),
          width: 200,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0 ? HexColor('#4d9de6') : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].saturday,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14))),
          width: 200,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0 ? HexColor('#4d9de6') : Colors.white,
          child: Center(
              child: Text(showsModel.showsInfo[index].sunday,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14))),
          width: 200,
          height: 56,
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
        "Drive Time Special-మీ..రా..అంటేమీతో రాజేశ్వరి.",
        "Drive Time Special-మీ..రా..అంటేమీతో రాజేశ్వరి.",
        "Drive Time Special-మీ..రా..అంటేమీతో రాజేశ్వరి. ",
        "Drive Time Special-మీ..రా..అంటేమీతో రాజేశ్వరి. ",
        "Drive Time Special-మీ..రా..అంటేమీతో రాజేశ్వరి. ",
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

Future<void> popup(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.black87,
              content: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scroll from Right to Left to view details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: HexColor('#ffffff'),
                              fontFamily: "Roboto"),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                            child: Icon(
                              Icons.swipe_left,
                              color: HexColor('#ffffff'),
                              size: 80,
                            )),
                        const SizedBox(height: 25),
                        Center(
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: HexColor("#ffffff"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        )),
                                    child: Text('ok',
                                        style: TextStyle(
                                            fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                            fontFamily: "Roboto",
                                            color: Colors.black)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        HomePage.popupinfo = false;
                                      });
                                    }))),
                      ])),
            );
          });
    },
  );
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
