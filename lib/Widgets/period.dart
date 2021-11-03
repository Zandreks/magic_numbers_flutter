import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Period extends StatefulWidget {
  Period(
      {Key key,
      this.period,
      this.errorPeriod,
      this.storagePeriod,
      this.onChangeStoragePeriod,
      this.lang})
      : super(key: key);
  TextEditingController period;
  String errorPeriod;
  String storagePeriod;
  Function onChangeStoragePeriod;
  String lang;
  @override
  _PeriodState createState() => _PeriodState();
}

class _PeriodState extends State<Period> {
  ColorHexSet colorHexSet = ColorHexSet();
  String selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = "month";
  }

  setSelectedRadio(String val) {
    widget.onChangeStoragePeriod(val);
    setState(() {
      selectedRadio = val;
    });
  }

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
                      widget.lang == "RU" ? "Срок вклада" : "Deposit term",
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          color: colorHexSet.colorFromHex("#686C77"),
                          fontFamily: "SF Pro Display"),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 10)),
                    TextField(
                      controller: widget.period,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: colorHexSet.colorFromHex("#686c77"),
                          fontFamily: "SF Pro Display"),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp(r"^\d+"))
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('assets/icons/kalendar.png'),
                        fillColor: colorHexSet.colorFromHex("#f6f6f6"),
                        filled: true,
                        errorText: widget.errorPeriod != ""
                            ? widget.errorPeriod
                            : null,
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
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: ButtonBar(
                  buttonPadding: const EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: 0),
                  alignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: "month",
                      groupValue: selectedRadio,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setSelectedRadio(val);
                      },
                    ),
                    Text(
                      widget.lang == "RU" ? "Месяцев" : "Months",
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          color: colorHexSet.colorFromHex("#292E3A"),
                          fontFamily: "SF Pro Display"),
                    ),
                    Radio(
                      value: "year",
                      groupValue: selectedRadio,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setSelectedRadio(val);
                      },
                    ),
                    Text(
                      widget.lang == "RU" ? "Лет" : "Years",
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          color: colorHexSet.colorFromHex("#292E3A"),
                          fontFamily: "SF Pro Display"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
