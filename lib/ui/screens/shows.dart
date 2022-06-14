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
      popup(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      heading: "Shows",
      bottombar: true,
      appicon: true,
      back: true,
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20, 10, 10),
          child: Text(
            'Schedule and shows on Radio Surabhi 104.9 FM.',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, color: HexColor('#2e2d2e')),
          )),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: HexColor('#2e2d2e'), width: 2)),
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 170,
            rightHandSideColumnWidth: 1680,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: showsModel.showsInfo.length,
            rowSeparatorWidget: Divider(
              color: HexColor('#d3d3d3'),
              height: 1.0,
              thickness: 2.5,
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
          height: 455,
        ),
      )
    ]);
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Timing', 170),
      _getTitleItemWidget('Monday', 240),
      _getTitleItemWidget('Tuesday', 240),
      _getTitleItemWidget('Wednesday', 240),
      _getTitleItemWidget('Thursday', 240),
      _getTitleItemWidget('Friday', 240),
      _getTitleItemWidget('Saturday', 240),
      _getTitleItemWidget('Sunday', 240),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      decoration: BoxDecoration(
          color: label == "Timing" ? HexColor('#c122b0') : HexColor('#06019c'),
          border: Border(
              right: BorderSide(
            color: HexColor('#d3d3d3'),
            width: 2.5,
          ))),
      child: Center(
          child: Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18))),
      width: width,
      height: 56,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            right: BorderSide(
          color: HexColor('#d3d3d3'),
          width: 2.5,
        )),
        //color: index % 2 == 0 ? HexColor('#e6edf5') : Colors.white,
        color: index % 2 == 0 ? HexColor('#eaf0fe') : HexColor('#eaf0fe'),
      ),
      alignment: Alignment.centerLeft,
      child: Text(showsModel.showsInfo[index].timing,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          )),
      width: 60,
      height: 65,
      padding: const EdgeInsets.all(10),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(children: <Widget>[
      Row(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
              color: HexColor('#d3d3d3'),
              width: 2.5,
            )),
            color: index % 2 == 0 ? Colors.white : Colors.white,
          ),
          child: Text(showsModel.showsInfo[index].monday,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          width: 240,
          height: 65,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
              color: HexColor('#d3d3d3'),
              width: 2.5,
            )),
            color: index % 2 == 0 ? Colors.white : Colors.white,
          ),
          child: Text(showsModel.showsInfo[index].tuesday,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          width: 240,
          height: 65,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
              color: HexColor('#d3d3d3'),
              width: 2.5,
            )),
            color: index % 2 == 0 ? Colors.white : Colors.white,
          ),
          child: Text(showsModel.showsInfo[index].wednesday,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          width: 240,
          height: 65,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
              color: HexColor('#d3d3d3'),
              width: 2.5,
            )),
            color: index % 2 == 0 ? Colors.white : Colors.white,
          ),
          child: Text(showsModel.showsInfo[index].thursday,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          width: 240,
          height: 65,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
              color: HexColor('#d3d3d3'),
              width: 2.5,
            )),
            color: index % 2 == 0 ? Colors.white : Colors.white,
          ),
          child: Text(showsModel.showsInfo[index].friday,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          width: 240,
          height: 65,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
              color: HexColor('#d3d3d3'),
              width: 2.5,
            )),
            color: index % 2 == 0 ? Colors.white : Colors.white,
          ),
          child: Text(showsModel.showsInfo[index].saturday,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          width: 240,
          height: 65,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
        ),
        Container(
          color: index % 2 == 0 ? Colors.white : Colors.white,
          child: Text(showsModel.showsInfo[index].sunday,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          width: 240,
          height: 65,
          padding: const EdgeInsets.all(10),
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
        "07:30 am - 08:00 am",
        "Conscious Living with Amba Lakshmi",
        "Conscious Living with Amba Lakshmi",
        "Conscious Living with Amba Lakshmi",
        "Conscious Living with Amba Lakshmi",
        "Conscious Living with Amba Lakshmi",
        "Conscious Living with Amba Lakshmi",
        "Conscious Living with Amba Lakshmi"),
    ShowsInfo(
        "8:00 am - 10:00 am ",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "Morning Show with Avinash - Chalo India",
        "సురభి పాటల తోట",
        "సురభి పాటల తోట"),
    ShowsInfo(
        "10:00 am - 01:00 pm",
        "సురభి పాటల తోట",
        "సురభి పాటల తోట",
        "సురభి పాటల తోట",
        "Te Ra (Telugu Rangasthalam) with Rajeswari, Bhaskar Rayavaram (11am -1am)",
        "Harivillu with Pavani",
        "Signature Show with Rajeswari, Bhaskar, Ravi and Venu",
        "Signature Show with Rajeswari, Bhaskar, Ravi and Venu"),
    ShowsInfo(
        "01:00 pm - 04:00 pm",
        "సురభి పాటల తోట",
        "Manasu Palika with Vasavi ",
        "సురభి పాటల తోట",
        "సురభి పాటల తోట",
        "Simply Sindhu",
        "Sports Column with Giri",
        "Musical Bouquet with Raja"),
    ShowsInfo(
        "04:00 pm to 07:00 pm",
        "Drive Time Special - మీ..రా.. అంటే మీతో రాజేశ్వరి.",
        "Drive Time Special - మీ..రా.. అంటే మీతో రాజేశ్వరి.",
        "Drive Time Special - మీ..రా.. అంటే మీతో రాజేశ్వరి.",
        "Drive Time Special - మీ..రా.. అంటే మీతో రాజేశ్వరి.",
        "Drive Time Special - మీ..రా.. అంటే మీతో రాజేశ్వరి.",
        "Zara Mass Zara Class with RJ Ashwin",
        "Saradaga Kasepu with RJ Srikanth"),
    ShowsInfo(
        "07:00 pm to 10:00 pm",
        "Non Stop fun with Vasavi Palla",
        "Iqbal toh Aa Rojullo",
        "Madhurimalu with RJ Madhurima",
        "Chithram Vichitram with Anuradha Patri and Sarath Jyotsana",
        "Made in India with Madhu Sravanthi",
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color.fromRGBO(14, 24, 124, 1),
          content: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  'Scroll from Right to Left to view details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
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
                        height: 50,
                        width: 80,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: HexColor("#ffffff"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: Text('ok',
                                style: TextStyle(
                                    fontSize: 18,
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
