import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  //initializing hive
  await Hive.initFlutter();

  //open a box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 100, 26, 57),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 4, 36),
        title: const Text('Medication Reminder', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 40,
              width: 500,
              margin: const EdgeInsets.fromLTRB(80, 50, 0, 0),
              child: const Text("Don't forget to take your medicine!", style: TextStyle(color: Colors.white)),
            ),
            Container(
              height: 180,
              width: 180,
              margin: const EdgeInsets.fromLTRB(0, 1, 20, 0),
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: Image.asset(
                'assets/MedicineBox.png',
                height: 140,
                width: 140,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: ElevatedButton(
                child: const Text('Set Reminder', style: TextStyle(color: Color.fromARGB(255, 101, 4, 36))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Details(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Box myBox;
  List<String> lst = [];

  final timeController = TextEditingController();
  final nameController = TextEditingController();
  final doseController = TextEditingController();
  
   @override
  void initState(){
    // load data, if none exists then default to empty list
    super.initState();
    myBox = Hive.box('myBox');
    lst = myBox.get("Reminder_List", defaultValue: [])?.cast<String>() ?? [];
  }

  @override
  void dispose(){
    // It clean the controller when the widget is removed
    timeController.dispose();
    nameController.dispose();
    doseController.dispose();
    super.dispose();
  }

  // add reminder
  void addReminder(){
    String time = timeController.text;
    String name = nameController.text;
    String dose = doseController.text;

    setState(() {
      lst.add("$time | $name | $dose");
      timeController.clear();
      nameController.clear();
      doseController.clear();
      myBox.put("Reminder_List",lst);
    });
  }
  // delete reminder
  void deleteReminder(int index){
    setState(() {
      lst.removeAt(index);
      myBox.put("Reminder_List", lst);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 100, 26, 57),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 4, 36),
        title: const Text("Set Your Reminder", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 90, 10, 0),
              child: SizedBox(
                height: 40,
                width: 300,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  style: TextStyle(color: Colors.white),     
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Enter Medicine Name:',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  ),
                ),
              ),
            ),
            
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 10, 0),
              child: SizedBox(
                height: 40,
                width: 300,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: doseController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Enter number of Dose:',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  ),
                ),
              ),
            ),
            
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: SizedBox(
                height: 40,
                width: 300,
                child: TextFormField(
                  readOnly: true,
                  controller: timeController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Select Date Time',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  ),

                  onTap: () async{
                    var time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()
                    );

                    if (time != null){
                      timeController.text = time.format(context);
                    }
                  },
                ), 
              ),
            ),
            
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 40, 0),
              height: 20,
              width: 80,
              child: ElevatedButton(
                child: const Text(
                  'Set',
                  style: TextStyle(color: Color.fromARGB(255,0,0,0)),
                ),
                onPressed: (){
                  addReminder();
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: SizedBox(
                          width: 120,
                          height: 40,
                          child: Text("Reminder Set Successfully"),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(60, 15, 0, 0),
                      );
                    },
                  );
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: lst.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(lst[index], style: TextStyle(color: Colors.white)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () => deleteReminder(index),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
