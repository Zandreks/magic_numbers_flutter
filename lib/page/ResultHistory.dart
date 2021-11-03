import 'package:MagicNumbers/Models/History.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ResultHistory extends StatefulWidget {
  ResultHistory({Key key}) : super(key: key);
  @override
  _ResultHistoryState createState() => _ResultHistoryState();
}

class _ResultHistoryState extends State<ResultHistory> {
  String lang = 'RU';
  String titleBar = '';
  final oCcy = new NumberFormat("#,##0.0", "en_US");
  var name = TextEditingController();
  String errorName = '';
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lan = prefs.getString("lang");
    if (lan == null) {
      setState(() {
        lang = "RU";
        titleBar = "Результат";
      });
      prefs.setString('lang', "RU");
    } else {
      setState(() {
        lang = lan;
        titleBar = lan == "RU" ? "Результат" : "Result";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    History history = ModalRoute.of(context).settings.arguments;
    ColorHexSet colorHexSet = ColorHexSet();
    final List<Color> color = <Color>[];
    color.add(Colors.blueAccent);
    color.add(Colors.deepPurpleAccent[700]);
    color.add(Colors.deepPurpleAccent);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
      colors: color,
      stops: stops,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    if (history != null) print(history);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            titleBar,
            style: TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 16,
              color: colorHexSet.colorFromHex("#292F3F"),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          actions: [
            PopupMenuButton(
              onSelected: choiceAction,
              icon: lang == "EN"
                  ? Image.asset('assets/icons/en.png')
                  : Image.asset('assets/icons/ru.png'),
              itemBuilder: (BuildContext context) {
                return {'RU', 'EN'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: colorHexSet.colorFromHex('#5E6371'),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(11),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset('assets/icons/staf.png'),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            lang == "RU"
                                                ? "Ставка депозита:"
                                                : "Deposit rate:",
                                            style: TextStyle(
                                              fontFamily: "SF Pro Display",
                                              fontSize: 12,
                                              color: colorHexSet
                                                  .colorFromHex("#292F3F"),
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "${history.staf}%",
                                        style: TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 14,
                                          color: colorHexSet
                                              .colorFromHex("#242323"),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: colorHexSet.colorFromHex("#F2F2F2"),
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset('assets/icons/balanse.png'),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            lang == "RU"
                                                ? "Начальная сумма:"
                                                : "Initial amount:",
                                            style: TextStyle(
                                              fontFamily: "SF Pro Display",
                                              fontSize: 12,
                                              color: colorHexSet
                                                  .colorFromHex("#292F3F"),
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "${oCcy.format(history.startSumma)}",
                                        style: TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 14,
                                          color: colorHexSet
                                              .colorFromHex("#242323"),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset('assets/icons/addSuma.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "После ${history.countAdd} платежей (${oCcy.format(history.addSumma)} каждый): "
                                                  : "After ${history.countAdd} payments (${oCcy.format(history.addSumma)} each):",
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontFamily: "SF Pro Display",
                                                fontSize: 12,
                                                color: colorHexSet
                                                    .colorFromHex("#292F3F"),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "${oCcy.format(history.finalAddSumma)}",
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 14,
                                          color: colorHexSet
                                              .colorFromHex("#242323"),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: colorHexSet.colorFromHex("#F2F2F2"),
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            'assets/icons/finalSuma.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Общая сумма после ${history.countMonth} месяцев:"
                                                  : "Total after ${history.countMonth} months:",
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontFamily: "SF Pro Display",
                                                fontSize: 12,
                                                color: colorHexSet
                                                    .colorFromHex("#292F3F"),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "${oCcy.format(history.finalSuma)}",
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 14,
                                          color: colorHexSet
                                              .colorFromHex("#242323"),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset('assets/icons/profit.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Общая прибыль:"
                                                  : "Total profit:",
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontFamily: "SF Pro Display",
                                                fontSize: 12,
                                                color: colorHexSet
                                                    .colorFromHex("#292F3F"),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "${oCcy.format(history.finalProfit)}",
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 14,
                                          color: colorHexSet
                                              .colorFromHex("#242323"),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 17),
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color:
                                          colorHexSet.colorFromHex('#E8E8E8'),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SfCartesianChart(
                                    zoomPanBehavior: ZoomPanBehavior(
                                        enablePanning: true,
                                        enableMouseWheelZooming: true,
                                        enablePinching: true,
                                        enableDoubleTapZooming: true,
                                        enableSelectionZooming: false,
                                        selectionRectBorderColor: Colors.red,
                                        selectionRectBorderWidth: 1,
                                        selectionRectColor: Colors.grey),
                                    enableAxisAnimation: true,
                                    plotAreaBorderWidth: 0,
                                    primaryXAxis: CategoryAxis(
                                        majorTickLines:
                                            MajorTickLines(width: 0),
                                        majorGridLines:
                                            MajorGridLines(width: 0),
                                        labelStyle: TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 12,
                                          color: colorHexSet
                                              .colorFromHex("#96A5CC"),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    primaryYAxis: NumericAxis(
                                        majorTickLines:
                                            MajorTickLines(width: 0),
                                        majorGridLines:
                                            MajorGridLines(width: 0),
                                        labelStyle: TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 12,
                                          color: colorHexSet
                                              .colorFromHex("#242323"),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift,
                                        numberFormat:
                                            NumberFormat("#,##0.0", "en_US")),
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    series: <ColumnSeries<HistoryGraf, int>>[
                                      ColumnSeries<HistoryGraf, int>(
                                          // Bind data source
                                          borderRadius:
                                              new BorderRadius.circular(10.0),
                                          enableTooltip: true,
                                          name: lang == "RU"
                                              ? "Прибыль"
                                              : "Profit",
                                          dataSource: history.historyGraf,
                                          xValueMapper:
                                              (HistoryGraf sales, _) =>
                                                  sales.numberM,
                                          yValueMapper:
                                              (HistoryGraf sales, _) =>
                                                  sales.countSumma,
                                          gradient: gradientColors)
                                    ])),
                          ])),
                ]),
          ],
        ));
  }

  void choiceAction(String choice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      lang = choice;
      titleBar = choice == "RU" ? "Результат" : "Result";
    });
    prefs.setString('lang', choice);
  }
}
