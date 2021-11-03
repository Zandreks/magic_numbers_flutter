import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Staf extends StatefulWidget {
  Staf({Key key, this.rate, this.errorRate, this.lang}) : super(key: key);
  TextEditingController rate;
  String errorRate;
  String lang;
  @override
  _StafState createState() => _StafState();
}

class _StafState extends State<Staf> {
  ColorHexSet colorSet = ColorHexSet();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lang == "RU" ? "Ставка депозита %" : "Deposit rate %",
          style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.normal,
              color: colorSet.colorFromHex("#686C77"),
              fontFamily: "SF Pro Display"),
          overflow: TextOverflow.ellipsis,
        ),
        Padding(padding: const EdgeInsets.only(top: 10)),
        TextField(
          controller: widget.rate,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: colorSet.colorFromHex("#686c77"),
              fontFamily: "SF Pro Display"),
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp(r"^\d+\.?\d{0,2}"))
          ],
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: true),
          decoration: InputDecoration(
            errorText: widget.errorRate != "" ? widget.errorRate : null,
            prefixIcon: Image.asset('assets/icons/staf.png'),
            fillColor: colorSet.colorFromHex("#f6f6f6"),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide:
                    BorderSide(color: colorSet.colorFromHex("#E8E8E8"))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide:
                    BorderSide(color: colorSet.colorFromHex("#E8E8E8"))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: colorSet.colorFromHex("#E8E8E8")),
            ),
            contentPadding:
                const EdgeInsets.only(left: 12.0, bottom: 8.0, top: 8.0),
          ),
        ),
      ],
    );
  }
}
