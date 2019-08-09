import 'package:flutter/material.dart';
import 'MyDetailPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail('Not Ekle');
        },
        tooltip: 'Not ekle',
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListView MyListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
            title: Text('title text'),
            subtitle: Text('description text'),
            trailing: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onTap: () {
              debugPrint('card tapped');
              navigateToDetail('Not Düzelt');
            },
          ),
        );
      },
    );
  }

  void navigateToDetail(String textt) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyDetailPage(textt);
    }));
  }
}
