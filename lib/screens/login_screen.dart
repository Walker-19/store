import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store/services/auth_api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // état de validité du formulaire
  final _formKey = GlobalKey<FormState>();

  // conserver la saisie du formulaire
  final Map<String, String?> _type = {'email': null, 'password': null};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        // associer la clé de validité au formulaire
        key: _formKey,
        child: Column(
          spacing: 20,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
              ),
              // contraintes de validation
              // value représente la saisie
              validator: (String? value) {
                return value!.isEmpty ? 'Email is incorrect' : null;
              },
              // conserver la saisie
              // value représente la saisie
              onChanged: (value) {
                _type['email'] = value;
              },
            ),
            TextFormField(
              // cacher la saisie
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.password),
              ),
              // contraintes de validation
              validator: (String? value) {
                return value!.isEmpty ? 'Password is incorrect' : null;
              },
              onChanged: (value) {
                _type['password'] = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // si le formulaire est valide
                if (_formKey.currentState!.validate()) {
                  // sauvegarder la saisie
                  _formKey.currentState!.save();

                  // inspect(_type);

                  // authentification
                  dynamic auth = AuthApiService().getAuth(_type).onError((
                    error,
                    stackTrace,
                  ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Credentials error')),
                    );
                    return {};
                  });

                  // inspect(auth);
                  // si une erreur est renvoyée
                  // inspect(auth is Error);
                  // if (auth is Error) {
                  //   // afficher un message d'erreur
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Credentials error')),
                  //   );
                  // }
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
