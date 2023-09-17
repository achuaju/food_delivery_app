import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_fly/bookingpage.dart';
import 'package:food_fly/bookingviewpage.dart';
import 'package:food_fly/profilepage.dart';
import 'reviewpage.dart';
import 'notificationpage.dart';

class CarListScree1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('FOOD FLY'),
        actions: [
          IconButton(
            icon: Icon(Icons.fastfood_rounded),
            onPressed: () {
              // Add your search function here
              print('Search button pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NotificationPage(),
              ),
            );
              // Add your settings function here
              print('Settings button pressed');
            },
          ),
        ],
      ),



      body: CarList(),
    );
  }
}

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  final CollectionReference carsCollection =
      FirebaseFirestore.instance.collection('products');
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 50,
            width: 350,
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(29),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage(),
                      ),
                    );
                    // Add your cart button logic here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors
                        .black, // Set the button background color to black
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home, color: Colors.white),
                      // Set icon color to white
                      SizedBox(width: 8),
                      // Add spacing between icon and text
                      Text("HOME", style: TextStyle(color: Colors.white)),
                      // Set text color to white
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16), // Add some spacing between the buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DataViewPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.black, // Set the button background color to black
                ),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white),
                    // Set icon color to white
                    SizedBox(width: 8),
                    // Add spacing between icon and text
                    Text("ORDERS", style: TextStyle(color: Colors.white)),
                    // Set text color to white
                  ],
                ),
              ),
            ),
            Text(
              ':',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.delivery_dining),
              iconSize: 48,
              color: Colors.black,
              onPressed: () {
                // Navigate to the new screen when IconButton is pressed
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewPage(),
                  ),
                );
              },
            ),
          ],
        ),


        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: carsCollection
                .where('model',
                    isGreaterThanOrEqualTo: searchController.text.toLowerCase())
                .where('model',
                    isLessThan: searchController.text.toLowerCase() +
                        'z') // Adjust as needed
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No cars available.'));
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var carData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  var carImages = carData['images'];
                  var carBrand = carData['brand'];
                  var carModel = carData['model'];
                  var carCondition = carData['condition'];
                  var carPrice = carData['price'];

                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(20),
                      leading: Image.network(
                          carImages != null && carImages.isNotEmpty
                              ? carImages[0]
                              : ''),
                      title: Text('$carBrand $carModel'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Delivery: $carCondition'),
                          Text('Offer Price: $carPrice'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => BookingPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: Text('Booking'),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
