import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigair/dealer.dart';

class UserDetailsArguments {
  final String email;
  final String password;
  final String? name;
  final String? passport;
  final String? vision;
  final String? age;
  final String? address;
  final String? birthday;
  final String? assigned_flight;

  UserDetailsArguments(
      {this.name,
      this.passport,
      this.vision,
      this.age,
      this.address,
      this.birthday,
      this.assigned_flight,
      required this.email,
      required this.password});
}

class UserDetailsScreen extends StatefulWidget {
  UserDetailsArguments details;

  UserDetailsScreen({required this.details});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _visionPercentageController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  // Function to check if all required fields are filled
  bool get areAllFieldsFilled {
    return _nameController.text.trim().isNotEmpty &&
        _passportController.text.trim().isNotEmpty &&
        _visionPercentageController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();

    // Add listeners to track changes and trigger a state update
    _nameController.addListener(_updateButtonState);
    _passportController.addListener(_updateButtonState);
    _visionPercentageController.addListener(_updateButtonState);
    _ageController.addListener(_updateButtonState);
    _addressController.addListener(_updateButtonState);
    _birthdayController.addListener(_updateButtonState);
  }

  // Function to update the button state
  void _updateButtonState() {
    setState(() {});
  }

  void _handleSubmit() {
    if (areAllFieldsFilled) {
      print("email:");
      print(widget.details.email);
      UserDetailsArguments args = UserDetailsArguments(
          email: widget.details.email,
          password: widget.details.password,
          name: _nameController.text.trim(),
          passport: _passportController.text.trim(),
          vision: _visionPercentageController.text.trim(),
          age: _ageController.text.trim(),
          address: _addressController.text.trim(),
          birthday: _birthdayController.text.trim());
      Dealer.createNewUser(
          widget.details.email,
          widget.details.password,
          _nameController.text.trim(),
          _passportController.text.trim(),
          _visionPercentageController.text.trim(),
          _ageController.text.trim(),
          _addressController.text.trim(),
          _birthdayController.text.trim());
      Navigator.pushNamed(context, '/flight_input', arguments: args);
      // Handle user data submission logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _passportController,
              decoration: InputDecoration(
                labelText: 'Passport',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _visionPercentageController,
              decoration: InputDecoration(
                labelText: 'Vision Percentage',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(
                labelText: 'Birthday (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 30.0), // Additional spacing before the button
            if (areAllFieldsFilled) // Show the button only if all required fields are filled
              Center(
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text('Submit'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passportController.dispose();
    _visionPercentageController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }
}
