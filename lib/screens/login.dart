import 'package:flutter/material.dart';
import 'package:navigair/dealer.dart';


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
                  style: TextStyle(fontSize: 16.0, color: Colors.blue),
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
          onPressed: () {
            bool correctLogin = Dealer.checkLogin(
                _emailController.text, _passwordController.text);
            // Simulate login validation
            if (correctLogin) {
              print("login");
              // Navigate to the next screen
              Navigator.pushNamed(context, '/flight_input');
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

