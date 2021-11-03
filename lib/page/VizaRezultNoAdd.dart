import 'package:MagicNumbers/Models/DBProvider.dart';
import 'package:MagicNumbers/Models/History.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisaRezultNoAdd extends StatefulWidget {
  VisaRezultNoAdd({Key key}) : super(key: key);

  @override
  _VisaRezultNoAddState createState() => _VisaRezultNoAddState();
}

class _VisaRezultNoAddState extends State<VisaRezultNoAdd> {
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
                                        Image.asset('assets/icons/comision.png'),
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
                                        Image.asset('assets/icons/comision.png'),
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
                                        Image.asset('assets/icons/finalSuma.png'),
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
                                        Image.asset('assets/icons/finalSuma.png'),
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
                                        Image.asset('assets/icons/kalendar.png'),
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
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 20, bottom: 20, right: 12),
                              child: TextField(
                                controller: name,
                                decoration: InputDecoration(
                                  errorText: errorName != "" ? errorName : null,
                                  hintText: lang == "RU"
                                      ? 'Введите наименование'
                                      : "Enter name",
                                  prefixIcon:
                                      Image.asset('assets/icons/name.png'),
                                  fillColor:
                                      colorHexSet.colorFromHex("#f6f6f6"),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: colorHexSet
                                              .colorFromHex("#E8E8E8"))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: colorHexSet
                                              .colorFromHex("#E8E8E8"))),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: colorHexSet
                                            .colorFromHex("#E8E8E8")),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 12.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ])),
                  Positioned(
                      bottom: -13,
                      child: RaisedButton(
                        onPressed: () => save(history),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              lang == "RU"
                                  ? "Сохранить результат"
                                  : "Save result",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontFamily: "SF Pro Display",
                              )),
                        ),
                      )),
                ]),
            Padding(padding: const EdgeInsets.only(top: 20))
          ],
        ));
  }

  save(History data) async {
    setState(() {
      errorName = '';
    });
    if (name.text == "") {
      setState(() {
        errorName =
            lang == "RU" ? "Заполните это поле." : "Please fill in this field.";
      });
      return false;
    }
    data.name = name.text;
    var resul = await DBProvider.db.newClient(data);
    Navigator.pop(context);
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
