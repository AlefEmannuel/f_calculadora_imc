import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _information = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _information = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight/(height * height);
      if(imc < 18.6){
        _information = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _information = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _information = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _information = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _information = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _information = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields,)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.person_outline,
              size: 120.0,
              color: Colors.black,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 25),
              controller: weightController,
              validator: (value) {
                if(value.isEmpty){
                  return "Insira seu peso!";
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 25),
              controller: heightController,
              validator: (value) {
                if(value.isEmpty){
                  return "Insira sua altura!";
                }
              }
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _calculate();
                  }
                },
                child: Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                color: Colors.black,
              ),
            )
            ),
            Text(
              _information,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 25.0),
            ),
          ]
        ),
        )
      ),
    );
  }
}
