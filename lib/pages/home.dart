import 'package:flutter/material.dart';
import 'package:currency_converter_app/services/api.dart' as api;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final realCtrl = TextEditingController();
  final dollarCtrl = TextEditingController();
  final euroCtrl = TextEditingController();

  double dollar;
  double euro;

  void _realChange(String text){
    double value = double.parse(text);
    this.dollarCtrl.text = (value/this.dollar).toStringAsFixed(2);
    this.euroCtrl.text = (value/this.euro).toStringAsFixed(2);
  }
  void _dollarChange(String text){
    double value = double.parse(text);
    this.realCtrl.text = (value * this.dollar).toStringAsFixed(2);
    this.euroCtrl.text = ((value * this.dollar) / this.euro).toStringAsFixed(2);
  }
  void _euroChange(String text){
    double value = double.parse(text);
    this.realCtrl.text = (value * this.euro).toStringAsFixed(2);
    this.dollarCtrl.text = (value * this.euro / this.dollar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor \$'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: this.getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return snapshot.hasError ? this.buildError() : this.buildForm(snapshot.data['results']['currencies']);
          }
        },
      ),
    );
  }

  Widget buildForm(Map currencies){
    this.dollar = currencies['USD']['buy'];
    this.euro = currencies['EUR']['buy'];
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.monetization_on,
            size: 120,
            color: Colors.green,
          ),
          Divider(),
          this.builTextField('Reais', 'R\$', this.realCtrl, this._realChange),
          Divider(),
          this.builTextField('Dolares', '\$', this.dollarCtrl, this._dollarChange),
          Divider(),
          this.builTextField('Euros', '€', this.euroCtrl, this._euroChange),
        ],
      )
    );
  }

  Widget builTextField(String label, String prefix, TextEditingController ctrl, Function change){
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixText: '$prefix ',
        border: OutlineInputBorder()
      ),
      onChanged: (value) {
        change(value);
      },
    );
  }

  Widget buildError(){
    return Center(
      child: Text('Ocorreu algum erro ao carregar os dados!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 60
        ),
      ),
    );
  }

  Future<Map> getData() async{
    return await api.getCurrencies();
  }
}
