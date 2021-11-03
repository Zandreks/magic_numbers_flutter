import 'package:MagicNumbers/Models/ModelDrop1.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSumma extends StatefulWidget {
  AddSumma(
      {Key key,
      this.addSuma,
      this.dropdownValue,
      this.onChangeReplenishmentPeriod,
      this.showYear,
      this.lang})
      : super(key: key);
  TextEditingController addSuma;
  String dropdownValue;
  Function onChangeReplenishmentPeriod;
  String lang;
  bool showYear;
  @override
  _AddSummaState createState() => _AddSummaState();
}

class _AddSummaState extends State<AddSumma> {
  ColorHexSet colorHexSet = ColorHexSet();

  @override
  Widget build(BuildContext context) {
    List items = [
      ModelDrop1(
          text: widget.lang == "RU" ? "В неделю" : "In Week", val: "week"),
      ModelDrop1(
          text: widget.lang == "RU" ? "В месяц" : "In month", val: "month"),
      ModelDrop1(text: widget.lang == "RU" ? "В год" : "In year", val: "year")
    ].map((item) {
      return DropdownMenuItem(
        child: Text(item.text),
        value: item.val,
      );
    }).toList();

    if (widget.showYear == false) {
      items = items.where((f) => f.value != 'year').toList();
    }

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
                          ? "Сумма пополнения"
                          : "Top-up amount",
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          color: colorHexSet.colorFromHex("#686C77"),
                          fontFamily: "SF Pro Display"),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 10)),
                    TextField(
                      controller: widget.addSuma,
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
                        hintText: widget.lang == "RU"
                            ? "Введите сумму пополнения"
                            : "Enter the top-up amount",
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
              Padding(padding: const EdgeInsets.only(left: 14)),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.lang == "RU" ? "Выберите период" : "Select period",
                    style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        color: colorHexSet.colorFromHex("#686C77"),
                        fontFamily: "SF Pro Display"),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 10)),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 10, bottom: 0.0, top: 0.0),
                    decoration: BoxDecoration(
                      color: colorHexSet.colorFromHex("#f6f6f6"),
                      border: Border.all(
                          color: colorHexSet.colorFromHex('#E8E8E8'), width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        value: widget.dropdownValue,
                        underline: Container(
                          height: 0,
                          color: Colors.black26,
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: colorHexSet.colorFromHex("#686c77"),
                            fontFamily: "SF Pro Display"),
                        icon: Image.asset('assets/icons/Shape.png'),
                        onChanged: (var newValue) {
                          widget.onChangeReplenishmentPeriod(newValue);
                        },
                        items: items),
                  )
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
