import 'package:MagicNumbers/Models/History.dart';
import 'package:MagicNumbers/Widgets/HistoryPage.dart';
import 'package:MagicNumbers/Widgets/Vis.dart';
import 'package:MagicNumbers/Widgets/addSumma.dart';
import 'package:MagicNumbers/Widgets/period.dart';
import 'package:MagicNumbers/Widgets/staf.dart';
import 'package:MagicNumbers/Widgets/starSunna.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:MagicNumbers/page/VisAdd.dart';
import 'package:MagicNumbers/page/info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TextEditingController rate = TextEditingController();
  TextEditingController initialAmount = TextEditingController();
  TextEditingController addSuma = TextEditingController();
  TextEditingController period = TextEditingController();

  TabController _tabController;

  String replenishmentPeriod = "month";
  String storagePeriod = "month";
  String errorRate = '';
  String errorInitialAmount = '';
  String errorAddSuma = '';
  String errorPeriod = '';
  String errorCommissionPercentage = '';
  String errorCommissionAmount = '';
  String lang = 'RU';
  int index = 1;
  String titleBar = '';
  bool load = false;
  @override
  void initState() {
    super.initState();
    rate = new TextEditingController(text: '12');
    initialAmount = new TextEditingController(text: '1000');
    period = new TextEditingController(text: '12');
    _tabController = TabController(length: 3, vsync: this);

    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lan = prefs.getString("lang");
    if (lan == null) {
      setState(() {
        lang = "RU";
        titleBar = "Magic numbers ";
      });
      prefs.setString('lang', "RU");
    } else {
      setState(() {
        lang = lan;
        titleBar = lan == "RU" ? "Magic numbers " : "Magic numbers ";
      });
    }
  }

  String onchangeTitleBar(val) {
    switch (val) {
      case 0:
        return lang == "RU" ? "ИНФОРМАЦИЯ" : "INFORMATION";
        break;
      case 1:
        return lang == "RU" ? "Magic numbers" : "Magic numbers ";
        break;
      case 2:
        return lang == "RU" ? "История" : "History";
        break;
      default:
        return "";
    }
  }

  List page = [];
  ColorHexSet colorHexSet = ColorHexSet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            titleBar.toUpperCase(),
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
          bottom: index == 1
              ? TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: [
                    Tab(
                        text: lang == "RU"
                            ? "Сложные проценты"
                            : "Compound interest"),
                    Tab(
                        text: lang == "RU"
                            ? "Инвест счёт с займом"
                            : "Invest account with a loan"),
                    Tab(
                        text: lang == "RU"
                            ? "Инвест счёт с займом и пополнением"
                            : "Invest account with loan and replenishment"),
                  ],
                )
              : null,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorHexSet.colorFromHex("#E9E9E9"),
            selectedItemColor: colorHexSet.colorFromHex("#888888"),
            unselectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (value) {
              setState(() {
                index = value;
                titleBar = onchangeTitleBar(value);
              });
            },
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/info.png'), title: Text("")),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/calculator.png'),
                  title: Text("")),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/history.png'),
                  title: Text("")),
            ]),
        body: index == 1
            ? load == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(controller: _tabController, children: [
                    ListView(
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
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        top: 23,
                                        bottom: 23),
                                    decoration: BoxDecoration(
                                      color:
                                          colorHexSet.colorFromHex('#fafafa'),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: colorHexSet
                                              .colorFromHex("#000000")
                                              .withOpacity(0.25),
                                          blurRadius: 7,

                                          offset: Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Staf(
                                              rate: rate,
                                              errorRate: errorRate,
                                              lang: lang),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 14)),
                                        Expanded(
                                          child: StarSunna(
                                              initialAmount: initialAmount,
                                              errorInitialAmount:
                                                  errorInitialAmount,
                                              lang: lang),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 30)),
                                  AddSumma(
                                      addSuma: addSuma,
                                      dropdownValue: replenishmentPeriod,
                                      onChangeReplenishmentPeriod:
                                          onChangeReplenishmentPeriod,
                                          showYear: true,
                                      lang: lang),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 30)),
                                  Period(
                                      period: period,
                                      errorPeriod: errorPeriod,
                                      storagePeriod: storagePeriod,
                                      onChangeStoragePeriod:
                                          onChangeStoragePeriod,
                                      lang: lang),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 30)),
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: -13,
                                child: RaisedButton(
                                  onPressed: sendResult,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
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
                                            ? "Показать результат"
                                            : "Show result",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "SF Pro Display",
                                        )),
                                  ),
                                )),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 20))
                      ],
                    ),
                    ListView(
                      children: [
                        VisNoAdd(
                          lang: lang,
                        ),
                        Padding(padding: const EdgeInsets.only(top: 20)),
                      ],
                    ),
                    ListView(
                      children: [
                        VisAdd(
                          lang: lang,
                        ),
                        Padding(padding: const EdgeInsets.only(top: 20)),
                      ],
                    ),
                  ])
            : index == 0
                ? Info(lang: lang)
                : HistoryPage(lang: lang));
  }

  bool sendResult() {
    setState(() {
      load = true;
    });
    if (chekErrorEndClear() == false) {
      setState(() {
        load = false;
      });
      return false;
    }
    double addSummaInPeriod = 0;
    if (addSuma.text != "") {
      addSummaInPeriod = double.parse(addSuma.text);
      setState(() {
        addSuma = new TextEditingController(text: addSummaInPeriod.toString());
      });
    }
    double staf = double.parse(rate.text);
    double startSumma = double.parse(initialAmount.text);
    int periodCount = int.parse(period.text);
    setState(() {
      rate = new TextEditingController(text: staf.toString());
      initialAmount = new TextEditingController(text: startSumma.toString());
      period = new TextEditingController(text: periodCount.toString());
    });
    if (storagePeriod == "year") {
      periodCount = periodCount * 12;
    }

    if (addSummaInPeriod == 0.0) {
      chetNotAddCount(staf, startSumma, periodCount);
    }
    if (addSummaInPeriod != 0.0 && replenishmentPeriod == "month") {
      chetAddCountMontch(staf, startSumma, periodCount, addSummaInPeriod);
    }
    if (addSummaInPeriod != 0.0 && replenishmentPeriod == "week") {
      chetAddCountWeek(staf, startSumma, periodCount, addSummaInPeriod);
    }
    if (addSummaInPeriod != 0.0 && replenishmentPeriod == "year") {
      chetAddCountYear(staf, startSumma, periodCount, addSummaInPeriod);
    }
  }

  chetAddCountYear(
    double staf,
    double startSumma,
    int periodCount,
    double addSummaInPeriod,
  ) {
    History history = History();
    List<HistoryGraf> historyGrafArr = [];
    double prosent = staf / 100;
    double endSumma = startSumma;
    double sumaAddFinal = 0;

    history.startSumma = startSumma;
    history.countAdd = 0;
    history.finalAddSumma = 0.0;
    history.addSumma = addSummaInPeriod;
    history.countMonth = periodCount;
    history.staf = staf;
    history.addText = replenishmentPeriod;
    history.periodText = storagePeriod;

    int flagMonth = 1;
    for (var i = 0; i < periodCount; i++) {
      if (flagMonth == 12) {
        endSumma = endSumma + addSummaInPeriod;
        history.finalAddSumma = history.finalAddSumma + addSummaInPeriod;
        history.countAdd = history.countAdd + 1;
        flagMonth = 1;
      }
      double countOneMonth = endSumma * (prosent / 12);
      countOneMonth = countOneMonth.roundToDouble();
      sumaAddFinal = sumaAddFinal + countOneMonth;
      endSumma = endSumma + countOneMonth;

      HistoryGraf itemGraf = HistoryGraf(numberM: i + 1, countSumma: endSumma);
      historyGrafArr.add(itemGraf);
      flagMonth++;
    }
    history.finalSuma = endSumma;
    history.finalProfit = sumaAddFinal;
    history.historyGraf = historyGrafArr;
    setState(() {
      load = false;
    });
    Navigator.pushNamed(context, './result', arguments: history);
  }

  void chetAddCountWeek(double staf, double startSumma, int periodCount,
      double addSummaInPeriod) {
    History history = History();
    List<HistoryGraf> historyGrafArr = [];
    double prosent = staf / 100;
    double endSumma = startSumma;
    double sumaAddFinal = 0;

    history.startSumma = startSumma;
    history.countAdd = periodCount * 4;
    history.addSumma = addSummaInPeriod;
    history.countMonth = periodCount;
    history.staf = staf;
    history.addText = replenishmentPeriod;
    history.periodText = storagePeriod;

    for (var i = 0; i < periodCount; i++) {
      double addSummaWekk = addSummaInPeriod * 4;
      endSumma = endSumma + addSummaWekk;
      double countOneMonth = endSumma * (prosent / 12);
      countOneMonth = countOneMonth;
      sumaAddFinal = sumaAddFinal + countOneMonth;
      endSumma = endSumma + countOneMonth;

      HistoryGraf itemGraf = HistoryGraf(numberM: i + 1, countSumma: endSumma);
      historyGrafArr.add(itemGraf);
    }
    history.finalAddSumma = addSummaInPeriod * (periodCount * 4);
    history.finalSuma = endSumma;
    history.finalProfit = sumaAddFinal;
    history.historyGraf = historyGrafArr;
    setState(() {
      load = false;
    });
    Navigator.pushNamed(context, './result', arguments: history);
  }

  void chetAddCountMontch(double staf, double startSumma, int periodCount,
      double addSummaInPeriod) {
    History history = History();
    List<HistoryGraf> historyGrafArr = [];
    double prosent = staf / 100;

    double endSumma = startSumma;
    double sumaAddFinal = 0;
    history.startSumma = startSumma;
    history.countAdd = periodCount - 1;
    history.addSumma = addSummaInPeriod;
    history.countMonth = periodCount;
    history.staf = staf;
    history.addText = replenishmentPeriod;
    history.periodText = storagePeriod;
    for (var i = 0; i < periodCount; i++) {
      if (i != 0) {
        endSumma = endSumma + addSummaInPeriod;
      }
      double countOneMonth = endSumma * (prosent / 12);
      countOneMonth = countOneMonth;
      sumaAddFinal = sumaAddFinal + countOneMonth;
      endSumma = endSumma + countOneMonth;

      HistoryGraf itemGraf = HistoryGraf(numberM: i + 1, countSumma: endSumma);
      historyGrafArr.add(itemGraf);
    }
    history.finalAddSumma = addSummaInPeriod * (periodCount - 1);
    history.finalSuma = endSumma;
    history.finalProfit = sumaAddFinal;
    history.historyGraf = historyGrafArr;
    setState(() {
      load = false;
    });
    Navigator.pushNamed(context, './result', arguments: history);
  }

  void chetNotAddCount(double staf, double startSumma, int periodCount) {
    History history = History();
    List<HistoryGraf> historyGrafArr = [];
    double prosent = staf / 100;
    double endSumma = startSumma;
    history.startSumma = startSumma;
    history.countAdd = 0;
    history.addSumma = 0.0;
    history.finalAddSumma = 0.0;
    history.countMonth = periodCount;
    history.staf = staf;
    history.addText = replenishmentPeriod;
    history.periodText = storagePeriod;
    double sumaAddFinal = 0;
    for (var i = 0; i < periodCount; i++) {
      double countOneMonth = endSumma * (prosent / 12);
      countOneMonth = countOneMonth;

      sumaAddFinal = sumaAddFinal + countOneMonth;
      endSumma = endSumma + countOneMonth;

      HistoryGraf itemGraf = HistoryGraf(numberM: i + 1, countSumma: endSumma);
      historyGrafArr.add(itemGraf);
    }
    history.finalSuma = endSumma;
    history.finalProfit = sumaAddFinal;
    history.historyGraf = historyGrafArr;
    setState(() {
      load = false;
    });
    Navigator.pushNamed(context, './result', arguments: history);
  }

  bool chekErrorEndClear() {
    setState(() {
      errorRate = "";
      errorInitialAmount = "";
      errorPeriod = "";
      errorCommissionPercentage = '';
      errorCommissionAmount = '';
    });
    if (rate.text == "" || double.parse(rate.text) <= 0) {
      setState(() {
        errorRate = lang == "RU"
            ? "Заполните это поле. Поле должно быть больше 0 "
            : "Please fill in this field. The field must be greater than 0";
      });
      return false;
    }
    if (initialAmount.text == "" || double.parse(initialAmount.text) <= 0) {
      setState(() {
        errorInitialAmount = lang == "RU"
            ? "Заполните это поле. Поле должно быть больше 0 "
            : "Please fill in this field. The field must be greater than 0";
      });
      return false;
    }
    if (period.text == "" || double.parse(period.text) <= 0) {
      setState(() {
        errorPeriod = lang == "RU"
            ? "Заполните это поле. Поле должно быть больше 0 "
            : "Please fill in this field. The field must be greater than 0";
      });

      return false;
    }

    return true;
  }

  void onChangeReplenishmentPeriod(var val) {
    setState(() {
      replenishmentPeriod = val;
    });
  }

  void onChangeStoragePeriod(String val) {
    setState(() {
      storagePeriod = val;
    });
  }

  void choiceAction(String choice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (index == 1) {
      setState(() {
        lang = choice;
        titleBar = choice == "RU" ? "Magic numbers " : "Magic numbers ";
      });
    }
    if (index == 2) {
      setState(() {
        lang = choice;
        titleBar = choice == "RU" ? "История" : "History";
      });
    }
    if (index == 0) {
      setState(() {
        lang = choice;
        titleBar = choice == "RU" ? "ИНФОРМАЦИЯ" : "INFORMATION";
      });
    }
    prefs.setString('lang', choice);
  }
}
