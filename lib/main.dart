import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator alkoholika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: MyHomePage(title: 'Kalkulator alkoholika'),
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
  var _iloscController = new TextEditingController();
  var _kopyrtnoscController = new TextEditingController();
  var _wagaController = new TextEditingController();
  var _wynik = 0.0;

  bool _fieldsCorrect() {
    if (_kopyrtnoscController.text != '' &&
        _iloscController != '' &&
        _wagaController != '')
      return true;
    else
      return false;
  }

  AlertDialog _getCalculateDialog() {
    return new AlertDialog(
      content: Text(
        'Twój wynik\n' + _calculateResult() + ' promila\nPicie dozwolone',
        style: TextStyle(fontSize: 32, color: Colors.green, height: 1.8),
        textAlign: TextAlign.center,
      ),
    );
  }

  final List<String> _alcoholTypes = ['Piwo', 'Wódka', 'Wino'];
  String _selectedAlcoholType;

  String _calculateResult() {
    try {
      if (_fieldsCorrect()) {
        double result = double.parse(_iloscController.text) *
            double.parse(_kopyrtnoscController.text) *
            10 /
            double.parse(_wagaController.text);
        return result.toStringAsFixed(2).toString();
      } else
        return '0';
    } catch (ex) {
      return '0';
    }
  }

  static var assetsImage = new AssetImage('assets/images/Party.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Image(image: assetsImage, fit: BoxFit.fitWidth),
                Opacity(
                  opacity: .6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(colors: [
                        Colors.blue,
                        Colors.red
                      ], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter),
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 40,
                  child: Text("Jest kurwa melanż", style: TextStyle(color: Colors.white, fontSize: 28, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700, letterSpacing: 1.2),)
                )
              ],
              fit: StackFit.expand,
            ),
            height: 200,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 24),
            child: TextField(
              controller: _wagaController,
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              decoration: InputDecoration(
                hintText: "W kilogramach np. 65",
                labelText: 'Twoja waga',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _iloscController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "W litrach np. 0.5",
                labelText: "Ilość alkoholu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          /* List of items
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.black38,
                ),

                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                child: DropdownButton(
                  isExpanded: true,
                  value: _selectedAlcoholType,
                  items: _alcoholTypes
                      .map((alcohol) => new DropdownMenuItem(
                            child: new Text(alcohol),
                            value: alcohol,
                          ),)
                      .toList(),
                  onChanged: (String alcohol) {
                    setState(
                      () {
                        _selectedAlcoholType = alcohol;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          */
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              controller: _kopyrtnoscController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              maxLength: 2,
              decoration: InputDecoration(
                hintText: "W procentach np. 6",
                labelText: 'Kopyrtność alkoholu',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return _getCalculateDialog();
                    });
              },
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ESZKEREEE!',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
