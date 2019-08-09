import 'package:flutter/material.dart';

class MyDetailPage extends StatefulWidget {
  String appTitle;

  MyDetailPage(this.appTitle);

  @override
  _MyDetailPageState createState() => _MyDetailPageState(this.appTitle);
}

class _MyDetailPageState extends State<MyDetailPage> {
  String appTitle;

  _MyDetailPageState(this.appTitle);

  static var _priority = ['Yüksek', 'Orta', 'Düşük'];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStylee = Theme.of(context).textTheme.title;
    return WillPopScope(
      onWillPop: () {
        returnLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
            onPressed: () {
              returnLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: DropdownButton(
                    items: _priority.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    style: textStylee,
                    value: 'Düşük',
                    onChanged: (value) {
                      setState(() {
                        debugPrint('dropdwon selected $value');
                      });
                    }),
              ),
              ListTile(
                title: TextField(
                  controller: titleController,
                  style: textStylee,
                  onChanged: (value) {
                    debugPrint('textfield1 clicked');
                  },
                  decoration: InputDecoration(
                      labelText: 'Not',
                      labelStyle: textStylee,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              ListTile(
                title: TextField(
                  controller: descriptionController,
                  style: textStylee,
                  onChanged: (value) {
                    debugPrint('textfield2 clicked');
                  },
                  decoration: InputDecoration(
                      labelText: 'Açıklama',
                      labelStyle: textStylee,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Sil',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          debugPrint('delete clicked');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Kaydet',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          debugPrint('save clicked');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void returnLastScreen() {
    Navigator.pop(context);
  }
}
