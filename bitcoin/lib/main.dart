import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyConverterPage(),
    );
  }
}

class MyConverterPage extends StatefulWidget {
  const MyConverterPage({Key? key}) : super(key: key);

  @override
  State<MyConverterPage> createState() => _MyConverterPageState();
}

class _MyConverterPageState extends State<MyConverterPage> {
  TextEditingController textEditingController = TextEditingController();
  List<String> list = [ "btc",
    "eth", "ltc", "bch", "bnb", "eos", "xrp", "xlm", "link", "dot", "yfi",
    "usd", "aed", "ars", "aud", "bdt", "bhd", "bmd", "brl", "cad", "chf", 
    "clp", "cny", "czk", "dkk", "eur", "gbp", "hkd", "huf", "idr", "ils",
    "inr", "jpy", "krw", "kwd", "lkr", "mmk", "mxn", "myr", "ngn", "nok",
    "nzd", "php", "pkr", "pln", "rub", "sar", "sek", "sgd", "thb", "try",
    "twd", "uah", "vef", "vnd", "zar", "xdr", "xag", "xau", "bits", "sats"];
    
  String select = "btc";
  var name = "", unit = "", type = "";
  double value = 0.0, amount = 0.0;
  String description = "Enter number and press convert";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Currency Converter", 
        style: TextStyle(fontWeight : FontWeight.bold, 
        color: Colors.white)),
      ),
        
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Image.asset('assets/images/bitcoin.png', scale:5),
              Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: 
                [
                  const Text("BTC", 
                  style: TextStyle(fontSize: 25, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black)),
                  const Text("BitCoin", 
                  style: TextStyle(fontSize: 15, 
                  color: Colors.black)),
                  TextField(controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "FROM", 
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))
                    ),
                    keyboardType: const TextInputType.numberWithOptions(),
                  ),
                ],
              ),
                
              const Icon(Icons.arrow_downward_rounded, size: 50,),
              Text(name, 
              style: const TextStyle(fontSize: 20, 
              fontWeight: FontWeight.bold, 
              color: Color.fromRGBO(115, 191, 184, 100))),
              Text(description, 
              style: const TextStyle(fontSize: 20, 
              fontWeight: FontWeight.bold, 
              color: Color.fromRGBO(115, 191, 184, 100))),
              DropdownButton(
                itemHeight: 60, 
                value: select,
                onChanged: (newValue) {
                  setState(() {
                    select = newValue.toString();
                  });
                },
                items: list.map((select){
                  return DropdownMenuItem(
                    child: Text(select,
                    ),
                    value: select,
                  );
                }).toList(),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround),
              ),
                
              ElevatedButton(
                onPressed: loadCurrency, child: const Text("Convert"),
              ),
              const SizedBox(height: 10),
            ],
          )
        ),
      )
    );
  }
  
  Future<void> loadCurrency() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      var input  = double.parse(textEditingController.text);
      name = parsedData['rates'][select]["name"];
      unit = parsedData['rates'][select]["unit"];
      value = parsedData['rates'][select]["value"];
      type = parsedData['rates'][select]["type"];
      
      if(name == "btc") {
        amount = input;
        }
         else if(name != "btc") {
           amount = input * value;
        }
        
      setState((){
        description = "$amount";
      });
    }
  }
}