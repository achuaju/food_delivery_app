import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'bookingpayment.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String pickupLocation = '';
  String selectedDate = '';
  String selectedTimeSlot = '';
  String endDate = '';
  String numberOfRiders = '';
  String car = '';

  void _addBookingToFirestore() async {
    try {
      await firestore.collection('bookings').add({
        'pickupLocation': pickupLocation,
        'selectedDate': selectedDate,
        'selectedTimeSlot': selectedTimeSlot,
        'endDate': endDate,
        'numberOfRiders': numberOfRiders,
        "car": car,
      });

      setState(() {
        pickupLocation = '';
        selectedDate = '';
        selectedTimeSlot = '';
        endDate = '';
        numberOfRiders = '';
        car = '';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking successfully')),
      );
    } catch (e) {
      print('Error adding booking: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        // Save the latitude and longitude to Firestore or use it as needed
        pickupLocation = 'Lat: ${position.latitude}, Long: ${position.longitude}';
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(text: pickupLocation),
                    decoration: InputDecoration(labelText: ' Location'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _getCurrentLocation();

                  },style: ElevatedButton.styleFrom(primary: Colors.pink),
                  child: Text('Select Location'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(primary: Colors.pink),
              child: Text('Select Date'),
            ),
            Text('Selected Date: $selectedDate'),
            TextField(
              decoration: InputDecoration(labelText: 'Selected Time Slot'),
              onChanged: (value) {
                setState(() {
                  selectedTimeSlot = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'time'),
              onChanged: (value) {
                setState(() {
                  endDate = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Name '),
              onChanged: (value) {
                setState(() {
                  numberOfRiders = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'mobile number'),
              onChanged: (value) {
                setState(() {
                  car = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addBookingToFirestore();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BookingPage2(),
                  ),
                );
              },
              child: Text('Book Now'),
              style: ElevatedButton.styleFrom(primary: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }
}
