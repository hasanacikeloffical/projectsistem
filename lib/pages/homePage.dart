import 'package:flutter/material.dart';
import 'package:projectsistem/pages/settingsPage.dart';
import 'package:projectsistem/pages/profilePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

    
  final List<Widget> _pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    ProfilePage(), // Profil sayfası
    SettingPage(), // Ayarlar sayfası
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _pages[_currentIndex]),
          if (_currentIndex == 0)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectionPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade300,
              ),
              child: Center(
                child: Text("Ekle", style: TextStyle(color: Colors.white)),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple.shade100,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        iconSize: 30,
         items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings',),
        ],
      ),
    );
  }
}

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedBodyPart;
  List<String> bodyParts = ["Head", "Arms", "Legs", "Back", "Chest"];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _confirmSelection() {
    if (selectedDate != null &&
        selectedTime != null &&
        selectedBodyPart != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ConfirmationPage(
                date: selectedDate!,
                time: selectedTime!,
                bodyPart: selectedBodyPart!,
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Date, Time & Body Part')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  selectedDate == null
                      ? "Tarih Seç"
                      : "Seçilen Tarih: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  selectedTime == null
                      ? "Zaman Seç"
                      : "Seçilen Zaman: ${selectedTime!.format(context)}",
                ),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                hint: Text("Vücut Bölgesi Seç"),
                value: selectedBodyPart,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBodyPart = newValue;
                  });
                },
                items:
                    bodyParts.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmSelection,
                child: Text("Onayla"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationPage extends StatefulWidget {
  final DateTime date;
  final TimeOfDay time;
  final String bodyPart;

  ConfirmationPage({
    required this.date,
    required this.time,
    required this.bodyPart,
  });

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  List<Map<String, dynamic>> notes = [];
  TextEditingController noteController = TextEditingController();

  void addNote() {
    if (noteController.text.isNotEmpty) {
      setState(() {
        notes.add({"text": noteController.text, "completed": false});
        noteController.clear();
      });
    }
  }

  void toggleNoteCompletion(int index) {
    setState(() {
      notes[index]["completed"] = !notes[index]["completed"];
    });
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notlar")),
      body: Column(
        children: [
          TextField(
            controller: noteController,
            decoration: InputDecoration(
              hintText: "Not ekleyin...",
              hintStyle: TextStyle(color: Colors.purple),
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(onPressed: addNote, child: Text("Not Ekle")),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    notes[index]["text"],
                    style: TextStyle(
                      decoration:
                          notes[index]["completed"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                  onTap: () => toggleNoteCompletion(index),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteNote(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
