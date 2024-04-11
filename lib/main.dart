import 'package:flutter/material.dart';
import 'dart:math' as math; // Import math library for pi constant

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculator(),
    );
  }
}
class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}
class _BMICalculatorState extends State<BMICalculator> {
  double height = 170.0;
  double totalInches = 0;
  double feet = 5;
  double inches = 5;
  double weight = 70.0;
  double pounds = 154;
  double bmi = 24.5;
  String res="Normal";
  void calculateBMI() {
    setState(() {
      bmi = weight / ((height / 100) * (height / 100));
    });
  }

  double calculateRotationAngle(double bmi) {
    double normalizedBmi = (bmi - 12) / (31.5 - 12); // Adjust range for 10 to 31.5
    normalizedBmi = math.max(0.0, math.min(normalizedBmi, 1.0));
    double angle = normalizedBmi * 180.0;
    return angle;
  }

  @override
  Widget build(BuildContext context) {
    double side = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator',style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold
        ),),centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Height:'),
            Slider(

              value: height,
              min: 120.0,
              max: 220.0,
              onChanged: (value) {
                setState(() {
                  height = value;
                  calculateBMI();
                  totalInches = height / 2.54;
                  feet = (totalInches / 12).floorToDouble();
                  inches = (totalInches % 12);
                  if(bmi<18.2){
                    res="UnderWeight";
                  }
                  else if(bmi>25){
                    res="OverWeight";
                  }
                  else{
                    res="Normal";
                  }
                });
              },
            ),
            Text('${height.toInt()} cm or ${feet.toInt()} Feet ${inches.toInt()} Inches'),
            SizedBox(height: 20.0),
            Text('Weight:'),
            Slider(
              value: weight,
              min: 30.0,
              max: 150.0,
              onChanged: (value) {
                setState(() {
                  weight = value;
                  pounds = weight * 2.20462;
                  calculateBMI();
                  if(bmi<18.2){
                    res="UnderWeight";
                  }
                  else if(bmi>25){
                    res="OverWeight";
                  }
                  else{
                    res="Normal";
                  }
                });
              },
            ),
            Text('${weight.toInt()} kg or ${pounds.toStringAsFixed(1)} lb'),
            SizedBox(height: 20.0),
            Container(
              height: side * .5,
              child: Stack(
                children: [
                  Image.asset("image/cal.png"), // First image
                  Center(
                    child: Transform.rotate(
                      // Use the calculated rotation angle
                      angle: calculateRotationAngle(bmi) * (math.pi / 180), // Convert to radians
                      child: Image.asset("image/kata.png",), // Second image
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text(
                        'BMI: ${bmi.toStringAsFixed(1)} ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text(
                        'Your Weight is: ${res} ',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
