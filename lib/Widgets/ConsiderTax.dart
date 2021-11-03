import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsiderTax extends StatefulWidget {
  ConsiderTax(
      {Key key,
      this.commissionPercentage,
      this.commissionAmount,
      this.errorCommissionAmount,
      this.errorCommissionPercentage,
      this.lang})
      : super(key: key);
  TextEditingController commissionPercentage;
  TextEditingController commissionAmount;
  String errorCommissionAmount;
  String errorCommissionPercentage;
  String lang;
  @override
  _ConsiderTaxState createState() => _ConsiderTaxState();
}

class _ConsiderTaxState extends State<ConsiderTax> {
  ColorHexSet colorHexSet = ColorHexSet();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 23, bottom: 23),
          decoration: BoxDecoration(
            color: colorHexSet.colorFromHex('#fafafa'),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: colorHexSet.colorFromHex("#000000").withOpacity(0.25),
                blurRadius: 7,

                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      widget.lang == "RU"
                          ? "Процент комиссии:"
                          : "Commission percentage:",
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          color: colorHexSet.colorFromHex("#686C77"),
                          fontFamily: "SF Pro Display"),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 10)),
                    TextField(
                      controller: widget.commissionPercentage,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(
                            RegExp(r"^\d+\.?\d{0,2}"))
                      ],
                      style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: colorHexSet.colorFromHex("#686c77"),
                          fontFamily: "SF Pro Display"),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: InputDecoration(
                        errorText: widget.errorCommissionPercentage != ""
                            ? widget.errorCommissionPercentage
                            : null,
                        prefixIcon: Image.asset('assets/icons/staf.png'),
                        fillColor: colorHexSet.colorFromHex("#f6f6f6"),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                                color: colorHexSet.colorFromHex("#E8E8E8"))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                                color: colorHexSet.colorFromHex("#E8E8E8"))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: colorHexSet.colorFromHex("#E8E8E8")),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 12.0, bottom: 8.0, top: 8.0),
                      ),
                    ),
                  ])),
              Padding(padding: const EdgeInsets.only(left: 14)),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      widget.lang == "RU"
                          ? "Снимать комиссию каждые:"
                          : "Withdraw commission every:",
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          color: colorHexSet.colorFromHex("#686C77"),
                          fontFamily: "SF Pro Display"),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 10)),
                    TextField(
                      controller: widget.commissionAmount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: colorHexSet.colorFromHex("#686c77"),
                          fontFamily: "SF Pro Display"),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(
                            RegExp(r"^\d+\.?\d{0,2}"))
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: InputDecoration(
                        errorText: widget.errorCommissionAmount != ""
                            ? widget.errorCommissionAmount
                            : null,
                        prefixIcon: Image.asset('assets/icons/balanse.png'),
                        fillColor: colorHexSet.colorFromHex("#f6f6f6"),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                                color: colorHexSet.colorFromHex("#E8E8E8"))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                                color: colorHexSet.colorFromHex("#E8E8E8"))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: colorHexSet.colorFromHex("#E8E8E8")),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 12.0, bottom: 8.0, top: 8.0),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      ],
    );

    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(top: 0)),
          TextField(
            controller: widget.commissionPercentage,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp(r"^\d+\.?\d{0,2}"))
            ],
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(
                labelText: widget.lang == "RU"
                    ? "Процент комиссии:"
                    : "Commission percentage:",
                errorText: widget.errorCommissionPercentage != ""
                    ? widget.errorCommissionPercentage
                    : null,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                icon: Icon(
                  Icons.addchart,
                  size: 35,
                ),
                hintText: widget.lang == "RU"
                    ? 'Введите процент комиссии'
                    : "Enter commission percentage"),
          ),
          Padding(padding: const EdgeInsets.only(top: 8)),
          TextField(
            controller: widget.commissionAmount,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp(r"^\d+\.?\d{0,2}"))
            ],
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(
                labelText: widget.lang == "RU"
                    ? "Снимать комиссию каждые:"
                    : "Withdraw commission every:",
                errorText: widget.errorCommissionAmount != ""
                    ? widget.errorCommissionAmount
                    : null,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                icon: Icon(
                  Icons.attach_money,
                  size: 35,
                ),
                hintText:
                    widget.lang == "RU" ? 'Введите сумму' : "Enter the amount"),
          ),
        ],
      ),
    );
  }
}
