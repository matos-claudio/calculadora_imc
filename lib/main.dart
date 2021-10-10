import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _globalKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          actions: <Widget>[
            IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(8.0)),
                    Icon(
                      Icons.person_outline,
                      size: 120.0,
                      color: Colors.pinkAccent,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Peso(KG)",
                            labelStyle: TextStyle(color: Colors.pinkAccent)),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 25),
                        controller: weightController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Insira seu peso";
                          }
                        }),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura(cm)",
                            labelStyle: TextStyle(color: Colors.pinkAccent)),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 25),
                        controller: heightController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Insira sua altura";
                          }
                        }),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                _calculate();
                              }
                            },
                            child: Text("Calcular"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.pinkAccent),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 14.0,
                                ))),
                          ),
                        )),
                    Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.pinkAccent, fontSize: 25.0),
                    )
                  ],
                ))));
  }
}
