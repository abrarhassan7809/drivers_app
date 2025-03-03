import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  List<String> carTypesList = ["uber-x", "uber-go", "bike"];
  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Car details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (_) => MySplashScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset("asset/images/logo1.png"),
              ),

              SizedBox(height: 10,),
              Text(
                "Enter Car Details",
                style: TextStyle(color: Colors.grey, fontSize: 26, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10,),
              TextField(
                controller: carModelTextEditingController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "Car Model",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller: carNumberTextEditingController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "Car Number",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller: carColorTextEditingController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "Car Color",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                ),
              ),

              SizedBox(height: 10,),
              DropdownButton(
                dropdownColor: Colors.white24,
                iconSize: 26,
                hint: Text(
                  "Choose Car Type",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypesList.map((car){
                  return DropdownMenuItem(
                    value: car,
                    child: Text(
                      car,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {
                  if (carColorTextEditingController.text.isNotEmpty
                      && carNumberTextEditingController.text.isNotEmpty
                      && carModelTextEditingController.text.isNotEmpty
                      && selectedCarType != null) {
                    saveCarInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                ),
                child: Text(
                  "Save Now",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

