import 'package:flutter/material.dart';
import '../functions/auth_functions.dart';

class ContributorScreen extends StatefulWidget {
  const ContributorScreen({super.key});

  @override
  State<ContributorScreen> createState() => _ContributorScreenState();
}

class _ContributorScreenState extends State<ContributorScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String restrauntName = '';
  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(login ? 'Login' : 'Signup'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!login)
                  TextFormField(
                    key: ValueKey('restrauntName'),
                    decoration: InputDecoration(
                      hintText: 'Enter Restaurant Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Restaurant Name';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        restrauntName = value!;
                      });
                    },
                  ),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please Enter a valid Email';
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
                    hintText: 'Enter Password',
                  ),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Please Enter a Password of at least 6 characters';
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
                SizedBox(height: 30),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        login
                            ? AuthServices.signinUser(email, password, context)
                            : AuthServices.signupUser(
                            email, password, restrauntName, context);
                      }
                    },
                    child: Text(login ? 'Login' : 'Signup'),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      login = !login;
                    });
                  },
                  child: Text(
                    login
                        ? "Don't have an account? Signup"
                        : "Already have an account? Login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
