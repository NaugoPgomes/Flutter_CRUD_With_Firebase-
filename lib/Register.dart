import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'Login.dart';

class Register extends StatelessWidget {
  late String email;
  late String password;
  late String confirmPassword;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _form= new GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  _saveForm(context){
    _form.currentState!.save();
    Map<String, dynamic> user = {
      "email": email,
      "senha": password,
    };
    if(this.email.isNotEmpty && this.password.isNotEmpty && this.confirmPassword.isNotEmpty)
      {
        if(this.password == this.confirmPassword)
          {
            auth.createUserWithEmailAndPassword(email: this.email, password: this.password);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Conta criada com sucesso.')));
            _loginArea(context);
          }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Senha e confirmar senha precisam ser iguais.')));
          }
      }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('E-mail , senha e confirmar senha não podem estar vazios.')));
      }

  }


  _loginArea(context) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Login(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _form,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Cadastro',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 60.0,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 20,
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
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) => confirmPassword = value!,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
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
                      onPressed: () {
                        _saveForm(context);
                      },
                      color: Colors.blue,
                      child: Text(
                        'CADASTRAR',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}