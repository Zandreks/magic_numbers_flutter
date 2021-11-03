import 'dart:convert';

class History {
  int id;
  String name;
  var startSumma;
  var staf;
  String addText;
  String periodText;
  int countAdd;
  var addSumma;
  var finalAddSumma;
  int countMonth;
  var finalSuma;
  var finalProfit;
  double accountOpeningFee;
  double accountActivationFee;
  int termInMonths;
  double borrowedFunds;
  double contractAmount;
  double profitabilityPerMonth;
  double yieldPerYear;
  String typeFunc;
  List<HistoryGraf> historyGraf;

  History(
      {this.id,
      this.name,
      this.startSumma,
      this.staf,
      this.addText,
      this.periodText,
      this.countAdd,
      this.addSumma,
      this.finalAddSumma,
      this.countMonth,
      this.finalSuma,
      this.finalProfit,
      this.accountOpeningFee,
      this.accountActivationFee,
      this.termInMonths,
      this.borrowedFunds,
      this.contractAmount,
      this.profitabilityPerMonth,
      this.yieldPerYear,
      this.typeFunc,
      this.historyGraf});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startSumma = json['startSumma'];
    staf = json['staf'];
    addText = json['addText'];
    periodText = json['periodText'];
    countAdd = json['countAdd'];
    addSumma = json['addSumma'];
    finalAddSumma = json['finalAddSumma'];
    countMonth = json['countMonth'];
    finalSuma = json['finalSuma'];
    finalProfit = json['finalProfit'];
    accountOpeningFee = json['accountOpeningFee'];
    accountActivationFee = json['accountActivationFee'];
    termInMonths = json['termInMonths'];
    borrowedFunds = json['borrowedFunds'];
    contractAmount = json['contractAmount'];
    profitabilityPerMonth = json['profitabilityPerMonth'];
    yieldPerYear = json['yieldPerYear'];
    typeFunc = json['typeFunc'];
    if (json['HistoryGraf'] != null && json['HistoryGraf'] != "null") {
      Type type = json['HistoryGraf'].runtimeType;
      var data = json['HistoryGraf'];
      if (type != HistoryGraf) {
        data = jsonDecode(json['HistoryGraf']);
      }
      historyGraf = new List<HistoryGraf>();
      data.forEach((v) {
        historyGraf.add(new HistoryGraf.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['startSumma'] = this.startSumma;
    data['staf'] = this.staf;
    data['addText'] = this.addText;
    data['periodText'] = this.periodText;
    data['countAdd'] = this.countAdd;
    data['addSumma'] = this.addSumma;
    data['finalAddSumma'] = this.finalAddSumma;
    data['countMonth'] = this.countMonth;
    data['finalSuma'] = this.finalSuma;
    data['finalProfit'] = this.finalProfit;
    data['accountOpeningFee'] = this.accountOpeningFee;
    data['accountActivationFee'] = this.accountActivationFee;
    data['termInMonths'] = this.termInMonths;
    data['borrowedFunds'] = this.borrowedFunds;
    data['contractAmount'] = this.contractAmount;
    data['profitabilityPerMonth'] = this.profitabilityPerMonth;
    data['yieldPerYear'] = this.yieldPerYear;
    data['typeFunc'] = this.typeFunc;
    if (this.historyGraf != null) {
      data['historyGraf'] = this.historyGraf.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryGraf {
  int idHistory;
  int numberM;
  var countSumma;

  HistoryGraf({this.idHistory, this.numberM, this.countSumma});

  HistoryGraf.fromJson(Map<String, dynamic> json) {
    idHistory = json['idHistory'];
    numberM = json['numberM'];
    countSumma = json['countSumma'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idHistory'] = this.idHistory;
    data['numberM'] = this.numberM;
    data['countSumma'] = this.countSumma;
    return data;
  }
}
