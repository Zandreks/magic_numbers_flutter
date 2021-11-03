import 'package:MagicNumbers/Models/History.dart';
import 'package:MagicNumbers/Models/DBProvider.dart';
import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.lang}) : super(key: key);
  String lang;
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ColorHexSet colorHexSet = ColorHexSet();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<History>>(
      future: DBProvider.db.getAllClients(),
      builder: (BuildContext context, AsyncSnapshot<List<History>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                History item = snapshot.data[index];
                return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: new Container(
                        padding: EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: new Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.lang == "RU" ? "Удалить" : 'Delete',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: "SF Pro Display",
                                    fontSize: 13,
                                    color: colorHexSet.colorFromHex("#FFFFFF"),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10)),
                                Image.asset('assets/icons/delete.png'),
                              ],
                            ))),
                    onDismissed: (direction) {
                      DBProvider.db.deleteClient(item.id);
                    },
                    child: Card(
                      color: colorHexSet.colorFromHex("#FAFAFA"),
                      child: ListTile(
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          item.typeFunc == "visaNoAdd"
                              ? Navigator.pushNamed(
                                  context, './resultVizaNoAddHistory',
                                  arguments: item)  
                              : item.typeFunc == "visaAdd"?
                              Navigator.pushNamed(
                                  context, './resultVizaAddHistory',
                                  arguments: item):

                               Navigator.pushNamed(context, './resultHistory',
                                  arguments: item);
                        },
                        subtitle: Text(
                          item.typeFunc == null
                              ? '${item.staf}% ${item.startSumma} = ${item.finalSuma}'
                              : "",
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 12,
                            color: colorHexSet.colorFromHex("#8A8A8E"),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        leading: Image.asset(
                          'assets/icons/Save.png',
                          height: 40,
                          width: 40,
                        ),
                        title: Text(
                          item.name,
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 15,
                            color: colorHexSet.colorFromHex("#292F3F"),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ));
              },
            );
          } else {
            return Center(
                child: Text(widget.lang == "RU" ? "Нет данных" : "No data"));
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
          ));
        }
      },
    );
  }
}
