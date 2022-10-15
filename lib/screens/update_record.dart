import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdateRecord extends StatefulWidget {

  const UpdateRecord({Key? key, required this.schedulesKey}) : super(key: key);

  final String schedulesKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {

  final  userNameController = TextEditingController();
  final  ordinanceController= TextEditingController();
  final  dateController =TextEditingController();
  final  phoneNumberController =TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Schedules');
    getSchedules();
  }

  void getSchedules() async {
    DataSnapshot snapshot = (await dbRef.child(widget.schedulesKey).get());

    Map schedules = snapshot.value as Map;

    userNameController.text = schedules['name'];
    ordinanceController.text = schedules['ordinance'];
    dateController.text = schedules['date'];
    phoneNumberController.text = schedules['contact'];

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating schedules'),
      ),
      body:  Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Updating schedules in Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                  hintText: 'Enter Your Full Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: ordinanceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ordinance',
                  hintText: 'Enter Ordinance',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: dateController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date',
                  hintText: 'Enter Date',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact',
                  hintText: 'Enter Phone Number',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> schedule = {
                    'name': userNameController.text,
                    'ordinance': ordinanceController.text,
                    'date': dateController.text,
                    'contact': phoneNumberController.text
                  };

                  dbRef.child(widget.schedulesKey).update(schedule)
                      .then((value) => {
                    Navigator.pop(context)
                  });
                },
                child: const Text('Update Schedule'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}