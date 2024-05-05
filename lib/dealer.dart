import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:navigair/screens/user_details.dart';

class Dealer {
  static final userId = 0;
  static const String baseUrl = 'https://navigair-backend.onrender.com';

  static Future<dynamic> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error retrieving data from API');
    }
  }

  static Future<void> sendPostRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      // Convert the data to JSON format
      final body = jsonEncode(data);

      print("post: $body");

      // Send the POST request
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Check the status code to ensure the request was successful
      if (response.statusCode == 201) {
        print('POST request successful');
        print(
            'Response data: ${response.body}'); // Optionally parse the response
      } else {
        print('Failed to send POST request: ${response.statusCode}');
        print(
            'Response body: ${response.body}'); // Print the server response for debugging
        throw Exception('Failed to send POST request');
      }
    } catch (e) {
      print('Error sending POST request: $e'); // Handle exceptions
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> fetchUserData(String email) async {
    try {
      // Construct the URL with the query parameter
      final url = Uri.parse('$baseUrl/user/unit?mail=$email');

      // Send the GET request
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON data
        return json.decode(response.body);
      } else {
        print('Failed to fetch user data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching user data: $e');
      return null;
    }
  }

  static Future<void> sendPutRequest(
      String endpoint, Map<String, dynamic> data) async {
      try {
        // Convert the data to JSON format
        final body = jsonEncode(data);

        // Send the PUT request
        final response = await http.put(
          Uri.parse('$baseUrl/$endpoint'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );

        // Check the status code to ensure the request was successful
        if (response.statusCode == 200) {
          print('PUT request successful');
        } else {
          print('Failed to send PUT request: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error sending PUT request: $e');
      }
    }

  static void createNewUser(
      String email,
      String password,
      String name,
      String passport,
      String vision,
      String? age,
      String? address,
      String? birthday) {
    final newUser = {
      'mail': email,
      'pwd': password,
      'name': name,
      'passport': passport,
      'visual': vision,
    };

    if (age != null && age.isNotEmpty) {
      newUser['age'] = age;
    }

    if (address != null && address.isNotEmpty) {
      newUser['address'] = address;
    }

    if (birthday != null && birthday.isNotEmpty) {
      newUser['birthday'] = birthday;
    }

    print(newUser);

    sendPostRequest(
        'user/unit', newUser); // Send the POST request with user data
  }

  static Future<(LatLng?, String)> getServiceCoords(String service) async {
    final Position currentPos = await Geolocator.getCurrentPosition();
    String data =
        "location/places?latitude=${currentPos.latitude}&longitude=${currentPos.longitude}&string=$service";
    var response = await fetchData(data);

    var serv = response?["results"]?[0];

    LatLng? location = serv == null
        ? null
        : LatLng(serv["geometry"]["location"]["lat"],
            serv["geometry"]["location"]["lng"]);
    String name = serv["name"];

    return (location, name);

    print(
        "---------------------------------------------------------------------------------------------------------------");
    print("Answer: ${response["results"][0]["geometry"]["location"]}");
    print(
        "---------------------------------------------------------------------------------------------------------------");
  }

  static DateTime getFlightHourDeparture() {
    return DateTime.utc(2024, 5, 5, 15, 35);
  }

  static DateTime getBoardingDoorOpenHour() {
    return DateTime.utc(2024, 5, 5, 15, 5);
  }

  static String getBoardingDoor() {
    return "32B";
  }

  static LatLng getBoardingDoorNextLocation() {
    return const LatLng(41.313109, 2.015360);
  }

  static bool checkSignUp(email, password) {
    return true;
  }

  static void sendFlight(UserDetailsArguments details) {
    final user = {
      'mail': details.email,
      'pwd': details.password,
      'name': details.name,
      'passport': details.passport,
      'visual': details.vision,
      'age': details.age,
      'address': details.address,
      'birthday': details.birthday,
      'assigned_flight': details.assigned_flight,
    };
    print(user);
    sendPutRequest('user/unit', user);
  }
}
