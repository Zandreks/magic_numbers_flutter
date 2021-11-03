import 'package:MagicNumbers/Models/History.dart';
import 'package:MagicNumbers/Widgets/starSunna.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';

class VisNoAdd extends StatefulWidget {
  VisNoAdd({Key key, this.lang}) : super(key: key);
  String lang;

  @override
  _VisNoAddState createState() => _VisNoAddState();
}

class _VisNoAddState extends State<VisNoAdd> {
  ColorHexSet colorHexSet = ColorHexSet();
  TextEditingController initialAmount = TextEditingController();
  String errorInitialAmount = '';
  bool load = false;
  @override
  void initState() {
    super.initState();
    initialAmount = new TextEditingController(text: '1100');
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
                      Padding(padding: const EdgeInsets.only(top: 20)),
                    ],
                  ),
                ),
                Positioned(
                    bottom: -13,
                    child: RaisedButton(
                      onPressed: () => sendResult(),
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

  bool sendResult() {
    setState(() {
      errorInitialAmount = "";
      load = true;
    });
    if (initialAmount.text == "" || double.parse(initialAmount.text) < 1100) {
      setState(() {
        errorInitialAmount = widget.lang == "RU"
            ? "Заполните это поле. Поле должно быть больше 1100 "
            : "Please fill in this field. The field must be greater than 1100";
      });
      return false;
    }
    History history = History();
    if (double.parse(initialAmount.text) <= 3799) {
      double accountOpeningFee = 700.0;
      double accountActivationFee = 100.0;
      int termInMonths = 12;

      double clientFunds = double.parse(initialAmount.text) -
          (accountOpeningFee + accountActivationFee);
      double borrowedFunds = (clientFunds * 0.7) / 0.3;
      double contractAmount = clientFunds / 0.3;
      double profitabilityPerMonth =
          ((borrowedFunds + clientFunds) * 0.13) / termInMonths;
      double yieldPerYear = (borrowedFunds + clientFunds) * 0.13;
      history.startSumma = double.parse(initialAmount.text);
      history.accountOpeningFee = accountOpeningFee;
      history.accountActivationFee = accountActivationFee;
      history.borrowedFunds = borrowedFunds;
      history.contractAmount = contractAmount;
      history.profitabilityPerMonth = profitabilityPerMonth;
      history.yieldPerYear = yieldPerYear;
      history.typeFunc = 'visaNoAdd';
      history.termInMonths = termInMonths;
      setState(() {
        load = false;
      });
      Navigator.pushNamed(context, './resultVizaNoAdd', arguments: history);
    } else {
      double accountActivationFee = 100.0;
      double contractAmount =
          (double.parse(initialAmount.text) - accountActivationFee) / 0.37;
      double accountOpeningFee = contractAmount * 0.07;
      int termInMonths = 12;
      double clientFunds = double.parse(initialAmount.text) -
          (accountOpeningFee + accountActivationFee);
      double borrowedFunds = (clientFunds * 0.7) / 0.3;
      double profitabilityPerMonth =
          ((borrowedFunds + clientFunds) * 0.13) / termInMonths;
      double yieldPerYear = (borrowedFunds + clientFunds) * 0.13;
      history.startSumma = double.parse(initialAmount.text);
      history.accountOpeningFee = accountOpeningFee;
      history.accountActivationFee = accountActivationFee;
      history.borrowedFunds = borrowedFunds;
      history.contractAmount = contractAmount;
      history.profitabilityPerMonth = profitabilityPerMonth;
      history.yieldPerYear = yieldPerYear;
      history.typeFunc = 'visaNoAdd';
      history.termInMonths = termInMonths;
      setState(() {
        load = false;
      });
      Navigator.pushNamed(context, './resultVizaNoAdd', arguments: history);
    }
  }
}
