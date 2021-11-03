import 'package:MagicNumbers/Models/History.dart';
import 'package:MagicNumbers/Widgets/addSumma.dart';
import 'package:MagicNumbers/Widgets/period.dart';
import 'package:MagicNumbers/Widgets/starSunna.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';

class VisAdd extends StatefulWidget {
  VisAdd({Key key, this.lang}) : super(key: key);
  String lang;
  @override
  _VisAddState createState() => _VisAddState();
}

class _VisAddState extends State<VisAdd> {
  ColorHexSet colorHexSet = ColorHexSet();
  TextEditingController initialAmount = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController addSuma = TextEditingController();

  String errorPeriod = '';
  String errorAddSuma = '';

  String storagePeriod = "month";
  String replenishmentPeriod = "month";
  bool load = false;
  String errorInitialAmount = '';
  @override
  void initState() {
    super.initState();
    initialAmount = new TextEditingController(text: '1100');
    period = new TextEditingController(text: '12');
    addSuma = new TextEditingController(text: "1000");
  }

  @override
  Widget build(BuildContext context) {
    return load == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: colorHexSet.colorFromHex('#5E6371'), width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(11),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 23, bottom: 23),
                        decoration: BoxDecoration(
                          color: colorHexSet.colorFromHex('#fafafa'),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: colorHexSet
                                  .colorFromHex("#000000")
                                  .withOpacity(0.25),
                              blurRadius: 7,

                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: StarSunna(
                                  initialAmount: initialAmount,
                                  errorInitialAmount: errorInitialAmount,
                                  lang: widget.lang),
                            )
                          ],
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(bottom: 30)),
                      AddSumma(
                          addSuma: addSuma,
                          dropdownValue: replenishmentPeriod,
                          onChangeReplenishmentPeriod:
                              onChangeReplenishmentPeriod,
                          showYear: false,
                          lang: widget.lang),
                      Padding(padding: const EdgeInsets.only(bottom: 30)),
                      Period(
                          period: period,
                          errorPeriod: errorPeriod,
                          storagePeriod: storagePeriod,
                          onChangeStoragePeriod: onChangeStoragePeriod,
                          lang: widget.lang),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                    ],
                  ),
                ),
                Positioned(
                    bottom: -13,
                    child: RaisedButton(
                      onPressed: () async {
                        setState(() {
                          load = true;
                        });
                        await sendResult();
                      },
                      // onPressed: () => sendResult().then((value) => null),
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
                            widget.lang == "RU"
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
          );
  }

  void onChangeStoragePeriod(String val) {
    setState(() {
      storagePeriod = val;
    });
  }

  void onChangeReplenishmentPeriod(var val) {
    setState(() {
      replenishmentPeriod = val;
    });
  }

  Future<void> sendResult() {
    setState(() {
      errorInitialAmount = "";
      errorPeriod = "";
    });
    if (initialAmount.text == "" || double.parse(initialAmount.text) < 1100) {
      setState(() {
        errorInitialAmount = widget.lang == "RU"
            ? "Заполните это поле. Поле должно быть больше 1100 "
            : "Please fill in this field. The field must be greater than 1100";
        load = false;
      });
    }
    if (addSuma.text == "" || double.parse(addSuma.text) < 0) {
      setState(() {
        errorInitialAmount = widget.lang == "RU"
            ? "Заполните это поле. Поле должно быть больше 0 "
            : "Please fill in this field. The field must be greater than 0";
        load = false;
      });
    }
    if (period.text == "" || double.parse(period.text) < 0) {
      setState(() {
        errorPeriod = widget.lang == "RU"
            ? "Заполните это поле. Поле должно быть больше 0 "
            : "Please fill in this field. The field must be greater than 0";
        load = false;
      });
    }
    setState(() {
      load = true;
    });
    History history = History();
    List<HistoryGraf> historyGrafArr = [];
    List<double> borrowedFundsArr = [];
    List<double> workingMoneyArr = [];
    double profitabilityPerMonthAll = 0.0;
    double accountActivationFee = 100.0;
    int termInMonths = storagePeriod == "month"
        ? int.parse(period.text)
        : int.parse(period.text) * 12;
    double initialAmountSelf = double.parse(initialAmount.text);
    double addSummaSelf = double.parse(addSuma.text);
    if (replenishmentPeriod == 'week') {
      addSummaSelf = addSummaSelf * 4;
    }
    double clinetAmount = initialAmountSelf;
    double workingMoney = 0.0;

    if (clinetAmount > 3799) {
      workingMoney = clinetAmount - accountActivationFee;
      double contractAmount = workingMoney / 0.37;
      double accountOpeningFee = contractAmount * 0.07;
      workingMoney = workingMoney - accountOpeningFee;
      workingMoney = workingMoney + addSummaSelf;

      double borrowedFunds = (workingMoney * 0.7) / 0.3;

      double profitabilityPerMonth =
          ((borrowedFunds + workingMoney) * 0.13) / 12;
      profitabilityPerMonthAll = profitabilityPerMonthAll +
          double.parse(profitabilityPerMonth.toStringAsFixed(2));
      clinetAmount = workingMoney;
      HistoryGraf itemGraf = HistoryGraf(numberM: 1, countSumma: clinetAmount);
      historyGrafArr.add(itemGraf);
      borrowedFundsArr.add(borrowedFunds);
      workingMoneyArr.add(workingMoney);

      for (int i = 2; i <= termInMonths; i++) {
        double workingMoney = addSummaSelf +
            double.parse(profitabilityPerMonth.toStringAsFixed(2));
        double contractAmount = workingMoney / 0.37;
        if (contractAmount >= 10000) {
          double accountOpeningFee = contractAmount * 0.07;
          workingMoney = workingMoney - accountOpeningFee;
        }
        double borrowedFunds = (workingMoney * 0.7) / 0.3;
        borrowedFundsArr.add(borrowedFunds);
        workingMoneyArr.add(workingMoney);

        profitabilityPerMonth = 0.0;
        double borrowedFundsAll = 0.0;
        double workingMoneyAll = 0.0;
        for (double val in borrowedFundsArr) {
          borrowedFundsAll = borrowedFundsAll + val;
        }
        for (double val in workingMoneyArr) {
          workingMoneyAll = workingMoneyAll + val;
        }
        profitabilityPerMonth =
            ((borrowedFundsAll + workingMoneyAll) * 0.13) / 12;
        profitabilityPerMonthAll = profitabilityPerMonthAll +
            double.parse(profitabilityPerMonth.toStringAsFixed(2));
        clinetAmount = clinetAmount + workingMoney;
        HistoryGraf itemGraf =
            HistoryGraf(numberM: i, countSumma: clinetAmount);
        historyGrafArr.add(itemGraf);
      }
    } else {
      workingMoney = clinetAmount - accountActivationFee - 700;
      workingMoney = workingMoney + addSummaSelf;
      double borrowedFunds = (workingMoney * 0.7) / 0.3;
      // double contractAmount = workingMoney / 0.3;

      double profitabilityPerMonth =
          ((borrowedFunds + workingMoney) * 0.13) / 12;
      profitabilityPerMonthAll = profitabilityPerMonthAll +
          double.parse(profitabilityPerMonth.toStringAsFixed(2));
      clinetAmount = workingMoney;
      HistoryGraf itemGraf = HistoryGraf(numberM: 1, countSumma: clinetAmount);
      historyGrafArr.add(itemGraf);

      borrowedFundsArr.add(borrowedFunds);
      workingMoneyArr.add(workingMoney);

      for (int i = 2; i <= termInMonths; i++) {
        double workingMoney = addSummaSelf +
            double.parse(profitabilityPerMonth.toStringAsFixed(2));
        double borrowedFunds = (workingMoney * 0.7) / 0.3;
        double amountAll = (clinetAmount + addSummaSelf) + borrowedFunds;
        double contractAmount;
        if (amountAll >= 10000) {
          contractAmount = workingMoney / 0.37;
        } else {
          contractAmount = workingMoney / 0.3;
        }
        if (contractAmount >= 10000) {
          double accountOpeningFee = contractAmount * 0.07;
          workingMoney = workingMoney - accountOpeningFee;
        }

        borrowedFundsArr.add(borrowedFunds);
        workingMoneyArr.add(workingMoney);
        profitabilityPerMonth = 0.0;
        double borrowedFundsAll = 0.0;
        double workingMoneyAll = 0.0;
        for (double val in borrowedFundsArr) {
          borrowedFundsAll = borrowedFundsAll + val;
        }
        for (double val in workingMoneyArr) {
          workingMoneyAll = workingMoneyAll + val;
        }
        profitabilityPerMonth =
            ((borrowedFundsAll + workingMoneyAll) * 0.13) / 12;
        profitabilityPerMonthAll = profitabilityPerMonthAll +
            double.parse(profitabilityPerMonth.toStringAsFixed(2));
        clinetAmount = clinetAmount + addSummaSelf;
        HistoryGraf itemGraf =
            HistoryGraf(numberM: i, countSumma: clinetAmount);
        historyGrafArr.add(itemGraf);
      }
    }
    double borrowedFundsAll = 0.0;
    for (double val in borrowedFundsArr) {
      borrowedFundsAll = borrowedFundsAll + val;
    }

    history.startSumma = double.parse(initialAmount.text);
    history.addSumma = addSummaSelf;
    history.typeFunc = 'visaAdd';
    history.historyGraf = historyGrafArr;
    history.finalSuma = clinetAmount + profitabilityPerMonthAll;
    history.countMonth = termInMonths;
    history.borrowedFunds =
        (((clinetAmount + profitabilityPerMonthAll) / 0.3) * 0.7) +
            (clinetAmount + profitabilityPerMonthAll);
    history.profitabilityPerMonth = profitabilityPerMonthAll;
    setState(() {
      load = false;
    });
    Navigator.pushNamed(context, './resultVisaAdd', arguments: history);
  }
}
