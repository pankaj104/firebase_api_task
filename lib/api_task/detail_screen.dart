import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String person_email_id;
  final String? person_image_url;
  final String person_first_name;
  final String person_last_name;
  DetailScreen({required this.person_email_id, required this.person_image_url, required this.person_first_name, required this.person_last_name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "First name: $person_first_name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),

              SizedBox(height: 8),

              Text("Last name: $person_last_name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
              SizedBox(height: 8),

              Text("Email: $person_email_id", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
              SizedBox(height: 8),

              Image.network(person_image_url!,),

              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}