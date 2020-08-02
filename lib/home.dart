import 'package:flutter/cupertino.dart';

import 'main.dart';
import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  int _tipCalculator = 0;
  int _personCounter = 1;
  int _tipPercentage = 0;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BILL SPLIT"),backgroundColor: Colors.purple,),
        body: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20.5),
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.purpleAccent.shade100.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("Total Per Person", style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                  color: Colors.purple,
                ),), Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("\$ ${calculatePerPerson(_billAmount, _personCounter, _tipPercentage)}", style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),),
                )],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0)),
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: Colors.purple),
                  decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money)),
                  onChanged: (String value) {
                    try {
                      _billAmount = double.parse(value);
                    } catch (exception) {
                      _billAmount = 0.0;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Split",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_personCounter > 1) {
                                _personCounter--;
                              } else {
                                //do nothing
                              }
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.purple.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "$_personCounter",
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _personCounter++;
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.purple.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //tip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Tip",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "\$ ${(calculateTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    )
                  ],
                ),

                //Slider
                Column(
                  children: <Widget>[
                    Text(
                      "$_tipPercentage%",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    Slider(
                        min: 0,
                        max: 100,
                        activeColor: Colors.purple,
                        inactiveColor: Colors.grey,
                        divisions: 20,
                        value: _tipPercentage.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _tipPercentage = newValue.round();
                          });
                        })
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
  calculatePerPerson(double billAmount,int splitBy, int tipPercentage){
    var totalPerPerson=(calculateTip(billAmount, splitBy, tipPercentage) + billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip=0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null){
      //do Nothing
    }
    else{
      totalTip = (billAmount * tipPercentage)/100;
    }

    return totalTip;

  }
}
