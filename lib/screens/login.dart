import 'package:flutter/material.dart';
import 'package:navigair/dealer.dart';
import 'package:navigair/screens/user_details.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome!',
                style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              LoginFields(),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'New User? Sign Up',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFields extends StatefulWidget {
  @override
  _LoginFieldsState createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide:
                  _hasError ? BorderSide(color: Colors.red) : BorderSide(),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide:
                  _hasError ? BorderSide(color: Colors.red) : BorderSide(),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary)),
          onPressed: () async {
            bool correctLogin = false;
            Map<String, dynamic>? userData =
                await Dealer.fetchUserData(_emailController.text);
            // print(userData);
            // print(userData?["pwd"]);
            // print(_passwordController.text);
            // print(userData != null);
            // print(userData?["pwd"] == _passwordController.text);
            if (userData != null &&
                userData["pwd"] == _passwordController.text) {
              correctLogin = true;
            }
            // Simulate login validation
            if (correctLogin) {
              UserDetailsArguments args = UserDetailsArguments(
                email: userData?["mail"],
                password: userData?["pwd"],
                name: userData?["name"],
                passport: userData?["passport"],
                vision: userData?["visual_percentage"].toString(),
                age: userData?["age"].toString(),
                address: userData?["address"],
                birthday: userData?["birthday"],
                assigned_flight: userData?["assigned_flight"],
              );
              // print("login");

              if (userData?["assigned_flight"] == null) {
                Navigator.pushNamed(context, '/flight_input', arguments: args);
              } else {
                Navigator.pushNamed(context, '/start', arguments: args);
              }
            } else {
              print("has error");
              setState(() {
                _hasError = true;
              });
            }
          },
          child: Text('Log In'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
