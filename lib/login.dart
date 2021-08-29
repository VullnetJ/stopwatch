import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch.dart';

class Login extends StatefulWidget {
  static const route = '/login';
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   bool loggedIn = false;
  late String name;

  void _validate() {
  final form = _formKey.currentState;
  if (!form!.validate()) {
    return;
  }
  // setState(() {
  //   loggedIn = true;
  //   name = _nameController.text;
  // });
  final name = _nameController.text;
  final email = _emailController.text;

  Navigator.of(context).pushReplacementNamed(
    StopWatch.route,
    arguments: name,
  );
  } 

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(child: _buildLoginForm(),
      ),
    );
  }
  

Widget _buildSuccess() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(Icons.check, color: Colors.orangeAccent,),
      Text('Hi $name'),
  ],);
}

Widget _buildLoginForm() {
  
  return Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (text) =>
              text!.isEmpty ? 'Enter your name' : null,          
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email address'),
            validator: (text) {
              if (text!.isEmpty) {
                return 'Enter a valid address.';
              }
              final regex = RegExp('[^@]+@[^\.]+\..+');
              if (!regex.hasMatch(text)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: _validate, 
            child: Text('Log In'),
            ),
        ],
        
        
      ),
      ),

  );
}
}