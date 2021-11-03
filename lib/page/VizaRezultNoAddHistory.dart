import 'package:MagicNumbers/Models/History.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisaRezultNoAddHistory extends StatefulWidget {
  VisaRezultNoAddHistory({Key key}) : super(key: key);

  @override
  _VisaRezultNoAddHistoryState createState() => _VisaRezultNoAddHistoryState();
}

class _VisaRezultNoAddHistoryState extends State<VisaRezultNoAddHistory> {
  String lang = 'RU';
  String titleBar = '';
  final oCcy = new NumberFormat("#,##0.0", "en_US");
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
                              color: colorHexSet.colorFromHex("#F2F2F2"),
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            'assets/icons/comision.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Коммиссия за открытие счета: "
                                                  : "Account opening fee: ",
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
                                        "${oCcy.format(history.accountOpeningFee)}",
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
                                        Image.asset(
                                            'assets/icons/comision.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Комиссия за активацию счета: "
                                                  : "Account activation fee: ",
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
                                        "${oCcy.format(history.accountActivationFee)}",
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
                                        Image.asset('assets/icons/profit.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Заемные средства:"
                                                  : "Borrowed funds:",
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
                                        "${oCcy.format(history.borrowedFunds)}",
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
                                        Image.asset('assets/icons/balanse.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Сумма контракта:"
                                                  : "Contract amount:",
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
                                        "${oCcy.format(history.contractAmount)}",
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
                                                  ? "Доходность в месяц:"
                                                  : "Profit per month:",
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
                                        "${oCcy.format(history.profitabilityPerMonth)}",
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
                                        Image.asset(
                                            'assets/icons/finalSuma.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Доходность в год:"
                                                  : "Profit per year:",
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
                                        "${oCcy.format(history.yieldPerYear)}",
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
                                            'assets/icons/kalendar.png'),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              lang == "RU"
                                                  ? "Срок в месяцах:"
                                                  : "Term in months:",
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
                                        "${oCcy.format(history.termInMonths)}",
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
                          ])),
                ]),
            Padding(padding: const EdgeInsets.only(top: 20))
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
