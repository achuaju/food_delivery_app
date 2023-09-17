import 'package:flutter/material.dart';
import 'package:food_fly/loginpaGE.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Define variables to hold user data
  String name = '';
  String mobileNumber = '';
  String email = '';

  // Text controllers to retrieve values from TextField widgets
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // Function to save user data
  void saveUserData() {
    // Store the data entered by the user
    setState(() {
      name = nameController.text;
      mobileNumber = mobileNumberController.text;
      email = emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display user profile picture (you can add a static image here)
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/default_profile.png'),
              ),
              SizedBox(height: 16),
              // Text fields for name, mobile number, and email
              TextField(
                controller: nameController,
                onChanged: (value) => setState(() => name = value),
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: mobileNumberController,
                onChanged: (value) => setState(() => mobileNumber = value),
                decoration: InputDecoration(labelText: 'Mobile Number'),
              ),
              TextField(
                controller: emailController,
                onChanged: (value) => setState(() => email = value),
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              // Button to save user data
              ElevatedButton(
                onPressed: saveUserData,
                child: Text('Save'),
              ),
              SizedBox(height: 30),
              // Display user data
              Text('Name: $name'),
              Text('Mobile Number: $mobileNumber'),
              Text('Email: $email'),
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PROJEC(),
                        ),
                      );
                      // Add your cart button logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .black, // Set the button background color to black
                    ),
                    child: Text("Log out"),
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
