import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:fluttynotes/constants/routes.dart';
import 'package:fluttynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //late : a keyword that say the variable may not have a value now but it will
  // innit and dispose, one create when a page rendered and when it leave
  // when u decare something to be initiate, u must also dispose of it
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            //keyboardtype allow u to set the phone keyboard to use @ setup
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter password here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                //devtools.log(userCredential.toString());
                // use comma , to better formatting
                if (mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                }
                //pushnamedandremoveuntil basically remove the previous page essentially and place a new one
                // u should try to catch a specific error
                //err type
                //devtools.log(e.runtimeType);
                //err type name
                // as of 17/10/2023 it would seem all kind of wrong input are called invalid credential
              } on FirebaseAuthException catch (e) {
                devtools.log(e.code);
                if (e.code == 'user-not-found') {
                  if (mounted) {
                    await showErrorDialog(
                      context,
                      'User not found',
                    );
                  }
                } else if (e.code == 'wrong-password') {
                  if (mounted) {
                    await showErrorDialog(
                      context,
                      'Wrong credentials',
                    );
                  }
                } else {
                  if (mounted) {
                    await showErrorDialog(
                      context,
                      'Error: ${e.code}',
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Register here if not registered'))
        ],
      ),
    );
  }
}
