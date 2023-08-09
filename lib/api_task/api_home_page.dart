import 'package:firebase_api_task/api_task/detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class ApiHomePage extends StatefulWidget {
  const ApiHomePage({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ApiHomePage> {
  bool dataLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataFromCache();
    apiFetchData();

    super.initState();
  }

  List<dynamic> apiDataList = [];


  void apiItemTap(int index) {
    final apiData = apiDataList[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          person_first_name: apiData['first_name'],
          person_last_name: apiData['last_name'],
          person_image_url: apiData['avatar'],
          person_email_id: apiData['email'],

        ),
      ),
    );
  }

  Future<void> apiFetchData() async {
    final url = 'https://reqres.in/api/users?page=2'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];
        setState(() {
          apiDataList = jsonData;
          dataLoading = false;
          _saveDataToCache(jsonData);
        });
      } else {
        throw Exception('Failed to load API data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout_sharp))
        ],
        title: const Text('API Data in ListView'),
      ),
      body: apiDataList.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      ):ListView.builder(
        itemCount: apiDataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => apiItemTap(index),
            title:Row(
              children: [
                Text(apiDataList[index]['first_name']),
                SizedBox(width: 2),
                Text(apiDataList[index]['last_name']),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewData, // Function to call when the button is pressed
        child: Icon(Icons.add),
      ),
    );
  }


  void _addNewData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Data Post using Post API'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              postDataToApi();
              setState(() {
                _saveDataToCache(apiDataList); // Save the updated list to cache
              });
              Navigator.pop(context);
            },
            child: Text('Post Data'),
          ),
        ],
      ),
    );
  }

  Future<void> postDataToApi() async {
    final url = 'https://reqres.in/api/users';
    final data = {
      'name': 'Pankaj Kumar',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pose Data Done is upload')));
        apiFetchData();
      } else {
        throw Exception('Failed to add new data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> _saveDataToCache(List<dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cachedData', json.encode(data));
  }


  Future<void> _fetchDataFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedData');
    if (cachedData != null) {
      final jsonData = json.decode(cachedData);
      setState(() {
        apiDataList = jsonData;
        dataLoading = false;
      });
    }
  }

}