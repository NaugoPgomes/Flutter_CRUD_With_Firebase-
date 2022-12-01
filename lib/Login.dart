

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';
import 'Register.dart';

class Login extends StatelessWidget
{

  Login({Key? key}) : super(key: key);
  late String email;
  late String password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _form= new GlobalKey<FormState>();

  _authentication(context)
  {
    _form.currentState!.save();
    auth.signInWithEmailAndPassword(
        email: this.email, password: this.password).then((value) =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _form,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 60.0,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onSaved: (value) => email = value!,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) => password = value!,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: MaterialButton(
                      onPressed: () => _authentication(context),
                      color: Colors.blue,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    color: Colors.black,
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '''Ainda não tem uma conta? ''',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  Register()))},
                        child: Text('Cadastre-se'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}