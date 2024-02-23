import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:trace_app_3a/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  void toggleShowPassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void login() async {
    //validate email & password
    if (!formKey.currentState!.validate()) {
      return;
    }
    EasyLoading.show(status: 'Processing...');
    //sign in firebase auth
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      //navigate to home
      EasyLoading.dismiss();
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    }).catchError((error) {
      print(error);
      EasyLoading.showError('Incorrect Email and/or Password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        // margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_back.webp'),
            alignment: Alignment.bottomCenter,
            opacity: 0.5,
            // invertColors: true,
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(32),
              const Text('Enter your email address and password to login'),
              const Gap(12),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: const Text('Email address'),
                ),
                validator: (value) {
                  //string - invalid
                  if (value == null || value.isEmpty) {
                    return 'Required. Please enter your email';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email';
                  }
                  //null - valid
                  return null;
                },
              ),
              const Gap(12),
              TextFormField(
                controller: password,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: const Text('Password'),
                  suffixIcon: IconButton(
                    onPressed: toggleShowPassword,
                    icon: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  //string - invalid
                  if (value == null || value.isEmpty) {
                    return 'Required. Please enter your email';
                  }
                  //null - valid
                  return null;
                },
              ),
              const Gap(12),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
