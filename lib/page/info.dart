import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class Info extends StatefulWidget {
  Info({Key key, this.lang}) : super(key: key);
  String lang;

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  ColorHexSet colorHexSet = ColorHexSet();
  Future<void> _launched;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorHexSet.colorFromHex("#FAFAFA"),
            border: Border.all(
                color: colorHexSet.colorFromHex('#5E6371'), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(11),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Image.asset('assets/icons/Logo.png'),
              Text("Magic numbers",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    fontFamily: "SF Pro Display",
                  )),
              Padding(padding: const EdgeInsets.only(bottom: 30)),
              Text(
                  widget.lang == "RU"
                      ? "Magic numbers - это калькулятор сложных процентов с дополнительным функционалом для консалтинговых компаний в сфере финансов, инвестиций, расчётов. Лучшее решение для: финансовых консультантов, банковских работников, инвесторов, финансовых аналитиков, людей кто следит за своими финансами. Сложный процент считается секретом богатейших людей планеты, по их мнению – это «восьмое чудо света», еще Альберт Энштейн сказал, что самым выдающимся открытием человека являются сложные проценты. Принцип его действия достаточно прост, однако требует точности вычислений. Простыми словами сложный процент (капитализация) – начисление «% на %». «Тот, кто понимает сложный процент, тот на нем зарабатывает, а кто не понимает, тот платит его повсюду» А.Энштейн"
                      : "Magic numbers - is a compound interest calculator with additional functionality for consulting companies in the field of finance, investments, calculations. The best solution for: financial consultants, bank employees, investors, financial analysts, people who keep track of their finances. Compound interest is considered the secret of the richest people on the planet, in their opinion - this «is the  eighth wonder of the world», even Albert Einstein said that the most outstanding human discovery is compound interest. Its principle of operation is quite simple, but it requires computational accuracy. In simple words, compound interest (capitalization) is the accrual of  «% on %». «The one who understands compound interest, he earns on it, and who does not understand, he pays it everywhere»  A. Einstein",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    fontFamily: "SF Pro Display",
                  ),
                  textAlign: TextAlign.center),
              Padding(padding: const EdgeInsets.only(bottom: 20)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: colorHexSet.colorFromHex("#C6C6C8")),
            ),
          ),
          child: RaisedButton(
            color: Colors.white,
            padding: const EdgeInsets.all(0.0),
            onPressed: () => setState(() {
              _launched = _makePhoneCall('tel:+77019980814');
            }),
            child: Text(
              widget.lang == "RU" ? "Справочный центр" : "Help Center",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: colorHexSet.colorFromHex("#4992DF"),
                fontFamily: "SF Pro Display",
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                  width: 1.0, color: colorHexSet.colorFromHex("#C6C6C8")),
            ),
          ),
          child: RaisedButton(
            color: Colors.white,
            padding: const EdgeInsets.all(0.0),
            onPressed: () => setState(() {
              _launched = _makePhoneCall('mailto:Magicnumbers.calc@gmail.com');
            }),
            child: Text(
              widget.lang == "RU" ? "Напишите нам" : "Write to us",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: colorHexSet.colorFromHex("#4992DF"),
                fontFamily: "SF Pro Display",
              ),
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(bottom: 10)),
        Text(
          '© 2021 Magic numbers ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            color: colorHexSet.colorFromHex("#A5A5A5"),
            fontFamily: "SF Pro Display",
          ),
          textAlign: TextAlign.center,
        ),
        Padding(padding: const EdgeInsets.only(bottom: 10)),
      ],
    );
  }
}
