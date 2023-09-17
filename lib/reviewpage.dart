import 'package:flutter/material.dart';



class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;
  bool _liked = false;

  void _handleRatingChanged(int newRating) {
    setState(() {
      _rating = newRating;
    });
  }

  void _toggleLike() {
    setState(() {
      _liked = !_liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Food fly Review'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Rate your experience:',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 1; i <= 5; i++)
                  InkWell(
                    onTap: () => _handleRatingChanged(i),
                    child: Icon(
                      Icons.star,
                      size: 36,
                      color: i <= _rating ? Colors.orange : Colors.grey,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Write a review:',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your review here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: _liked ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                  onPressed: _toggleLike,
                  color: _liked ? Colors.red : Colors.black,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save the review and rating here
                    print('Review: ${_rating} stars, Liked: ${_liked}');
                  }, style: ElevatedButton.styleFrom(
                  primary:
                  Colors.black, // Set the button background color to black
                ),
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
