import 'package:firebase_api_task/firebase_task/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';

  String password = '';

  bool isLogin = false;

  // TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Login Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLogin
                  ? Container()
                  : TextFormField(
                key: ValueKey('fullname'),
                decoration: InputDecoration(
                  hintText: 'Please Enter Full Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Full Name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    fullName = value!;
                  });
                },
              ),

              TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(
                  hintText: 'Please Enter Email id',
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),

              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Please Enter Password',
                ),
                validator: (value) {
                  if (value!.length < 9) {
                    return 'Enter Password of min length 9';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        isLogin ? AuthServices.signinUser(email, password, context) : AuthServices.signupUser(
                            email, password, fullName, context);
                      }
                    },
                    child: Text(isLogin ? 'Login' : 'Signup')),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin ? "Don't have an account? Signup" : "Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}