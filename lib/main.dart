import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 101, 4, 36),
          title: const Text('Medication Remainder', style:TextStyle(color:Colors.white)),
          ),

          body:Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(60),
                child: Image.asset(
                  'assets/MedicineBox.png',
                  height: 130,
                  width: 130,
                  fit: BoxFit.contain,
                ),
              ),

              Container(
                height: 40,
                width: 200,
                color: Colors.green,
                padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                child: const Text("Set Reminder", style: TextStyle(color: Colors.black)),
              )
            ],
          )
      ),
    );
  }
}